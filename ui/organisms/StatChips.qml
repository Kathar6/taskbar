import qs.singletons
import qs.ui.atoms
import qs.ui.molecules

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {
	Layout.fillWidth: true
	Layout.fillHeight: true
	Layout.alignment: Qt.AlignHCenter
	spacing: 6

	// ========== AUDIO ================

	StatChip {
		value: AudioService.volume
		defaultIcon: AudioService.muted ? "\uf466" : ""
		Layout.alignment: Qt.AlignVCenter
	}

	// ========== CPU ================

	StatChip {
		value: SystemMonitor.cpu_usage
		defaultIcon: ""
		Layout.alignment: Qt.AlignVCenter
	}

	// ========== RAM ================

	StatChip {
		value: SystemMonitor.ram_usage
		defaultIcon: ""
		Layout.alignment: Qt.AlignVCenter
	}
}
