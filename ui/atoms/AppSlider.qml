import qs.singletons

import Quickshell
import QtQuick
import QtQuick.Controls

Slider {
	id: control
	from: 0
	to: 100
	value: 0
	implicitHeight: 8

	background: Rectangle {
		x: control.leftPadding
		y: control.topPadding + control.availableHeight / 2 - height / 2
		implicitWidth: 100
		implicitHeight: parent.height
		radius: 2
		color: Theme.neutral_200

		Rectangle {
			width: control.visualPosition * parent.width
			height: parent.height
			color: Theme.primary_main
			radius: 2
		}
	}

	handle: Rectangle {
		x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
		y: control.topPadding + control.availableHeight / 2 - height / 2
		implicitWidth: 8
		implicitHeight: parent.height
		radius: 2
		color: "transparent"
	}

}
