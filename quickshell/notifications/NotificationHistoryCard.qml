import QtQuick
import Quickshell
import Quickshell.Widgets

Rectangle {
    id: root

    required property var entry

    signal removeRequested()

    readonly property int horizontalPadding: 12
    readonly property int verticalPadding: 12

    width: 360

    implicitHeight: content.implicitHeight + verticalPadding * 2
    height: implicitHeight

    radius: 16

    color: mouseArea.containsMouse
           ? Qt.rgba(0.176, 0.176, 0.176, 0.8)
           : Qt.rgba(0.145, 0.145, 0.145, 0.8)

    border.width: 1
    border.color: "#44FFFFFF"

    Behavior on color {
        ColorAnimation {
            duration: 120
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.RightButton

        onClicked: function(mouse) {
            if (mouse.button === Qt.RightButton) {
                root.removeRequested()
            }
        }
    }

    Column {
        id: content

        x: root.horizontalPadding
        y: root.verticalPadding

        width: parent.width - root.horizontalPadding * 2

        spacing: 8

        Row {
            width: parent.width
            spacing: 12

            IconImage {
                id: appIcon

                source: {
                    let icon = entry.image || entry.appIcon || ""

                    if (!icon)
                        return ""

                    if (icon.startsWith("/") ||
                        icon.startsWith("file://")) {
                        return icon
                    }

                    return Quickshell.iconPath(icon, "")
                }

                implicitWidth: 32
                implicitHeight: 32

                visible: source !== ""
            }

            Column {
                width: parent.width
                       - (appIcon.visible
                          ? appIcon.width + parent.spacing
                          : 0)

                spacing: 4

                Text {
                    width: parent.width
                    visible: entry.appName.length > 0

                    text: entry.appName

                    color: "#E0E0E0"
                    font.bold: true

                    elide: Text.ElideRight
                }

                Text {
                    width: parent.width
                    visible: entry.summary.length > 0

                    text: entry.summary

                    color: "white"

                    font.pixelSize: 16
                    font.bold: true

                    wrapMode: Text.Wrap
                }
            }
        }

        Text {
            width: parent.width
            visible: entry.body.length > 0

            text: entry.body

            color: "#F2F2F2"

            wrapMode: Text.Wrap
        }
    }
}
