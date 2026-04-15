import qs.singletons

import Quickshell
import QtQuick
import QtQuick.Controls

Rectangle {
	id: root
	width: 300
	height: 60
	radius: 4
	color: {
		if (internal.is_hover) return Theme.primary_main
		return Theme.neutral_300
	}

	QtObject {
		id: internal
		property bool is_hover: false
	}

	property string text: ""
	signal click()

	AppText {
		anchors.verticalCenter: parent.verticalCenter
		anchors.horizontalCenter: parent.horizontalCenter
		text: parent.text
		color: internal.is_hover ? Theme.neutral_main : Theme.primary_main
	}

	MouseArea {
		id: m_button
		anchors.fill: parent
		cursorShape: Qt.PointingHandCursor
		preventStealing: true
		hoverEnabled: true

		onEntered: {
			if (!bounce_anim.running)
				bounce_anim.start()
			internal.is_hover = true
		}
		onExited: {
			internal.is_hover = false
		}
		onClicked: {
			if (onClick) root.click()
		}
	}

	BounceBehavior {
		id: bounce_anim
		target_item: root
	}
}
