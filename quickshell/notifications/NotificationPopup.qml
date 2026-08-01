import QtQuick

Item {
    id: root

    property var notification
    property bool closing: false
    property bool dismissedByUi: false

    width: card.width
    implicitWidth: card.implicitWidth

    implicitHeight: card.implicitHeight
    height: implicitHeight

    property real slideOffset: width + 24

    transform: Translate {
        x: root.slideOffset
    }

    opacity: 0

    Behavior on slideOffset {
        NumberAnimation {
            duration: 220
            easing.type: Easing.OutCubic
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 180
            easing.type: Easing.OutQuad
        }
    }

    NotificationCard {
        id: card

        anchors.fill: parent
        notification: root.notification

        onDismissRequested: {
            root.dismissedByUi = true
            root.animateOut()
        }
    }

    Component.onCompleted: {
        slideOffset = 0
        opacity = 1
    }

    function animateOut() {
        if (closing) {
            return
        }

        closing = true
        slideOffset = width + 24
        opacity = 0
        dismissTimer.start()
    }

    Connections {
        target: notification

        function onClosed(reason) {
            if (!root.closing) {
                root.animateOut()
            }
        }
    }

    Timer {
        id: dismissTimer

        interval: 220
        repeat: false

        onTriggered: {
            if (root.dismissedByUi && notification) {
                notification.dismiss()
            }
        }
    }

    Timer {
    id: expireTimer

    interval: notification && notification.expireTimeout > 0
              ? notification.expireTimeout
              : 5000

    repeat: false
    running: notification && notification.urgency !== 2

    onTriggered: {
        root.dismissedByUi = true
        root.animateOut()
    }
}
}
