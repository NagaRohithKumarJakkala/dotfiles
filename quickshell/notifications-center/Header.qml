import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

PanelWindow {
    id: root

    anchors.top: true
    anchors.right: true

    implicitWidth: 420
    implicitHeight: 120

    margins {
        top: 10
        right: 20
    }

    color: "transparent"

    visible: false

    property date now: new Date()

    Rectangle {
        anchors.fill: parent
        radius: 15
        color: Qt.rgba(14/255, 15/255, 18/255, 0.8)

        Row {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 12

            Text {
                text: Qt.formatDateTime(root.now, "HH:mm")
                color: "white"
                font.pixelSize: 40
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
            }

            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 2

                Text {
                    text: Qt.formatDateTime(root.now, "d MMM")
                    color: "#8e93a0"
                    font.pixelSize: 15
                }

                Text {
                    text: Qt.formatDateTime(root.now, "ddd")
                    color: "#8e93a0"
                    font.pixelSize: 15
                }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.now = new Date()
    }

    IpcHandler {
        target: "notifications"

        function toggle(): void {
            root.visible = !root.visible
        }

        function show(): void {
            root.visible = true
        }

        function hide(): void {
            root.visible = false
        }

        function isVisible(): bool {
            return root.visible
        }
    }
}
