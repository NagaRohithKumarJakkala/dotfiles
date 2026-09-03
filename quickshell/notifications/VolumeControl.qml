import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property real volume: 0.5

    implicitHeight: 42
    implicitWidth: 350

    // Prevent polling from fighting with dragging
    property bool dragging: false

    Row {
        anchors.fill: parent
        spacing: 12

        // ============================================================
        // Volume icon
        // ============================================================

        Text {
            id: volumeIcon

            width: 26
            anchors.verticalCenter: parent.verticalCenter

            text: {
                if (root.volume <= 0.01)
                    return "󰖁"
                else if (root.volume < 0.35)
                    return ""
                else if (root.volume < 0.70)
                    return ""
                else
                    return ""
            }

            color: "white"
            font.pixelSize: 19

            horizontalAlignment: Text.AlignHCenter
        }

        // ============================================================
        // Volume bar
        // ============================================================

        Rectangle {
            id: volumeBar

            width: parent.width - volumeIcon.width - parent.spacing
            height: 14

            anchors.verticalCenter: parent.verticalCenter

            radius: height / 2

            // Unfilled portion
            color: "#555555"

            clip: true

            // ========================================================
            // Filled portion
            // ========================================================

            Rectangle {
                id: volumeFill

                width: volumeBar.width * root.volume
                height: parent.height

                radius: parent.radius
                color: "#FFFFFF"

                Behavior on width {
                    enabled: !root.dragging

                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                }
            }

            // ========================================================
            // Mouse interaction
            // ========================================================

            MouseArea {
                id: volumeMouse

                anchors.fill: parent

                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                function updateVolume(mouseX) {
                    let newVolume = mouseX / volumeBar.width

                    newVolume = Math.max(
                        0,
                        Math.min(1, newVolume)
                    )

                    root.volume = newVolume

                    setVolume.command = [
                        "wpctl",
                        "set-volume",
                        "@DEFAULT_AUDIO_SINK@",
                        newVolume.toFixed(3)
                    ]

                    setVolume.running = true
                }

                onPressed: mouse => {
                    root.dragging = true
                    updateVolume(mouse.x)
                }

                onPositionChanged: mouse => {
                    if (pressed)
                        updateVolume(mouse.x)
                }

                onReleased: {
                    root.dragging = false
                }
            }
        }
    }

    // ================================================================
    // Read volume
    // ================================================================

    Process {
        id: getVolume

        command: [
            "wpctl",
            "get-volume",
            "@DEFAULT_AUDIO_SINK@"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                if (root.dragging)
                    return

                const match = text.match(/Volume:\s*([0-9.]+)/)

                if (match) {
                    root.volume = Math.min(
                        1,
                        Number(match[1])
                    )
                }
            }
        }

        running: true
    }

    // ================================================================
    // Set volume
    // ================================================================

    Process {
        id: setVolume
    }

    // ================================================================
    // Keep synchronized with external volume changes
    // ================================================================

    Timer {
        interval: 500
        repeat: true
        running: true

        onTriggered: {
            if (!root.dragging && !getVolume.running)
                getVolume.running = true
        }
    }
}
