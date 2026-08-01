import QtQuick
import Quickshell

PanelWindow {
    id: root

    visible: NotificationManager.centerOpen

    anchors {
        top: true
        right: true
    }

    margins {
        top: 12
        right: 12
    }

    implicitWidth: 400
    implicitHeight: 600

    color: "transparent"

    Rectangle {
        id: background

        anchors.fill: parent

        radius: 20
        color: Qt.rgba(0.10, 0.10, 0.10, 0.95)

        border.width: 1
        border.color: "#44FFFFFF"

        Column {
            anchors {
                fill: parent
                margins: 14
            }

            spacing: 12

            // Header
            Item {
                width: parent.width
                height: 40

                Text {
                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                    }

                    text: "Notifications"

                    color: "white"

                    font.pixelSize: 20
                    font.bold: true
                }

                Rectangle {
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }

                    width: clearText.implicitWidth + 24
                    height: 32

                    radius: 10

                    visible:
                        NotificationManager.notifications.length > 0

                    color: clearMouse.containsMouse
                           ? "#505050"
                           : "#343434"

                    Text {
                        id: clearText

                        anchors.centerIn: parent

                        text: "Clear All"
                        color: "#F2F2F2"
                    }

                    MouseArea {
                        id: clearMouse

                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            NotificationManager.clear()
                        }
                    }
                }
            }

            // Divider
            Rectangle {
                width: parent.width
                height: 1

                color: "#33FFFFFF"
            }

            // Notification area
            Item {
                width: parent.width
                height: parent.height - 65

                // Empty state
                Text {
                    anchors.centerIn: parent

                    visible:
                        NotificationManager.notifications.length === 0

                    text: "No notifications"

                    color: "#999999"

                    font.pixelSize: 15
                }

                // History
                ListView {
                    id: notificationList

                    anchors.fill: parent

                    visible:
                        NotificationManager.notifications.length > 0

                    model:
                        NotificationManager.notifications

                    spacing: 10
                    clip: true

                    boundsBehavior:
                        Flickable.StopAtBounds

                    delegate: NotificationHistoryCard {
                        required property var modelData

                        entry: modelData

                        width: notificationList.width

                        onRemoveRequested: {
                            NotificationManager.remove(modelData)
                        }
                    }
                }
            }
        }
    }
}
