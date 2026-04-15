import qs.singletons

import Quickshell
import QtQuick
import QtQuick.Controls

ToolTip {
	id: control
	delay: 1000

	background: Rectangle {
		radius: 4
		color: Theme.neutral_main
		border {
			color: Theme.neutral_200
			width: 1
		}
	}

	contentItem: Text {
		color: Theme.primary_main
		text: control.text
		font.family: Theme.fontFamily
		wrapMode: Text.Wrap
	}

	enter: Transition {
		NumberAnimation { property: "scale"; from: 0.3; to: 1.0; duration: 200; easing.type: Easing.OutBack }
	}
	exit: Transition {
		NumberAnimation { property: "scale"; from: 1.0; to: 0.8; duration: 150; easing.type: Easing.InBack }
	}

}
