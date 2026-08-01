
pragma Singleton

import QtQuick

QtObject {
    id: root

    // Notification center state
    property bool centerOpen: false

    // Notification history
    property var notifications: []

    function add(notification) {
        const entry = {
            appName: notification.appName ?? "",
            appIcon: notification.appIcon ?? "",
            image: notification.image ?? "",
            summary: notification.summary ?? "",
            body: notification.body ?? "",
            time: new Date()
        }

        notifications = [entry, ...notifications]
    }

    function remove(entry) {
        notifications = notifications.filter(n => n !== entry)
    }

    function clear() {
        notifications = []
    }

    function toggleCenter() {
        centerOpen = !centerOpen
    }

    function openCenter() {
        centerOpen = true
    }

    function closeCenter() {
        centerOpen = false
    }
}
