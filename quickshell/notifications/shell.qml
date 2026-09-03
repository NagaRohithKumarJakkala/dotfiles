import Quickshell
import Quickshell.Io

ShellRoot {
    NotificationServer {
        id: notificationServer
    }

    PopupOverlay {
        server: notificationServer
    }

    NotificationCenter {}

    IpcHandler {
        target: "notifications"

        function toggle(): void {
            NotificationManager.toggleCenter()
        }

        function open(): void {
            NotificationManager.openCenter()
        }

        function close(): void {
            NotificationManager.closeCenter()
        }

        function clear(): void {
            NotificationManager.clear()
        }
        function dnd(): void {
            NotificationManager.toggleDnd()
        }
    }
}
