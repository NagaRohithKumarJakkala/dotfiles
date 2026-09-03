import QtQuick

Rectangle {
    id: root

    width: 400

    height: 400

    radius: 14

    color: Qt.rgba(0.14, 0.14, 0.14, 0.7)

    border.width: 1
    border.color: "#33FFFFFF"

    Column {
        id: content

        anchors {
            fill: parent
            margins: 12
        }

        spacing: 10

        // ============================================================
        // Header
        // ============================================================

        Item {
            id: header

            width: parent.width
            height: 40

            Text {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                text: "Notifications"

                color: "white"
                font.pixelSize: 20
                font.bold: true
            }

            Row {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                spacing: 8

                // ====================================================
                // DND
                // ====================================================

                Rectangle {
                    id: dndButton

                    width: dndText.implicitWidth + 20
                    height: 32

                    radius: 10

                    color: {
                        if (NotificationManager.doNotDisturb)
                            return "#6655AA"

                        if (dndMouse.containsMouse)
                            return "#505050"

                        return "#343434"
                    }

                    border.width:
                        NotificationManager.doNotDisturb ? 1 : 0

                    border.color: "#9988DD"

                    Behavior on color {
                        ColorAnimation {
                            duration: 120
                        }
                    }

                    Text {
                        id: dndText

                        anchors.centerIn: parent

                        text: NotificationManager.doNotDisturb
                              ? "󰂛 DND"
                              : "󰂚 DND"

                        color: "#F2F2F2"
                        font.pixelSize: 13
                    }

                    MouseArea {
                        id: dndMouse

                        anchors.fill: parent

                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            NotificationManager.toggleDnd()
                        }
                    }
                }

                // ====================================================
                // Clear all
                // ====================================================

                Rectangle {
                    id: clearButton

                    width: clearText.implicitWidth + 20
                    height: 32

                    radius: 10

                    visible:
                        NotificationManager.notifications.length > 0

                    color:
                        clearMouse.containsMouse
                        ? "#505050"
                        : "#343434"

                    Behavior on color {
                        ColorAnimation {
                            duration: 120
                        }
                    }

                    Text {
                        id: clearText

                        anchors.centerIn: parent

                        text: "Clear All"

                        color: "#F2F2F2"
                        font.pixelSize: 13
                    }

                    MouseArea {
                        id: clearMouse

                        anchors.fill: parent

                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            NotificationManager.clear()
                        }
                    }
                }
            }
        }

        // ============================================================
        // Divider
        // ============================================================

        Rectangle {
            id: divider

            width: parent.width
            height: 1

            color: "#33FFFFFF"
        }

        // ============================================================
        // Fixed notification area
        // ============================================================

        Item {
            id: notificationArea

            width: parent.width

            // Take all remaining space in the 350px card.
            height: content.height
                    - header.height
                    - divider.height
                    - content.spacing * 2

            // ========================================================
            // Empty state
            // ========================================================

            Column {
                id: emptyState

                anchors.centerIn: parent

                visible:
                    NotificationManager.notifications.length === 0

                spacing: 10

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: "󰂚"

                    color: "#777777"
                    font.pixelSize: 36
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter

                    text:
                        NotificationManager.doNotDisturb
                        ? "Do Not Disturb"
                        : "No notifications"

                    color: "#999999"
                    font.pixelSize: 15
                }
            }

            // ========================================================
            // Scrollable notifications
            // ========================================================

            ListView {
                id: notificationList

                anchors.fill: parent

                visible:
                    NotificationManager.notifications.length > 0

                model: NotificationManager.groups

                spacing: 16
                clip: true

                boundsBehavior: Flickable.StopAtBounds

                // Smooth scrolling
                flickDeceleration: 1500
                maximumFlickVelocity: 2500

                delegate: NotificationGroup {
                    width: notificationList.width

                    group:
                        (typeof modelData !== "undefined")
                        ? modelData
                        : model
                }
            }
        }
    }
}
