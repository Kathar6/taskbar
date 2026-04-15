import Quickshell
import QtQuick

SequentialAnimation {
	id: bounce_anim
	property Item target_item
	NumberAnimation {
		target: target_item
		property: "scale"
		to: 0.6 
		duration: 90 
		easing.type: Easing.OutQuad
	}
	NumberAnimation {
		target: target_item
		property: "scale"
		to: 1.0
		duration: 200
		easing.type: Easing.OutBack
	}
}
