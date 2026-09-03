import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property bool wifiEnabled: false
    property string ssid: ""
    property bool busy: false

    implicitWidth: 170
    implicitHeight: 54

    Rectangle {
        anchors.fill: parent
        radius: 12

        color: root.wifiEnabled
               ? Qt.rgba(1, 1, 1, 0.14)
               : Qt.rgba(1, 1, 1, 0.06)

        Behavior on color {
            ColorAnimation {
                duration: 120
            }
        }

        Row {
            anchors {
                fill: parent
                leftMargin: 14
                rightMargin: 14
            }

            spacing: 12

            Text {
                anchors.verticalCenter: parent.verticalCenter

                text: root.wifiEnabled ? "󰤨" : "󰤭"

                color: root.wifiEnabled
                       ? "#FFFFFF"
                       : "#AAAAAA"

                font.pixelSize: 21
            }

            Column {
                anchors.verticalCenter: parent.verticalCenter

                spacing: 1

                Text {
                    text: "Wi-Fi"

                    color: "#FFFFFF"
                    font.pixelSize: 14
                    font.bold: true
                }

                Text {
                    text: {
                        if (!root.wifiEnabled)
                            return "Off"

                        if (root.ssid !== "")
                            return root.ssid

                        return "Not connected"
                    }

                    color: "#AAAAAA"
                    font.pixelSize: 11

                    width: 105
                    elide: Text.ElideRight
                }
            }
        }

        MouseArea {
            anchors.fill: parent

            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                if (root.busy)
                    return

                root.busy = true

                toggleWifi.command = [
                    "nmcli",
                    "radio",
                    "wifi",
                    root.wifiEnabled ? "off" : "on"
                ]

                toggleWifi.running = true
            }
        }
    }

    // ================================================================
    // Get Wi-Fi radio state
    // ================================================================

    Process {
        id: getWifiState

        command: [
            "nmcli",
            "-t",
            "-f",
            "WIFI",
            "general"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                root.wifiEnabled =
                    text.trim().toLowerCase() === "enabled"
            }
        }
    }

    // ================================================================
    // Get currently connected SSID
    // ================================================================

    Process {
        id: getSsid

        command: [
            "nmcli",
            "-t",
            "-f",
            "ACTIVE,SSID",
            "dev",
            "wifi"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                root.ssid = ""

                const lines = text.trim().split("\n")

                for (let i = 0; i < lines.length; i++) {
                    if (lines[i].startsWith("yes:")) {
                        root.ssid = lines[i].substring(4)
                        break
                    }
                }
            }
        }
    }

    // ================================================================
    // Toggle Wi-Fi
    // ================================================================

    Process {
        id: toggleWifi

        onExited: {
            root.busy = false

            refreshTimer.restart()
        }
    }

    // Give NetworkManager a moment to update.
    Timer {
        id: refreshTimer

        interval: 300
        repeat: false

        onTriggered: root.refresh()
    }

    Timer {
        interval: 2000
        repeat: true
        running: true

        onTriggered: root.refresh()
    }

    Component.onCompleted: root.refresh()

    function refresh() {
        if (!getWifiState.running)
            getWifiState.running = true

        if (!getSsid.running)
            getSsid.running = true
    }
}
