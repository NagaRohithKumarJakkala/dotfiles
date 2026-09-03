import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Bluetooth
import QtQuick.Layouts

PanelWindow {
    id: window

    anchors {
        top: true
        left: true
    }
    margins{
        top:5
        left:10
    }

    implicitWidth: 350
    implicitHeight: 530

    // color: "#202020"
    color: Qt.rgba(0, 0, 0, 0.72)
    focusable: true

    Shortcut {
        sequence: "Escape"
        onActivated: Qt.quit()
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        // =========================
        // HEADER
        // =========================

        RowLayout {
    Layout.fillWidth: true
    spacing: 10

    Text {
        text: "Bluetooth"
        color: "white"
        font.pixelSize: 22

        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
    }

    // Scan button
    Rectangle {
        width: 32
        height: 32
        radius: 8

        color: Bluetooth.defaultAdapter?.discovering
               ? Qt.rgba(0.23, 0.51, 0.96, 0.25)
               : Qt.rgba(1, 1, 1, 0.08)

        Text {
            anchors.centerIn: parent
            text: "🔍"
            font.pixelSize: 16
        }

        MouseArea {
            anchors.fill: parent

            enabled: Bluetooth.defaultAdapter?.enabled ?? false
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                if (Bluetooth.defaultAdapter)
                    Bluetooth.defaultAdapter.discovering =
                        !Bluetooth.defaultAdapter.discovering
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: 150
            }
        }
    }

    // Bluetooth toggle
    Item {
        width: 52
        height: 28

        Layout.alignment: Qt.AlignVCenter

        Rectangle {
            id: track

            anchors.fill: parent
            radius: height / 2

            color: Bluetooth.defaultAdapter?.enabled
                   ? "#3b82f6"
                   : "#333333"

            opacity: Bluetooth.defaultAdapter ? 1.0 : 0.5

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            Rectangle {
                width: 22
                height: 22
                radius: width / 2

                anchors.verticalCenter: parent.verticalCenter

                x: Bluetooth.defaultAdapter?.enabled
                   ? parent.width - width - 3
                   : 3

                color: "#aaaaaa"

                Behavior on x {
                    NumberAnimation {
                        duration: 180
                        easing.type: Easing.OutCubic
                    }
                }
            }

            MouseArea {
                anchors.fill: parent

                enabled: Bluetooth.defaultAdapter !== null

                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    if (Bluetooth.defaultAdapter) {
                        Bluetooth.defaultAdapter.enabled =
                            !Bluetooth.defaultAdapter.enabled
                    }
                }
            }
        }
    }
}
        Text {
            text: Bluetooth.defaultAdapter
                ? "Devices: " + Bluetooth.defaultAdapter.devices.values.length
                : "No adapter"

            color: "#aaaaaa"

            Layout.fillWidth: true
        }


        Text {
            visible: Bluetooth.defaultAdapter?.discovering ?? false

            text: "Scanning for nearby devices..."

            color: "#aaaaaa"
            font.pixelSize: 12

            Layout.fillWidth: true
        }

        // =========================
        // CONNECTED DEVICES
        // =========================

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 8

            Text {
                text: "Connected Devices"

                color: "white"
                font.pixelSize: 16
                font.bold: true

                Layout.fillWidth: true

                visible: Bluetooth.defaultAdapter
                         && Bluetooth.defaultAdapter.devices.values.some(
                             device => device.connected
                         )
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.preferredHeight: 140

                clip: true

                ScrollBar.vertical.policy: ScrollBar.AsNeeded

                Column {
                    width: parent.width
                    spacing: 8

                    Repeater {
                        model: Bluetooth.defaultAdapter
                            ? Bluetooth.defaultAdapter.devices.values.filter(
                                  device => device.connected
                              )
                            : []

                        delegate: BluetoothDeviceItem {
                            required property var modelData

                            width: parent.width
                            device: modelData
                        }
                    }
                }
            }
        }

        // =========================
        // AVAILABLE DEVICES
        // =========================

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            spacing: 8

            Text {
                text: "Available Devices"

                color: "white"
                font.pixelSize: 16
                font.bold: true

                Layout.fillWidth: true

                visible: Bluetooth.defaultAdapter
                         && Bluetooth.defaultAdapter.devices.values.some(
                             device => !device.connected
                         )
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true

                clip: true

                ScrollBar.vertical.policy: ScrollBar.AsNeeded

                Column {
                    width: parent.width
                    spacing: 8

                    Repeater {
                        model: Bluetooth.defaultAdapter
                            ? Bluetooth.defaultAdapter.devices.values.filter(
                                  device => !device.connected
                              )
                            : []

                        delegate: BluetoothDeviceItem {
                            required property var modelData

                            width: parent.width
                            device: modelData
                        }
                    }
                }
            }
        }
    }
}
