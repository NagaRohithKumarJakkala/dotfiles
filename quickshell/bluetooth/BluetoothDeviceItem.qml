import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Bluetooth

Rectangle {
    id: root

    required property var device

    width: parent.width
    height: 65

    radius: 10

    color: device.connected
        ? "#303030"
        : "#282828"

    Row {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 12

        // Device icon
        Image {
            width: 32
            height: 32

            anchors.verticalCenter: parent.verticalCenter

            source: Quickshell.iconPath(device.icon)

            fillMode: Image.PreserveAspectFit
        }

        // Device information
        Column {
            width: parent.width - 150

            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            Text {
                width: parent.width

                text: device.name || device.deviceName

                color: "white"
                font.pixelSize: 15

                elide: Text.ElideRight
            }
            Row{

            Text {
                text: device.connected
                    ? "Connected    "
                    : device.paired
                    ? "Paired   "
                        : "Available    "

                color: "#aaaaaa"
                font.pixelSize: 12
            }
            // Battery
        Text {

            text: device.batteryAvailable
                ? Math.round(device.battery * 100) + "%"
                : ""

            color: "#cccccc"
            font.pixelSize: 12
        }
    }
        }

        

        // Connect / Disconnect
        Button {
            anchors.verticalCenter: parent.verticalCenter

            text: device.connected
                ? "Disconnect"
                : "Connect"

            onClicked: {
                device.connected = !device.connected
            }
        }
    }
}
