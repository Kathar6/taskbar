import qs.singletons
import qs.ui.atoms

import Quickshell
import QtQuick
import QtQuick.Layouts

RowLayout {
	Layout.fillWidth: true
	Layout.fillHeight: true

	Bar {
		current_color: Theme.neutral_main
		Layout.preferredWidth: 200
		Layout.fillHeight: true

		border {
			color: Theme.neutral_200
		}

		RowLayout {
			anchors.fill: parent
			anchors.leftMargin: 10
			spacing: 5

			AppButton {
				anchors.verticalCenter: parent.verticalCenter
				text: "\ueb94"
			}

			AppButton {
				anchors.verticalCenter: parent.verticalCenter
				text: "\uf001"
				onClick: () => WindowManager.toggleMediaPanel(modelData)
			}
			Item {
				Layout.fillWidth: true
			}
		}
	}

	Item {
		Layout.fillWidth: true
	}
}
