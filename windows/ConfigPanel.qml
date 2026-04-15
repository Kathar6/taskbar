import qs.singletons
import qs.ui.atoms
import qs.ui.organisms

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

PanelWindow {
	id: config_window
	required property var current_screen
	screen: current_screen

	implicitWidth: 400
	implicitHeight: 600
	exclusionMode: ExclusionMode.Ignore
	color: "transparent"


	QtObject {
		id: internal
		property bool can_show: WindowManager.show_config_panel && WindowManager.active_screen === current_screen
		property int margin_right: -410

		onCan_showChanged: {
			if (can_show) {
				margin_right = 5.5
				return
			}

			margin_right = -410
		}

		Behavior on margin_right {
			NumberAnimation {
				duration: 200
				easing.type: Easing.OutCubic
			}
		}
	}

	anchors {
		top: true
		right: true
	}

	margins {
		top: 42
		right: internal.margin_right
	}

	visible: internal.can_show

	Bar {
		anchors.fill: parent
		current_color: Qt.alpha(Theme.neutral_main, 0.7)
		border {
			color: Theme.neutral_200
		}

		ColumnLayout {
			anchors.fill: parent
			anchors.margins : 20

			HardwareInfo {}
			ConfigSliders {}

			Item {
				Layout.fillWidth: true
				Layout.fillHeight: true
			}

			RowLayout {
				Layout.fillWidth: true
				Layout.preferredHeight: 40
				Item {
					Layout.fillWidth: true
				}
				AppButton {
					width: 40
					height: 40
					border {
						width: 1
						color: Theme.neutral_200
					}
					text: "\u23fb"
					onClick: () => WindowManager.toggleLogoutPanel()
				}
			}
		}
	}
}
