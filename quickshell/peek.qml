import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

ShellRoot {
    PanelWindow {
        id: window

        focusable: false

        anchors {
            top: true
            left: true
        }

        margins {
            top: 5
            left: 650
        }

        implicitWidth: 210
        implicitHeight: 50

        color: "transparent"

        Timer {
            interval: 5000
            running: true
            repeat: false
            onTriggered: Qt.quit()
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                var d = new Date()
                timeText.text = Qt.formatTime(d, "hh:mm:ss AP")
            }
        }

        Timer {
            interval: 60000
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: battery.running = true
        }

        Rectangle {
            anchors.fill: parent
            radius: 9
            color: "#000000"
            border.color: "#111111"
            border.width: 3

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 16
                anchors.rightMargin: 16
                spacing: 14

                Text {
                    id: timeText
                    Layout.fillWidth: true
                    color: "white"
                    font.pixelSize: 16
                    verticalAlignment: Text.AlignVCenter

                    Component.onCompleted: {
                        var d = new Date()
                        text = Qt.formatTime(d, "hh:mm:ss AP")
                    }
                }

                Text {
                    text: "🔋"
                    color: "white"
                    font.pixelSize: 16
                }

                Text {
                    id: batteryText
                    text: "--%"
                    color: "white"
                    font.pixelSize: 16
                }
            }
        }

        Process {
            id: battery
            command: [
                "sh",
                "-c",
                "cat /sys/class/power_supply/BAT0/capacity"
            ]

            stdout: StdioCollector {
                onStreamFinished: {
                    batteryText.text = text.trim() + "%"
                }
            }
        }
    }
}
