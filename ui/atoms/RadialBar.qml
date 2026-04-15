import qs.singletons

import Quickshell
import QtQuick
import QtQuick.Shapes

Shape {
	id: root
	property int w: 10
	property int h: 10
	property color current_color: Theme.primary_main
	property int stroke_width: 2
	property int value: 100
	property string icon
	property int icon_size: 12
	property bool icon_bold: false

	onIconChanged: {
		if (!bounce_anim.running) {
			bounce_anim.start()
		}
	}

	width: w
	height: h
	antialiasing: true
	asynchronous: true
	preferredRendererType: Shape.CurveRenderer

	ShapePath {
		id: bg_path
		fillColor: "transparent"
		strokeColor: Theme.neutral_300
		strokeWidth: root.stroke_width
		capStyle: ShapePath.FlatCap

		property real radius: Math.round((root.w / 2) - (strokeWidth / 2))
		property real centerX: Math.round(root.w / 2)
		property real centerY: Math.round(root.h / 2)

		startX: centerX - radius
		startY: centerY

		PathAngleArc {
			centerX: bg_path.centerX
			centerY: bg_path.centerY
			radiusX: bg_path.radius
			radiusY: bg_path.radius
			startAngle: 0
			sweepAngle: 360
		}
	}

	ShapePath {
		id: path
		fillColor: "transparent"
		strokeColor: current_color
		strokeWidth: root.stroke_width
		capStyle: ShapePath.RoundCap

		property real radius: Math.round((root.w / 2) - (strokeWidth / 2))
		property real centerX: Math.round(root.w / 2)
		property real centerY: Math.round(root.h / 2)

		startX: centerX - radius
		startY: centerY

		PathAngleArc {
			centerX: path.centerX
			centerY: path.centerY
			radiusX: path.radius
			radiusY: path.radius
			startAngle: 0

			Behavior on sweepAngle {
				NumberAnimation {
					duration: 200
					easing.type: Easing.OutCubic
				}
			}

			sweepAngle: (value * 360) / 100
		}
	}

	AppText {
		id: myText
		anchors.centerIn: parent
		text: root.icon
		font.pixelSize: root.icon_size

		transformOrigin: Item.Center
		BounceBehavior {
			id: bounce_anim
			target_item: myText
		}
	}
}
