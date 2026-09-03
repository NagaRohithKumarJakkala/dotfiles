import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root

    property var server

    WlrLayershell.layer: WlrLayer.Overlay

    anchors {
        top: true
        right: true
    }

    margins {
        top: 12
        right: 12
    }

    implicitWidth: 380
    implicitHeight: popupColumn.implicitHeight

    color: "transparent"

    Column {
        id: popupColumn

        anchors.top: parent.top
        anchors.right: parent.right

        spacing: 10

        Repeater {
            model: server ? server.trackedNotifications : []

            delegate: NotificationPopup {
                notification: modelData
            }
        }
    }
}
