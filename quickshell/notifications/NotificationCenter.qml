import QtQuick
import Quickshell

PanelWindow {
    id: root

    visible: NotificationManager.centerOpen || panel.closing
    focusable: NotificationManager.centerOpen

    anchors {
        top: true
        right: true
    }

    margins {
        top: 10
        right: 10
    }

    implicitWidth: 400
    implicitHeight: 800

    color: "transparent"

    Rectangle {
        id: panel

        property bool closing: false

        anchors.fill: parent
        focus: NotificationManager.centerOpen

        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Escape) {
                NotificationManager.closeCenter()
                event.accepted = true
            }
        }

        radius: 20
        color: Qt.rgba(0.10, 0.10, 0.10, 0.5)

        border.width: 1
        border.color: "#44FFFFFF"

        transform: Translate {
            id: slideTransform

            x: root.width + 20

            Behavior on x {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }
        }

        opacity: 0

        Behavior on opacity {
            NumberAnimation {
                duration: 180
                easing.type: Easing.OutQuad
            }
        }

        Column {
            id: mainColumn

            anchors {
                fill: parent
                margins: 14
            }

            spacing: 12

            // ============================================================
// Connectivity
// ============================================================

Rectangle {
    width: parent.width
    implicitHeight: connectivityRow.implicitHeight + 20

    radius: 14

    color: Qt.rgba(0.14, 0.14, 0.14, 0.7)

    border.width: 1
    border.color: "#33FFFFFF"

    Row {
        id: connectivityRow

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top

            margins: 10
        }

        spacing: 10

        WifiControl {
            width: (
                connectivityRow.width
                - connectivityRow.spacing
            ) / 2
        }

        BluetoothControl {
            width: (
                connectivityRow.width
                - connectivityRow.spacing
            ) / 2
        }
    }
}

            Rectangle {
                width: parent.width
                radius: 14

                color: Qt.rgba(0.14, 0.14, 0.14, 0.7)
                border.width: 1
                border.color: "#33FFFFFF"

                implicitHeight: controlsColumn.implicitHeight + 20

                Column {
                    id: controlsColumn

                    anchors {
                        fill: parent
                        margins: 10
                    }

                    spacing: 10

                    VolumeControl {
                        width: parent.width
                    }

                    BrightnessControl {
                        width: parent.width
                    }
                }
            }

             MediaSection {
                width: parent.width
            }

            NotificationsView {
                width: parent.width
            }
        }
    }

    Connections {
        target: NotificationManager

        function onCenterOpenChanged() {
            if (NotificationManager.centerOpen) {
                root.openPanel()
            } else {
                root.closePanel()
            }
        }
    }

    Component.onCompleted: {
        if (NotificationManager.centerOpen) {
            openPanel()
        }
    }

    function openPanel() {
        panel.closing = false
        closeTimer.stop()

        openTimer.start()
    }

    function closePanel() {
        if (panel.closing)
            return

        openTimer.stop()

        panel.closing = true

        slideTransform.x = root.width + 20
        panel.opacity = 0

        closeTimer.start()
    }

    Timer {
        id: openTimer

        interval: 1
        repeat: false

        onTriggered: {
            slideTransform.x = 0
            panel.opacity = 1
        }
    }

    Timer {
        id: closeTimer

        interval: 250
        repeat: false

        onTriggered: {
            panel.closing = false
        }
    }
}
