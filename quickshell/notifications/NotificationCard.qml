import QtQuick
import Quickshell
import Quickshell.Widgets

Rectangle {
    id: cardRoot

    property var notification
    signal dismissRequested()

    readonly property string appNameText: notification && notification.appName ? notification.appName : ""
    readonly property string summaryText: notification && notification.summary ? notification.summary : ""
    readonly property string bodyText: notification && notification.body ? notification.body : ""
    readonly property var actionList: notification ? notification.actions : []

    readonly property int horizontalPadding: 12
    readonly property int verticalPadding: 12

    property bool hovered: false

    width: 360
    implicitWidth: width
    implicitHeight: content.childrenRect.height + verticalPadding * 2
    height: implicitHeight

    radius: 16

    color: hovered
       ? Qt.rgba(0.176, 0.176, 0.176, 0.7)
       : Qt.rgba(0.145, 0.145, 0.145, 0.7)

    border.width: 1
    border.color: "#66FFFFFF"

    layer.enabled: true
    layer.smooth: true

    Behavior on color {
        ColorAnimation {
            duration: 120
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.RightButton

        onEntered: cardRoot.hovered = true
        onExited: cardRoot.hovered = false
        onClicked: function(mouse) {
            if (mouse.button === Qt.RightButton) {
                cardRoot.dismissRequested()
            }
        }
    }

    Column {
        id: content

        x: horizontalPadding
        y: verticalPadding

        width: parent.width - horizontalPadding * 2
        spacing: 8

        Row {
    width: parent.width
    spacing: 12

    IconImage {
                id: appIcon

                source: {
                    let icon = (notification && notification.image && notification.image !== "")
                        ? notification.image
                        : (notification && notification.appIcon ? notification.appIcon : "")

                    return NotificationManager.resolveIconSource(icon)
                }

    implicitWidth: 32
    implicitHeight: 32

    visible: source !== ""
}

    Column {
        width: parent.width
               - (appIcon.visible ? appIcon.width + 12 : 0)

        spacing: 4

        Text {
            visible: appNameText.length > 0
            width: parent.width

            text: appNameText

            color: "#E0E0E0"
            font.bold: true
            elide: Text.ElideRight
        }

        Text {
            visible: summaryText.length > 0
            width: parent.width

            text: summaryText

            color: "white"

            font.pixelSize: 16
            font.bold: true

            wrapMode: Text.Wrap
        }
    }
}

        Text {
            visible: bodyText.length > 0
            width: parent.width

            text: bodyText

            color: "#F2F2F2"

            wrapMode: Text.Wrap
        }

        Flow {
            width: parent.width
            height: childrenRect.height

            visible: actionList.length > 0
            spacing: 8

            Repeater {
                model: actionList

                delegate: Rectangle {
                    required property var modelData

                    readonly property bool hasAction:
                        modelData !== null && modelData !== undefined

                    width: Math.min(parent.width, actionLabel.implicitWidth + 24)
                    height: 36

                    radius: 10

                    color: buttonMouse.containsMouse
                           ? "#505050"
                           : "#343434"

                    border.width: 1
                    border.color: "#4b4b4b"

                    Behavior on color {
                        ColorAnimation {
                            duration: 120
                        }
                    }

                    Text {
                        id: actionLabel

                        anchors.centerIn: parent

                        text: hasAction && modelData.text ? modelData.text : ""

                        color: "#FAFAFA"

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }

                    MouseArea {
                        id: buttonMouse

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            if (hasAction && modelData.invoke) {
                                modelData.invoke()
                            }
                        }
                    }
                }
            }
        }
    }
}
