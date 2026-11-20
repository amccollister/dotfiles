import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets

// Application launcher (migrated from rofi drun).
//
// A centered popup on the focused monitor: Hyprland places unanchored
// layer-shell surfaces there, so no screen tracking is needed. The window
// sits on the overlay layer and takes exclusive keyboard focus.
//
// Palette comes from pywal (~/.cache/wal/colors.json), same source rofi's
// theme used. Layout mirrors launcher.rasi: 33% width, 5x3 icon grid,
// accent-colored input bar, Jost font.
//
// NOTE: QuickShell's PanelWindow.contentItem rejects child items at compile
// time ("Cannot assign a value directly to a grouped property") — it only
// accepts attached properties. So all UI lives as a direct child of the
// window; contentItem is used solely for focus + global key handling.

PanelWindow {
    id: root

    visible: true
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.namespace: "quickshell-launcher"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    // ---- Geometry (rofi used 33% of screen width; monitors are 2560 wide)
    readonly property real windowWidth: 850
    readonly property int columns: 5
    readonly property int maxLines: 3
    readonly property real cellHeight: 112
    readonly property real inputBarHeight: 52
    readonly property real gridPadding: 10
    readonly property real gridSpacing: 5
    // Grid cell width (grid is laid out manually — see below)
    readonly property real cellWidth: (windowWidth - gridPadding * 2 - (columns - 1) * gridSpacing) / columns

    // The grid area is always sized for maxLines rows, so the window height
    // stays constant while searching (rofi keeps its size too).
    readonly property real gridHeight: maxLines * cellHeight + (maxLines - 1) * gridSpacing

    width: windowWidth
    height: inputBarHeight + gridHeight + gridPadding * 2

    // ---- Palette (pywal; fallbacks match the current wallpaper theme)
    property color background: "#0e0404"
    property color foreground: "#c2c0c0"
    property color accent: "#267878"

    // ---- Application data
    // filteredApps is a plain JS array of DesktopEntry objects; reassigning it
    // rebuilds the grid (Repeater re-reads its model).
    property var filteredApps: []
    property int currentIndex: 0

    function refresh() {
        // DesktopEntries.applications exposes a `values` JS array of
        // DesktopEntry objects (the model's count/get are NOT exposed in
        // this build). Entries load asynchronously after startup.
        const t = input.text.trim().toLowerCase()
        const all = DesktopEntries.applications.values
        const out = []
        for (let i = 0; i < all.length; i++) {
            const e = all[i]
            // Skip hidden entries and terminal-only apps (Terminal=true);
            // a GUI launcher shouldn't surface those.
            if (e.noDisplay || e.runInTerminal) continue
            if (!t || e.name.toLowerCase().includes(t)) out.push(e)
        }
        out.sort((a, b) => a.name.localeCompare(b.name))
        filteredApps = out.slice(0, columns * maxLines)
        currentIndex = 0
    }

    function moveSelection(delta) {
        const n = filteredApps.length
        if (n === 0) return
        currentIndex = ((currentIndex + delta) % n + n) % n
    }

    function launchSelected() {
        if (currentIndex >= 0 && currentIndex < filteredApps.length) {
            filteredApps[currentIndex].execute()
            Qt.quit()
        }
    }

    function applyWal(text) {
        try {
            const j = JSON.parse(text)
            background = j.special.background
            foreground = j.special.foreground
            accent = j.colors.color2
        } catch (err) {
            console.log("launcher: could not parse wal colors:", err)
        }
    }

    Component.onCompleted: {
        console.log(`launcher: onCompleted entries=${DesktopEntries.applications.values.length}`)
        refresh()
        input.focus = true
    }

    // Entries land in the model asynchronously after startup (values is 0 at
    // onCompleted time), so valuesChanged is what actually populates the grid.
    // The applicationsChanged hook covers a full model swap; the target
    // binding re-attaches to the new model automatically.
    Connections {
        target: DesktopEntries
        function onApplicationsChanged() { root.refresh() }
    }

    Connections {
        target: DesktopEntries.applications
        function onValuesChanged() { root.refresh() }
    }

    // Load pywal colors (same source as rofi's colors-rofi-dark.rasi).
    Process {
        command: ["sh", "-c", "cat $HOME/.cache/wal/colors.json 2>/dev/null"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.applyWal(text)
        }
    }

    // contentItem accepts attached properties only (see note above).
    contentItem {
        focus: true
        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_Escape) Qt.quit()
        }
    }

    // Rounded popup background. The input bar rounds its own top corners;
    // the grid area is transparent so nothing overflows the bottom radius.
    Rectangle {
        anchors.fill: parent
        radius: 12
        color: root.background

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            // ---- Input bar (accent background, dark text — like rofi)
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: root.inputBarHeight
                color: root.accent
                topLeftRadius: 12
                topRightRadius: 12

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 8

                    Text {
                        text: "::"
                        color: root.background
                        font.family: "Jost*"
                        font.pointSize: 14
                        Layout.alignment: Qt.AlignVCenter
                    }

                    TextField {
                        id: input
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                        focus: true
                        selectByMouse: true
                        background: null // plain text on the accent bar

                        text: ""
                        placeholderText: "Search applications..."
                        color: root.background
                        placeholderTextColor: Qt.rgba(0, 0, 0, 0.5)
                        selectionColor: root.background
                        selectedTextColor: root.accent
                        font.family: "Jost*"
                        font.pointSize: 16

                        onTextChanged: root.refresh()

                        Keys.onPressed: (event) => {
                            if (event.key === Qt.Key_Escape) {
                                Qt.quit()
                            } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                root.launchSelected()
                            } else if (event.key === Qt.Key_Left) {
                                root.moveSelection(-1)
                            } else if (event.key === Qt.Key_Right) {
                                root.moveSelection(1)
                            } else if (event.key === Qt.Key_Up) {
                                root.moveSelection(-root.columns)
                            } else if (event.key === Qt.Key_Down) {
                                root.moveSelection(root.columns)
                            } else {
                                return // let normal text input through
                            }
                            event.accept()
                        }
                    }
                }
            }

            // ---- Application grid
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: root.gridPadding
                Layout.rightMargin: root.gridPadding
                Layout.topMargin: root.gridPadding
                Layout.bottomMargin: root.gridPadding

                Text {
                    anchors.centerIn: parent
                    visible: root.filteredApps.length === 0
                    text: "No matching applications"
                    color: root.foreground
                    font.family: "Jost*"
                    font.pointSize: 14
                    opacity: 0.6
                }

                // GridView is mis-resolved in this build (absent from QtQuick's
                // qmltypes), so the grid is laid out manually with a Repeater.
                Item {
                    anchors.fill: parent
                    visible: root.filteredApps.length > 0

                    Repeater {
                        model: root.filteredApps
                        // NOTE: do NOT declare `required property var modelData`
                        // here — in this Qt build that suppresses the implicit
                        // `index`/`modelData` context properties (verified).
                        delegate: Item {
                            id: cell
                            x: (index % root.columns) * (root.cellWidth + root.gridSpacing)
                            y: Math.floor(index / root.columns) * (root.cellHeight + root.gridSpacing)
                            width: root.cellWidth
                            height: root.cellHeight

                        // Selection gets the solid accent (like rofi's
                        // selected-normal-background); hover gets a hint.
                        Rectangle {
                            anchors.fill: parent
                            radius: 12
                            color: root.accent
                            opacity: index === root.currentIndex ? 1 : (ma.containsMouse ? 0.15 : 0)
                        }

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 8

                            IconImage {
                                implicitSize: 64
                                // image providers use image://<name>/<path> —
                                // "icon://" is NOT a valid protocol here.
                                source: "image://icon/" + (modelData.icon || "application-x-generic")
                                Layout.alignment: Qt.AlignHCenter
                                opacity: status === Image.Ready ? 1 : 0
                            }

                            Text {
                                text: modelData.name
                                color: index === root.currentIndex ? root.background : root.foreground
                                font.family: "Jost*"
                                font.pointSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                elide: Text.ElideRight
                                Layout.fillWidth: true
                                Layout.maximumWidth: cell.width - 20
                            }
                        }

                        MouseArea {
                            id: ma
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: root.currentIndex = index
                            onClicked: root.launchSelected()
                        }
                    }
                }
            }
        }
    }
}
}
