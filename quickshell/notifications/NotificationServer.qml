import Quickshell.Services.Notifications

NotificationServer {
    id: server

    bodySupported: true
    actionsSupported: true
    imageSupported: true

    onNotification: function(notification) {
        notification.tracked = true
        NotificationManager.add(notification)
    }
}
