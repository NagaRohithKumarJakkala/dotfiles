pragma Singleton

import QtQuick
import Quickshell

QtObject {
    id: root

    function copyActions(actions) {
        return Array.from(actions ?? []).filter(action => action)
    }

    function resolveIconSource(icon) {
        if (!icon)
            return ""

        if (icon.startsWith("/") || icon.startsWith("file://"))
            return icon

        const normalizedIcon = icon.endsWith("-symbolic")
            ? icon.slice(0, -9)
            : icon

        return Quickshell.iconPath(normalizedIcon, "")
    }

    property bool centerOpen: false
    property bool doNotDisturb: false

    property var notifications: []
    property int maxHistory: 100

    property int nextId: 0

    readonly property int count: notifications.length

    readonly property int unreadCount: {
        let count = 0

        for (let i = 0; i < notifications.length; i++) {
            if (!notifications[i].read)
                count++
        }

        return count
    }

    function snapshotNotification(notification) {
        return {
            id: notification.id,
            appName: notification.appName ?? "",
            appIcon: notification.appIcon ?? "",
            image: notification.image ?? "",
            summary: notification.summary ?? "",
            body: notification.body ?? "",
            actions: copyActions(notification.actions),
            time: notification.time,
            read: notification.read
        }
    }

    function findNotificationById(id) {
        for (let i = 0; i < notifications.length; i++) {
            if (notifications[i].id === id)
                return notifications[i]
        }

        return null
    }

    readonly property var groups: {
    const result = []
    const indexes = {}

    for (let i = 0; i < notifications.length; i++) {
        const notification = notifications[i]

        // Use app name as the group key.
        const name = notification.appName || "Other"

        if (indexes[name] === undefined) {
            indexes[name] = result.length

            result.push({
                appName: name,
                appIcon: notification.appIcon,
                notifications: [snapshotNotification(notification)]
            })
        } else {
            result[indexes[name]].notifications.push(snapshotNotification(notification))
        }
    }

    return result
}

    
function add(notification) {
    const entry = {
        id: nextId++,

        appName: notification.appName ?? "",
        appIcon: notification.appIcon ?? "",
        image: notification.image ?? "",
        summary: notification.summary ?? "",
        body: notification.body ?? "",

        actions: copyActions(notification.actions),

        time: new Date(),
        read: centerOpen,

        source: notification
    }

    let updated = [entry].concat(notifications)

    // Remove notifications beyond the history limit.
    if (updated.length > maxHistory) {
        const removed = updated.slice(maxHistory)

        updated = updated.slice(0, maxHistory)

        // Dismiss notifications that are being dropped completely.
        for (let i = 0; i < removed.length; i++) {
            if (removed[i].source) {
                try {
                    removed[i].source.dismiss()
                } catch (error) {
                    console.log(
                        "Failed to dismiss old notification:",
                        error
                    )
                }
            }
        }
    }

    notifications = updated
}

    function remove(entry) {
        if (!entry)
            return

        const id = entry.id
        const storedEntry = findNotificationById(id)
        const source = entry.source ?? (storedEntry ? storedEntry.source : null)

        let result = []

        for (let i = 0; i < notifications.length; i++) {
            if (notifications[i].id !== id)
                result.push(notifications[i])
        }

        // Remove from history first.
        notifications = result

        // Then close the actual notification if it still exists.
        if (source) {
            try {
                source.dismiss()
            } catch (error) {
                console.log(
                    "Notification already closed:",
                    error
                )
            }
        }
    }

    function clear() {
        // Copy first because dismissing notifications can trigger
        // notification lifecycle changes.
        const oldNotifications = notifications

        // Immediately clear our history.
        notifications = []

        for (let i = 0; i < oldNotifications.length; i++) {
            const entry = oldNotifications[i]

            if (entry.source) {
                try {
                    entry.source.dismiss()
                } catch (error) {
                    console.log(
                        "Notification already closed:",
                        error
                    )
                }
            }
        }
    }

    function markAllRead() {
        let result = []

        for (let i = 0; i < notifications.length; i++) {
            const entry = notifications[i]

            result.push({
                id: entry.id,

                appName: entry.appName,
                appIcon: entry.appIcon,
                image: entry.image,
                summary: entry.summary,
                body: entry.body,
                actions: copyActions(entry.actions),
                

                time: entry.time,

                read: true,

                source: entry.source
            })
        }

        notifications = result
    }

    function toggleCenter() {
        centerOpen = !centerOpen

        if (centerOpen)
            markAllRead()
    }

    function openCenter() {
        centerOpen = true
        markAllRead()
    }

    function closeCenter() {
        centerOpen = false
    }

    function toggleDnd() {
        doNotDisturb = !doNotDisturb
    }

    function enableDnd() {
        doNotDisturb = true
    }

    function disableDnd() {
        doNotDisturb = false
    }

function clearGroup(group) {
    if (!group || !group.notifications)
        return

    // Copy the array because remove() changes the main
    // notifications array while we're iterating.
    const groupNotifications = group.notifications.slice()

    for (let i = 0; i < groupNotifications.length; i++) {
        remove(groupNotifications[i])
    }
}

}
