import qs.singletons

import Quickshell
import QtQuick
import Qt5Compat.GraphicalEffects

Item {
	id: root
	width: 100
	height: 100
	property string source: ""
	property int radius: 0

	Rectangle {
		anchors.fill: parent
		color: Theme.neutral_200
		radius: root.radius
		opacity: current_image.status === Image.Ready ? 0.0 : 1.0
	}

	Image {
		id: current_image
		source: root.source
		anchors.fill: parent
		fillMode: Image.PreserveAspectFit

		asynchronous: true
		visible: false
	}

	Rectangle {
		id: mask
		anchors.fill: parent
		radius: root.radius
		visible: false
	}

	OpacityMask {
		anchors.fill: parent
		source: current_image
		maskSource: mask

		opacity: current_image.status === Image.Ready ? 1.0 : 0.0

		Behavior on opacity {
			NumberAnimation {
				duration: 200
				easing.type: Easing.OutCubic
			}
		}
	}
}
