import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris

Item {
    id: root

    required property var player

    implicitHeight: 120
    implicitWidth: 350

    Row {
        anchors.fill: parent
        spacing: 14

        // ============================================================
        // Album art
        // ============================================================

        Rectangle {
            width: 100
            height: 100

            anchors.verticalCenter: parent.verticalCenter

            radius: 12
            color: "#333333"

            clip: true

            Image {
                anchors.fill: parent

                source: root.player.trackArtUrl ?? ""

                fillMode: Image.PreserveAspectCrop

                visible:
                    root.player.trackArtUrl !== ""
            }

            // Fallback
            Text {
                anchors.centerIn: parent

                visible:
                    root.player.trackArtUrl === ""

                text: "󰝚"

                color: "#888888"
                font.pixelSize: 32
            }
        }

        // ============================================================
        // Track information
        // ============================================================

        Column {
            width: parent.width - 114

            anchors.verticalCenter: parent.verticalCenter

            spacing: 5

            Text {
                width: parent.width

                text: root.player.trackTitle || "Unknown title"

                color: "#FFFFFF"

                font.pixelSize: 15
                font.bold: true

                elide: Text.ElideRight
            }

            Text {
                width: parent.width

                text: root.player.trackArtist || "Unknown artist"

                color: "#AAAAAA"

                font.pixelSize: 12

                elide: Text.ElideRight
            }

            Item {
                width: 1
                height: 5
            }

            // ========================================================
            // Controls
            // ========================================================

            Row {
                spacing: 18

                anchors.horizontalCenter: parent.horizontalCenter

                // Previous
                Text {
                    text: "󰒮"

                    color: root.player.canGoPrevious
                           ? "#FFFFFF"
                           : "#666666"

                    font.pixelSize: 22

                    MouseArea {
                        anchors.fill: parent

                        enabled: root.player.canGoPrevious

                        cursorShape: Qt.PointingHandCursor

                        onClicked:
                            root.player.previous()
                    }
                }

                // Play / Pause
                Text {
                    text:
                        root.player.playbackState ===
                        MprisPlaybackState.Playing
                        ? "󰏤"
                        : "󰐊"

                    color: "#FFFFFF"

                    font.pixelSize: 25

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked:
                            root.player.togglePlaying()
                    }
                }

                // Next
                Text {
                    text: "󰒭"

                    color: root.player.canGoNext
                           ? "#FFFFFF"
                           : "#666666"

                    font.pixelSize: 22

                    MouseArea {
                        anchors.fill: parent

                        enabled: root.player.canGoNext

                        cursorShape: Qt.PointingHandCursor

                        onClicked:
                            root.player.next()
                    }
                }
            }
        }
    }
}
