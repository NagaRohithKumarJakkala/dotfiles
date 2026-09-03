import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Rectangle {
    id: root

    property int playerCount: Mpris.players.values.length

    width: 350
    height: 150

    // Always visible
    visible: true

    radius: 14

    color: Qt.rgba(0.14, 0.14, 0.14, 0.7)

    border.width: 1
    border.color: "#33FFFFFF"

    // ============================================================
    // No media player
    // ============================================================

    Item {
        anchors.fill: parent

        visible: root.playerCount === 0

        Row {
            anchors.centerIn: parent
            spacing: 14

            Rectangle {
                width: 80
                height: 80

                radius: 12

                color: Qt.rgba(
                    1,
                    1,
                    1,
                    0.06
                )

                Text {
                    anchors.centerIn: parent

                    text: "󰝚"

                    color: "#777777"
                    font.pixelSize: 32
                }
            }

            Column {
                anchors.verticalCenter: parent.verticalCenter

                spacing: 4

                Text {
                    text: "Not Playing"

                    color: "#CCCCCC"

                    font.pixelSize: 15
                    font.bold: true
                }

                Text {
                    text: "No media is currently playing"

                    color: "#777777"
                    font.pixelSize: 11
                }
            }
        }
    }

    // ============================================================
    // Media players
    // ============================================================

    Column {
        anchors.fill: parent
        anchors.margins: 10

        spacing: 6

        visible: root.playerCount > 0

        ListView {
            id: playerList

            width: parent.width
            height: 115

            orientation: ListView.Horizontal

            model: Mpris.players

            clip: true

            snapMode: ListView.SnapOneItem
            boundsBehavior: Flickable.StopAtBounds

            highlightRangeMode:
                ListView.StrictlyEnforceRange

            preferredHighlightBegin: 0
            preferredHighlightEnd: width

            delegate: MediaPlayer {
                required property var modelData

                width: playerList.width
                height: playerList.height

                player: modelData
            }
        }

        // ========================================================
        // Player page indicators
        // ========================================================

        Row {
            anchors.horizontalCenter: parent.horizontalCenter

            spacing: 6

            visible: root.playerCount > 1

            Repeater {
                model: root.playerCount

                Rectangle {
                    width:
                        index === playerList.currentIndex
                        ? 14
                        : 6

                    height: 6
                    radius: 3

                    color:
                        index === playerList.currentIndex
                        ? "#FFFFFF"
                        : "#666666"

                    Behavior on width {
                        NumberAnimation {
                            duration: 150
                        }
                    }
                }
            }
        }
    }
}
