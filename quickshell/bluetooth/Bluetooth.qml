import QtQuick
import Quickshell
import Quickshell.Bluetooth

QtObject {
    id: root

    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter

    readonly property bool available: adapter !== null
    readonly property bool enabled: adapter?.enabled ?? false
    readonly property bool discovering: adapter?.discovering ?? false

    function toggle() {
        if (!adapter)
            return

        adapter.enabled = !adapter.enabled
    }

    function startDiscovery() {
        if (!adapter || !adapter.enabled)
            return

        adapter.discovering = true
    }

    function stopDiscovery() {
        if (!adapter)
            return

        adapter.discovering = false
    }
}
