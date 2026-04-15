import Quickshell
import QtQuick

Behavior {
	id: anim
	property Item fadeTarget: targetProperty.object
	SequentialAnimation {
		id: bounceAnim
		NumberAnimation {
			target: myText
			property: "scale"
			to: 0.6 
			duration: 90 
			easing.type: Easing.OutQuad
		}
		NumberAnimation {
			target: myText
			property: "scale"
			to: 1.0
			duration: 200
			easing.type: Easing.OutBack
		}
	}
}
