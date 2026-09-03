import QtQuick
import Quickshell
import Quickshell.Widgets

Column {
    id: root

    property var group: ({ appName: "", appIcon: "", notifications: [] })

    property bool expanded: false

    width: 360
    spacing: 8

    // ============================================================
    // Group header
    // ============================================================

    Rectangle {
        id: header

        width: parent.width
        height: 32

        radius: 8

        color: headerMouse.containsMouse
               ? "#303030"
               : "transparent"

        Behavior on color {
            ColorAnimation {
                duration: 120
            }
        }

        Row {
            anchors {
                left: parent.left
                right: parent.right
                verticalCenter: parent.verticalCenter
            }

            spacing: 8

            // App icon
            IconImage {
                id: groupIcon

                property string resolvedSource: (function() {
                    let icon = group ? (group.appIcon || "") : ""

                    return NotificationManager.resolveIconSource(icon)
                })()

                source: resolvedSource

                implicitWidth: 20
                implicitHeight: 20

                visible: resolvedSource !== "" && (typeof status === "undefined" || status !== Image.Error)

                onStatusChanged: {
                    if (status === Image.Error) {
                        source = ""
                        visible = false
                    }
                }
            }

            // App name
            Text {
                text: group.appName

                color: "#DDDDDD"

                font.pixelSize: 14
                font.bold: true

                anchors.verticalCenter: parent.verticalCenter
            }

            // Notification count
            Rectangle {
                width: countText.implicitWidth + 12
                height: 20

                radius: 10

                visible:
                    group.notifications.length > 1

                color: "#404040"

                anchors.verticalCenter: parent.verticalCenter

                Text {
                    id: countText

                    anchors.centerIn: parent

                    text: group.notifications.length

                    color: "#CCCCCC"

                    font.pixelSize: 11
                }
            }

            // Push arrow to the right
        }

Rectangle {
    id: clearGroupButton
    z:2

    anchors {
        right: expandArrow.visible
               ? expandArrow.left
               : parent.right

        rightMargin: 8
        verticalCenter: parent.verticalCenter
    }

    width: 24
    height: 24

    radius: 7

    color: clearGroupMouse.containsMouse
           ? "#505050"
           : "transparent"

    Behavior on color {
        ColorAnimation {
            duration: 120
        }
    }

    Text {
        anchors.centerIn: parent

        text: "󰅖"

        color: clearGroupMouse.containsMouse
               ? "#FFFFFF"
               : "#AAAAAA"

        font.pixelSize: 14
    }

    MouseArea {
        id: clearGroupMouse

        anchors.fill: parent

        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            NotificationManager.clearGroup(root.group)
        }
    }
}


        // Expand/collapse arrow
        Text {
            id: expandArrow
            z:2
    anchors {
        right: parent.right
        rightMargin: 8
        verticalCenter: parent.verticalCenter
    }

    visible:
        group.notifications.length > 1

    text: root.expanded
          ? "󰅀"
          : "󰅂"

    color: "#AAAAAA"

    font.pixelSize: 16
}

        MouseArea {
            id: headerMouse

            anchors.fill: parent

            hoverEnabled: true

            cursorShape:
                group.notifications.length > 1
                ? Qt.PointingHandCursor
                : Qt.ArrowCursor

            onClicked: {
                if (group.notifications.length > 1) {
                    root.expanded = !root.expanded
                }
            }
        }
    }

    // ============================================================
    // Latest notification
    //
    // Always visible.
    // ============================================================

    NotificationHistoryCard {
        id: latestNotification

        width: root.width

        entry: group.notifications[0]

        onRemoveRequested: {
            NotificationManager.remove(
                group.notifications[0]
            )
        }
    }

    // ============================================================
    // Older notifications
    // ============================================================
    //

Item {
    id: olderContainer

    width: parent.width

    height: root.expanded
            ? olderNotifications.implicitHeight
            : 0

    opacity: root.expanded ? 1 : 0

    clip: true

    Behavior on height {
        NumberAnimation {
            duration: 220
            easing.type: Easing.OutCubic
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 160
            easing.type: Easing.OutQuad
        }
    }

    Column {
        id: olderNotifications

        width: parent.width

        spacing: 8

        Repeater {
            model: {
                let result = []

                for (
                    let i = 1;
                    i < root.group.notifications.length;
                    i++
                ) {
                    result.push(
                        root.group.notifications[i]
                    )
                }

                return result
            }

            delegate: NotificationHistoryCard {
                required property var modelData

                width: olderNotifications.width

                entry: modelData

                onRemoveRequested: {
                    NotificationManager.remove(
                        modelData
                    )
                }
            }
        }
    }
}

    
}
