import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
    id: root
    focusable: true

    anchors.top: true
    anchors.right: true

    implicitWidth: 420
    implicitHeight: 120

    margins{
        top:10
        right:20
    }

    color: "transparent"

    Shortcut {
            sequence: "Escape"
            onActivated: Qt.quit()
    }

    Rectangle {
        anchors.fill: parent
        radius: 15
        color: Qt.rgba(14/255, 15/255, 18/255, 0.8)

        Row {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 12

            Text {
                id: time

                text: Qt.formatDateTime(new Date(), "HH:mm")
                color: "white"
                font.pixelSize: 40
                font.bold: true

                anchors.verticalCenter: parent.verticalCenter
            }

            Column {
                id: dateColumn

                anchors.verticalCenter: time.verticalCenter
                spacing: 2

                Text {
                    id: dateText

                    text: Qt.formatDateTime(new Date(), "d MMM")
                    color: "#8e93a0"
                    font.pixelSize: 15
                }

                Text {
                    id: dayText

                    text: Qt.formatDateTime(new Date(), "ddd")
                    color: "#8e93a0"
                    font.pixelSize: 15
                }
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true

            onTriggered: {
                const now = new Date()
                time.text = Qt.formatDateTime(now, "HH:mm")
                dateText.text = Qt.formatDateTime(now, "d MMM")
                dayText.text = Qt.formatDateTime(now, "ddd")
            }
        }
    }
}
