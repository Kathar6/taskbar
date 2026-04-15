import qs.ui.atoms
import qs.ui.molecules
import qs.ui.organisms

import qs.singletons

import Quickshell
import QtQuick
import QtQuick.Layouts

RowLayout {
	anchors.fill: parent

	Item {
		Layout.fillWidth: true
	}

	Bar {
		current_color: Theme.neutral_main
		Layout.preferredWidth: 250
		Layout.fillHeight: true

		border {
			color: Theme.neutral_200
		}

		RowLayout {
			anchors.fill: parent
			spacing: 5
			anchors.rightMargin: 5

			StatChips{}
			Clock {}
			AppButton {
				anchors.verticalCenter: parent.verticalCenter
				text: "\ue615"
				onClick: () => WindowManager.toggleConfigPanel(modelData)
			}
		}
	}
}
