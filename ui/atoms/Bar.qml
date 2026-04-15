import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
	property color current_color
	id: rect
	color: current_color
	radius: 4
	RowLayout {
		anchors.fill: parent
	}
}
