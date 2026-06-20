import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

ShellRoot {
    PanelWindow {
        id: window

        focusable: true

        anchors {
            top: true
            left: true
        }

        margins {
            top: 10
            left: 700
        }

        implicitWidth: 135
        implicitHeight: 50

        color: "transparent"

        Shortcut {
            sequence: "Escape"
            onActivated: Qt.quit()
        }

        Rectangle {
            anchors.fill: parent
            radius: 18
            color: "#121212"
            border.color: "#222222"
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8

                Button {
                    id: winBtn
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: "🗔"
                    
                    contentItem: Text {
                        text: winBtn.text
                        font.pixelSize: 16
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        color: winBtn.down ? "#333333" : (winBtn.hovered ? "#252525" : "#1a1a1a")
                        radius: 8
                    }

                    onClicked: {
                        winShot.running = true
                        window.visible = false
                    }
                }

                Button {
                    id: fullBtn
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: "🖥️"

                    contentItem: Text {
                        text: fullBtn.text
                        font.pixelSize: 16
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        color: fullBtn.down ? "#333333" : (fullBtn.hovered ? "#252525" : "#1a1a1a")
                        radius: 8
                    }

                    onClicked: {
                        fullShot.running = true
                        window.visible = false
                    }
                }

                Button {
                    id: regionBtn
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: "✂️"

                    contentItem: Text {
                        text: regionBtn.text
                        font.pixelSize: 16
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        color: regionBtn.down ? "#333333" : (regionBtn.hovered ? "#252525" : "#1a1a1a")
                        radius: 8
                    }

                    onClicked: {
                        regionShot.running = true
                        window.visible = false
                    }
                }
            }
        }

        Process {
            id: winShot
            command: ["sh", "-c", "sleep 0.1 && hyprshot -m window"]
        }

        Process {
            id: fullShot
            command: ["sh", "-c", "sleep 0.1 && hyprshot -m output"]
        }

        Process {
            id: regionShot
            command: ["sh", "-c", "sleep 0.1 && hyprshot -m region"]
        }
    }
}
