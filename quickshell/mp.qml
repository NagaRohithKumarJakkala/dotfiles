import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

ShellRoot {
    PanelWindow {
        id: window
        focusable:true

        anchors {
            top: true
            left: true
        }

        margins {
            top: 8
            left: 250
        }


        implicitWidth: 320
        implicitHeight: 120

        color: "transparent"

        property string currentArt: ""
        property bool playing: false

        function youtubeThumb(url) {
            const m =url.match(/(?:v=|youtu\.be\/)([^&]+)/)

            return m? "https://img.youtube.com/vi/" +m[1] +"/hqdefault.jpg": ""
        }

        Process {
            id: metadata

            command: ["playerctl","metadata","--format","{{title}}\n{{artist}}\n{{mpris:artUrl}}\n{{xesam:url}}"]

            running: true

            stdout: StdioCollector {
                onStreamFinished: {
                    const lines = text.trim().split("\n")

                    title.text = lines[0] ||"Nothing Playing"

                    artist.text = lines[1] || ""

                    let art = lines[2] || ""

                    const url = lines[3] || ""

                    if (!art && url.includes("youtube")) {
                        art =window.youtubeThumb(url)
                    }

                    if (art.startsWith("/")) {
                        art ="file://" + art
                    }

                    if (art !== window.currentArt) {
                        window.currentArt = art
                        cover.source = art
                    }
                }
            }
        }

        Process {
            id: statusProc
            command: ["playerctl","status"]

            stdout: StdioCollector {
                onStreamFinished: {
                    window.playing =text.trim() ==="Playing"
                }
            }
        }

        Timer {
            interval: 1000

            repeat: true

            running: true

            onTriggered: {
                metadata.running = false

                metadata.running = true

                statusProc.running = false

                statusProc.running = true
            }
        }

        Rectangle {
            anchors.fill: parent

            Item {
                id: keyHandler

                anchors.fill: parent

                focus: true

                Keys.onPressed: event => {
                    if ( event.key === Qt.Key_Escape ||
                        event.key === Qt.Key_Q
                        ) {
                            event.accepted = true
                            Qt.quit()
                        }
                }

                Component.onCompleted:
                forceActiveFocus()
            }
            radius: 6
            color:"#050505"

            border {
                width: 1
                color:
                "#181818"
            }

            RowLayout {
                anchors.fill:parent
                anchors.margins:14
                spacing:14

                Rectangle {
                    width: 90
                    height: 90
                    radius: 8
                    clip: true
                    color: "#111"
                    Image {
                        id: cover
                        anchors.fill:parent
                        fillMode:Image.PreserveAspectCrop
                        asynchronous:true
                        cache: true
                    }

                    Text {
                        anchors.centerIn:parent

                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "#ddd"
                        font {
                            pixelSize: 16
                            family:
                            "JetBrainsMono Nerd Font"
                        }
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 8
                    Text {
                        id: title

                        Layout.fillWidth: true

                        text:"Nothing Playing"
                        color:"white"
                        wrapMode: Text.Wrap

                        maximumLineCount: 1

                        font {
                            pixelSize:16
                            bold:true
                        }
                    }

                    Text {
                        id: artist
                        color:"#888"

                        font.pixelSize:13
                    }

                    RowLayout {
                        spacing: 12

                        function run(cmd) {
                            if (cmd === "play-pause") {
                                window.playing = !window.playing
                            }

                            player.command = [
                                "playerctl", cmd
                            ]

                            player.running = false
                            player.running = true
                            metadata.running = false
                            metadata.running = true
                        }

                        Repeater {
                            model: [
                                {
                                    icon:"󰒮",
                                    cmd:"previous"
                                },
                                {
                                    icon: window.playing ? "󰏤" : "󰐊", cmd:"play-pause"
                                },
                                {
                                    icon:"󰒭",
                                    cmd:"next"
                                }
                            ]

                            delegate:
                            Rectangle {
                                width: 38
                                height: 38
                                radius: 8
                                color: mouse.containsMouse ? "#181818" : "#101010"

                                Text {
                                    anchors.centerIn: parent
                                    text: modelData.icon
                                    color: "#ddd"
                                    font.pixelSize: 18
                                }

                                MouseArea {
                                    id: mouse

                                    anchors.fill: parent

                                    hoverEnabled: true

                                    onClicked:
                                    parent.parent.run(
                                        modelData.cmd
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }

        Process {
            id: player
        }
    }
}
