import qs.singletons

import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
	id: root
	color: "transparent"
	radius: 6
	property int margin
	property int top_margin
	property int bottom_margin
	property int spacing

	border {
		color: Theme.neutral_200
		pixelAligned: true
		width: 1
	}
}
