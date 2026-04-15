// Custom Components
import qs.singletons
import qs.windows

import qs.ui.atoms
import qs.ui.organisms

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Scope {
	Variants {
		model: Quickshell.screens

		PanelWindow {
			id: root_panel
			required property var modelData
			screen: modelData
			color: "transparent"

			anchors {
				top: true
				left: true
				right: true
			}

			margins {
				top: 3
				left: 6
				right: 6
			}

			implicitHeight: 35

			RowLayout {
				anchors.fill: parent
				Bar {
					current_color: "transparent"
					Layout.fillWidth: true
					Layout.fillHeight: true

					RowLayout {
						anchors.fill: parent
						anchors.margins: 0

						LeftMenu {}
						HyprWorkspaces {}
						BasicStats {}
					}
				}
			}

			MediaPlayer {
				current_screen: modelData
			}

			ConfigPanel {
				current_screen: modelData
			}
		}
	}
}
