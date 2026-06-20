import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

ShellRoot {
    PanelWindow {
        id: window

        anchors {
            top: true
            right: true
        }

        margins {
            top: 20
            right: 20
        }

        implicitWidth: 400
        implicitHeight: Math.max(80, mainLayout.implicitHeight)

        color: "transparent"
        focusable: true

        Process {
            id: cmdRunner

            stdout: StdioCollector {
                onStreamFinished: {
                    outputDisplay.text = text
                }
            }

            stderr: StdioCollector {
                onStreamFinished: {
                    if (text.length > 0)
                        outputDisplay.text += "\n" + text
                }
            }
        }

        Rectangle {
            anchors.fill: parent
            color: "#111111"
            border.color: "#00000f"
            border.width: 4
            radius: 8

            ColumnLayout {
                id: mainLayout

                anchors.fill: parent
                anchors.margins: 12
                spacing: 10

                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: ">"
                        color: "#ffffff"
                        font.pixelSize: 18
                        font.bold: true
                    }

                    TextInput {
                        id: commandInput

                        Layout.fillWidth: true
                        color: "#ffffff"
                        focus: true
                        font.pixelSize: 16

                        Keys.onReturnPressed: {
                            const cmd = text.trim()

                            if (cmd.length === 0)
                                return

                            outputDisplay.text = "Running...\n"

                            cmdRunner.running = false
                            cmdRunner.command = ["sh", "-c", cmd]
                            cmdRunner.running = true

                            text = ""
                        }

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: ""
                            color: "#6c7086"

                            visible:
                                commandInput.text.length === 0 &&
                                !commandInput.activeFocus
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#00000f"

                    visible: outputDisplay.text.length > 0
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.maximumHeight: 300
                    Layout.preferredHeight:
                        Math.min(300, outputDisplay.contentHeight)

                    visible: outputDisplay.text.length > 0

                    TextArea {
                        id: outputDisplay

                        readOnly: true
                        wrapMode: TextEdit.Wrap

                        color: "#ffffff"
                        font.family: "monospace"

                        background: null
                    }
                }

                Text {
                    text: "Press ESC to close"
                    color: "#ffffff"
                    font.pixelSize: 10

                    Layout.alignment: Qt.AlignRight

                    visible: outputDisplay.text.length > 0
                }
            }
        }

        Shortcut {
            sequence: "Escape"

            onActivated: {
                Qt.quit()
            }
        }
    }
}
