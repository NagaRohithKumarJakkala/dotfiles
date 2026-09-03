import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property real brightness: 50
    property bool dragging: false

    implicitHeight: 42
    implicitWidth: 350

    Row {
        anchors.fill: parent
        spacing: 12

        // ============================================================
        // Brightness icon
        // ============================================================

        Text {
            id: brightnessIcon

            width: 26
            anchors.verticalCenter: parent.verticalCenter

            text: "󰃟"

            color: "white"
            font.pixelSize: 19

            horizontalAlignment: Text.AlignHCenter
        }

        // ============================================================
        // Brightness bar
        // ============================================================

        Rectangle {
            id: brightnessBar

            width: parent.width
                   - brightnessIcon.width
                   - parent.spacing

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
                id: brightnessFill

                width: brightnessBar.width
                       * (root.brightness / 100)

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
                id: brightnessMouse

                anchors.fill: parent

                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                function updateBrightness(mouseX) {
                    let percentage =
                        mouseX / brightnessBar.width

                    percentage = Math.max(
                        0.01,
                        Math.min(1, percentage)
                    )

                    const newBrightness =
                        Math.round(percentage * 100)

                    root.brightness = newBrightness

                    setBrightness.command = [
                        "brightnessctl",
                        "set",
                        newBrightness + "%"
                    ]

                    setBrightness.running = true
                }

                onPressed: mouse => {
                    root.dragging = true
                    updateBrightness(mouse.x)
                }

                onPositionChanged: mouse => {
                    if (pressed)
                        updateBrightness(mouse.x)
                }

                onReleased: {
                    root.dragging = false
                }
            }
        }
    }

    // ================================================================
    // Read brightness
    // ================================================================

    Process {
        id: getBrightness

        command: [
            "brightnessctl",
            "-m"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                if (root.dragging)
                    return

                // Example:
                // intel_backlight,backlight,9600,120000,8%

                const fields = text.trim().split(",")

                if (fields.length >= 4) {
                    const value =
                        parseInt(fields[3])

                    if (!isNaN(value))
                        root.brightness = value
                }
            }
        }

        running: true
    }

    // ================================================================
    // Set brightness
    // ================================================================

    Process {
        id: setBrightness
    }

    // ================================================================
    // Keep synchronized with keyboard brightness changes
    // ================================================================

    Timer {
        interval: 500
        repeat: true
        running: true

        onTriggered: {
            if (!root.dragging && !getBrightness.running)
                getBrightness.running = true
        }
    }
}
