import Quickshell.Services.Notifications

NotificationServer {
    id: server

    bodySupported: true
    actionsSupported: true
    imageSupported: true

    onNotification: function(notification) {
        NotificationManager.add(notification)
        if (!NotificationManager.doNotDisturb) {
        notification.tracked = true
    }

    }
}
