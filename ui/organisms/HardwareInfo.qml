import qs.singletons
import qs.ui.atoms
import qs.ui.molecules

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

ColumnLayout {
	Layout.preferredHeight: 100
	Layout.alignment: Qt.AlignHCenter

	QtObject {
		id: internal

		property string cpu_name: ""
	}

	RowLayout {
		Layout.fillWidth: true
		Layout.fillHeight: true
		spacing: 20

		HardwareCard {
			title: "CPU"
			footer_text: internal.cpu_name
			value: SystemMonitor.cpu_usage
		}

		HardwareCard {
			title: "MEMORY"
			footer_text: `${SystemMonitor.ram_used}GB / ${SystemMonitor.total_ram}GB`
			value: SystemMonitor.ram_usage
		}
	}

	Process {
		id: cpu_name_proc
		command: ["sh", "-c", "awk -F': ' '/model name/ {print $2; exit}' /proc/cpuinfo"]
    running: internal.cpu_name == ""
    
    stdout: SplitParser {
        onRead: data => {
            internal.cpu_name = data.trim()
        }
    }
	}
}
