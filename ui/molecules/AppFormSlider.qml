import qs.singletons
import qs.ui.atoms

import Quickshell
import QtQuick
import QtQuick.Layouts

ColumnLayout {
	id: root
	property string icon
	property string label
	property real value
	property real steps: 5

	signal valueChange(real new_value)
	signal clickIcon()

	RowLayout {
		Layout.fillWidth: true
		Layout.fillHeight: true

		QtObject {
			id: internal
			property int font_size: 14
		}

		AppText {
			Layout.preferredWidth: 20
			font.pixelSize: internal.font_size
			text: root.icon

			MouseArea {
				anchors.fill: parent
				cursorShape: Qt.PointingHandCursor
				onClicked: {
					root.clickIcon()
				}
			}
		}

		AppText {
			Layout.fillWidth: true
			font.pixelSize: internal.font_size
			font.bold: true
			text: root.label
		}

		AppText {
			Layout.preferredWidth: 40
			font.pixelSize: internal.font_size
			font.bold: true
			text: `${Math.round(root.value)}%`
		}
	}

	RowLayout {
		Layout.fillWidth: true
		Layout.fillHeight: true

		AppSlider {
			id: slider
			Layout.fillWidth: true
			value: root.value
			stepSize: root.steps

			onMoved: {
				root.valueChange(value)
			}
		}

		MouseArea {
			anchors.fill: parent
			acceptedButtons: Qt.NoButton

			onWheel: (event) => {
				const scroll_value = event.angleDelta.y
				if (scroll_value > 0 && root.value < (100 - root.steps)) {
					const new_value = root.value + root.steps
					if (root.valueChange) root.valueChange(new_value)
				}
				else if (scroll_value < 0 && root.value > (0 + root.steps)) {
					const new_value = root.value - root.steps
					if (root.valueChange) root.valueChange(new_value)
				}
			}
		}
	}
}
