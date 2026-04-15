import qs.singletons

import Quickshell
import QtQuick
import QtQuick.Controls.Basic

ComboBox {
	id: root
	editable: true

	background: Rectangle {
		implicitWidth: 120
		implicitHeight: 40
		color: Theme.neutral_200
		border {
			color:  Theme.neutral_300
		}
		radius: 4
	}

	contentItem: AppText {
		leftPadding: 10

		text: root.displayText
		color: root.pressed ? Theme.primary_500 : Theme.primary_main
		verticalAlignment: Text.AlignVCenter
		elide: Text.ElideRight
		HoverHandler {
			cursorShape: Qt.PointingHandCursor
		}
	}

	delegate: ItemDelegate {
		id: delegate

		required property var model
		required property int index

		width: root.width
		contentItem: AppText {
			text: delegate.model[root.textRole]
			elide: Text.ElideRight
			verticalAlignment: Text.AlignVCenter
		}
		highlighted: root.highlightedIndex === index

		background: Rectangle {
			color: delegate.hovered ? Theme.neutral_200 : "transparent"
		}
		HoverHandler {
			cursorShape: Qt.PointingHandCursor
		}
	}

	indicator: AppText {
		x: root.width - width - root.rightPadding
		y: root.topPadding + (root.availableHeight - height) / 2

		text: "" 
		font.pixelSize: 16

		color: root.pressed ? Theme.primary_500 : Theme.primary_main 
	}

	popup: Popup {
		id: menu
		y: root.height - 1
		closePolicy: Popup.CloseOnEscape
		width: root.width
		height: Math.min(contentItem.implicitHeight, root.Window.height - topMargin - bottomMargin)
		padding: 1

		contentItem: ListView {
			clip: true
			implicitHeight: contentHeight
			model: root.popup.visible ? root.delegateModel : null
			currentIndex: root.highlightedIndex

			ScrollIndicator.vertical: ScrollIndicator { }
		}

		background: Rectangle {
			border.color: Theme.neutral_300
			radius: 4
			color: Theme.neutral_main
		}

		enter: Transition {
			NumberAnimation { 
				property: "scale"
				from: 0.6
				to: 1.0
				duration: 200 
				easing.type: Easing.OutBack
			}
			NumberAnimation { 
				property: "opacity"
				from: 0.0
				to: 1.0
				duration: 150 
			}
		}
	}
}
