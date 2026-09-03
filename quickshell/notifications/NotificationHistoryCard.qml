import QtQuick
import Quickshell
import Quickshell.Widgets

Rectangle {
    id: root

    required property var entry

    signal removeRequested()

    property bool removing: false

    readonly property int horizontalPadding: 12
    readonly property int verticalPadding: 12
    property int timeTick: 0

    width: 360

    implicitHeight: removing
                    ? 0
                    : content.implicitHeight + verticalPadding * 2

    height: implicitHeight

    radius: 16

    color: mouseArea.containsMouse
           ? Qt.rgba(0.176, 0.176, 0.176, 0.8)
           : Qt.rgba(0.145, 0.145, 0.145, 0.8)

    border.width: 1
    border.color: "#44FFFFFF"

    opacity: 1

    transform: Translate {
        id: removeTransform

        x: 0

        Behavior on x {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 160
            easing.type: Easing.OutQuad
        }
    }

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: 120
        }
    }

    clip: true

    function removeAnimated() {
        if (removing)
            return

        removing = true

        removeTransform.x = root.width + 20
        opacity = 0

        removeTimer.start()
    }
    function relativeTime(date) {
    if (!date)
        return ""

    const now = new Date()
    const seconds = Math.floor((now.getTime() - date.getTime()) / 1000)

    if (seconds < 60)
        return "now"

    const minutes = Math.floor(seconds / 60)

    if (minutes < 60)
        return minutes + "m"

    const hours = Math.floor(minutes / 60)

    if (hours < 24)
        return hours + "h"

    const days = Math.floor(hours / 24)

    if (days < 7)
        return days + "d"

    return Qt.formatDate(date, "dd MMM")
}

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        hoverEnabled: true
        acceptedButtons: Qt.RightButton

        onClicked: function(mouse) {
            if (mouse.button === Qt.RightButton) {
                root.removeAnimated()
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

                        // Resolve source once into a local property so we can
                        // react to load failures and avoid repeated requests.
                        property string resolvedSource: (function() {
                            let icon = entry ? (entry.image || entry.appIcon || "") : ""

                            return NotificationManager.resolveIconSource(icon)
                        })()

                        source: resolvedSource

                implicitWidth: 32
                implicitHeight: 32

                visible: resolvedSource !== "" && (typeof status === "undefined" || status !== Image.Error)

                onStatusChanged: {
                    if (status === Image.Error) {
                        // Avoid retrying a broken provider URL repeatedly.
                        source = ""
                        visible = false
                    }
                }
            }

Column {
    width: parent.width
           - (appIcon.visible
              ? appIcon.width + parent.spacing
              : 0)

    spacing: 4

    Row {
        width: parent.width
        spacing: 8

        Text {
            width: parent.width
                   - timeText.implicitWidth
                   - parent.spacing

            visible: entry.appName.length > 0

            text: entry.appName

            color: "#E0E0E0"

            font.bold: true

            elide: Text.ElideRight
        }

        Text {
            id: timeText

            // timeTick forces this binding to update every minute.
            text: {
                root.timeTick
                return root.relativeTime(entry.time)
            }

            color: "#888888"

            font.pixelSize: 11
        }
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


Flow {
    id: actionsFlow

    width: parent.width
    height: childrenRect.height

    visible: entry.actions
             && entry.actions.length > 0

    spacing: 8

    Repeater {
        model: entry.actions ?? []

        delegate: Rectangle {
            required property var modelData

                    readonly property bool hasAction:
                        modelData !== null && modelData !== undefined

            width: Math.min(
                actionsFlow.width,
                actionLabel.implicitWidth + 24
            )

            height: 34

            radius: 9

            color: actionMouse.containsMouse
                   ? "#505050"
                   : "#343434"

            border.width: 1
            border.color: "#4B4B4B"

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

                font.pixelSize: 13

                horizontalAlignment:
                    Text.AlignHCenter

                verticalAlignment:
                    Text.AlignVCenter

                elide: Text.ElideRight
            }

            MouseArea {
                id: actionMouse

                anchors.fill: parent

                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                acceptedButtons: Qt.LeftButton

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

    Timer {
        id: removeTimer

        interval: 200
        repeat: false

        onTriggered: {
            root.removeRequested()
        }
    }
    Timer {
    interval: 60000
    running: true
    repeat: true

    onTriggered: {
        root.timeTick++
    }
}
}
