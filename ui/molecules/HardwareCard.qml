import qs.singletons
import qs.ui.atoms

import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Card {
	id: root
	property string title
	property string footer_text
	property real value
	Layout.preferredWidth: 150
	Layout.preferredHeight: 150

	ColumnLayout {
		anchors.fill: parent
		anchors.margins: 20
		anchors.topMargin: 10
		spacing: 8
		
		AppText {
			Layout.alignment: Qt.AlignHCenter
			text: root.title
			color: Theme.primary_main
			font.bold: true
			font.pixelSize: 16
		}

		RadialBar {
			Layout.alignment: Qt.AlignHCenter
			w: 80
			h: 80
			value: root.value
			icon: `${root.value}%`
			icon_size: 20
			icon_bold: true
			stroke_width: 4
		}

		AppText {
			id: f_text
			property bool can_show: false

			Layout.alignment: Qt.AlignHCenter
			Layout.maximumWidth: 110
			text: root.footer_text
			color: Theme.neutral_400
			font.pixelSize: 14
			wrapMode: Text.NoWrap
			elide: Text.ElideRight

			AppToolTip {
				text: root.footer_text
				visible: hover_area.containsMouse
			}

			MouseArea {
				id: hover_area
				hoverEnabled: true
				anchors.fill: parent
			}
		}
	}
}
