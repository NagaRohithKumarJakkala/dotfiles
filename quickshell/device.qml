import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
    id: window
    implicitWidth: 280
    implicitHeight: 280
    color: "#1e1e2e" // Dark background

    // Grab keyboard focus immediately upon launch so shortcuts work
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    // Close the widget when ESC is pressed
    Shortcut {
        sequence: "Escape"
        onActivated: Qt.quit()
    }

    // Variables loaded dynamically from .env
    property string headphonesMac: ""
    property string keyboardMac: ""
    property string phoneId: ""

    // Load and watch the .env file in the shell directory
    FileView {
        id: envLoader
        path: Quickshell.shellDir + "/.env"
        watchChanges: true

        onLoaded: {
            let fileContent = envLoader.text()
            if (!fileContent) return

            let lines = fileContent.split("\n")
            for (let line of lines) {
                let trimmed = line.trim()
                if (trimmed.length === 0 || trimmed.startsWith("#")) continue

                let parts = trimmed.split("=")
                if (parts.length >= 2) {
                    let key = parts[0].trim()
                    let value = parts.slice(1).join("=").trim().replace(/^["']|["']$/g, "")

                    if (key === "HEADPHONES_MAC") window.headphonesMac = value
                    else if (key === "KEYBOARD_MAC") window.keyboardMac = value
                    else if (key === "PHONE_ID") window.phoneId = value
                }
            }
        }
    }

    // Command executor for disconnect actions
    Process {
        id: cmdRunner
    }

    // Reusable Device Card
    component DeviceCard : Rectangle {
        id: card
        property string iconText: ""
        property string deviceName: ""
        property string targetId: ""
        property string checkCmd: ""
        property string disconnectCmd: ""
        property bool isConnected: false

        // Low opacity when disconnected, full opacity when connected
        opacity: isConnected ? 1.0 : 0.35

        Behavior on opacity {
            NumberAnimation { duration: 250 }
        }

        Layout.fillWidth: true
        Layout.fillHeight: true
        color: "#313244"
        radius: 12

        // Status check command
        Process {
            id: statusProc
            command: ["sh", "-c", card.checkCmd]
            stdout: StdioCollector {
                onStreamFinished: {
                    card.isConnected = text.trim().length > 0
                }
            }
        }

        // Poll status every 3 seconds once checkCmd is set
        Timer {
            interval: 3000
            running: card.checkCmd !== ""
            repeat: true
            triggeredOnStart: true
            onTriggered: {
                if (!statusProc.running && card.checkCmd !== "") {
                    statusProc.running = true
                }
            }
        }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 6

            // Device Icon (Nerd Font)
            Text {
                text: card.iconText
                font.pixelSize: 28
                color: card.isConnected ? "#cdd6f4" : "#6c7086"
                Layout.alignment: Qt.AlignHCenter
            }

            // Device Label
            Text {
                text: card.deviceName
                font.pixelSize: 12
                font.bold: true
                color: card.isConnected ? "#a6adc8" : "#6c7086"
                Layout.alignment: Qt.AlignHCenter
            }

            // Action / Status Button
            Button {
                text: card.isConnected ? "Disconnect" : "Not Connected"
                enabled: card.isConnected && card.disconnectCmd !== ""
                Layout.alignment: Qt.AlignHCenter

                background: Rectangle {
                    implicitWidth: 92
                    implicitHeight: 24
                    color: card.isConnected
                        ? (parent.down ? "#f38ba8" : "#e78284")
                        : "#45475a"
                    radius: 6
                }

                contentItem: Text {
                    text: parent.text
                    color: card.isConnected ? "#11111b" : "#a6adc8"
                    font.pixelSize: 10
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    if (card.isConnected && card.disconnectCmd !== "") {
                        cmdRunner.command = ["sh", "-c", card.disconnectCmd]
                        cmdRunner.running = true
                        statusProc.running = true
                    }
                }
            }
        }
    }

    // 2x2 Grid Layout
    GridLayout {
        anchors.fill: parent
        anchors.margins: 12
        columns: 2
        rows: 2
        columnSpacing: 10
        rowSpacing: 10

        // Slot 1: Headphones
        DeviceCard {
            iconText: "󰋋"
            deviceName: "Headphones"
            targetId: window.headphonesMac
            checkCmd: targetId ? `bluetoothctl info ${targetId} | grep 'Connected: yes'` : ""
            disconnectCmd: targetId ? `bluetoothctl disconnect ${targetId}` : ""
        }

        // Slot 2: Keyboard
        DeviceCard {
            iconText: "󰌌"
            deviceName: "Keyboard"
            targetId: window.keyboardMac
            checkCmd: targetId ? `bluetoothctl info ${targetId} | grep 'Connected: yes'` : ""
            disconnectCmd: targetId ? `bluetoothctl disconnect ${targetId}` : ""
        }

        // Slot 3: Phone (KDE Connect)
        DeviceCard {
            iconText: "󰄜"
            deviceName: "Phone"
            targetId: window.phoneId
            checkCmd: targetId ? `kdeconnect-cli -a | grep ${targetId}` : ""
            disconnectCmd: targetId ? `kdeconnect-cli -d ${targetId} --unpair` : ""
        }

        // Slot 4: Bluetooth Global Switch
        DeviceCard {
            iconText: "󰂯"
            deviceName: "Bluetooth"
            targetId: "global"
            checkCmd: "bluetoothctl show | grep 'Powered: yes'"
            disconnectCmd: "bluetoothctl power off"
        }
    }
}
