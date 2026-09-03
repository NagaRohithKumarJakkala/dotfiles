import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property bool bluetoothEnabled: false
    property string deviceName: ""
    property bool busy: false

    implicitWidth: 170
    implicitHeight: 54

    Rectangle {
        anchors.fill: parent
        radius: 12

        color: root.bluetoothEnabled
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

                text: root.bluetoothEnabled
                      ? "󰂯"
                      : "󰂲"

                color: root.bluetoothEnabled
                       ? "#FFFFFF"
                       : "#AAAAAA"

                font.pixelSize: 21
            }

            Column {
                anchors.verticalCenter: parent.verticalCenter

                spacing: 1

                Text {
                    text: "Bluetooth"

                    color: "#FFFFFF"
                    font.pixelSize: 14
                    font.bold: true
                }

                Text {
                    text: {
                        if (!root.bluetoothEnabled)
                            return "Off"

                        if (root.deviceName !== "")
                            return root.deviceName

                        return "On"
                    }

                    color: "#AAAAAA"
                    font.pixelSize: 11

                    width: 100
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

                toggleBluetooth.command = [
                    "bluetoothctl",
                    "power",
                    root.bluetoothEnabled
                        ? "off"
                        : "on"
                ]

                toggleBluetooth.running = true
            }
        }
    }

    // ================================================================
    // Bluetooth state
    // ================================================================

    Process {
        id: getBluetoothState

        command: [
            "bluetoothctl",
            "show"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                root.bluetoothEnabled =
                    text.indexOf("Powered: yes") !== -1
            }
        }
    }

    // ================================================================
    // Connected device
    // ================================================================

    Process {
        id: getConnectedDevice

        command: [
            "bluetoothctl",
            "devices",
            "Connected"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                root.deviceName = ""

                const line = text.trim()
                    .split("\n")[0]

                // Device AA:BB:CC:DD:EE:FF Device Name
                const match =
                    line.match(
                        /^Device\s+\S+\s+(.+)$/
                    )

                if (match)
                    root.deviceName = match[1]
            }
        }
    }

    // ================================================================
    // Toggle Bluetooth
    // ================================================================

    Process {
        id: toggleBluetooth

        onExited: {
            root.busy = false
            refreshTimer.restart()
        }
    }

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
        if (!getBluetoothState.running)
            getBluetoothState.running = true

        if (!getConnectedDevice.running)
            getConnectedDevice.running = true
    }
}
