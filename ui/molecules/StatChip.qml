import qs.ui.atoms
import QtQuick

RadialBar {
	id: root

	property string defaultIcon: ""
	QtObject {
		id: internal

		property bool isHovered: false
	}

	w: 26
	h: 26

	// Si el mouse está encima, muestra el número redondeado; si no, el ícono
	icon: internal.isHovered ? Math.round(root.value) : defaultIcon

	MouseArea {
		anchors.fill: parent
		hoverEnabled: true

		onEntered: internal.isHovered = true
		onExited: internal.isHovered = false
	}
}
