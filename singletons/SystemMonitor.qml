pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

QtObject {
	id: root

	property real cpu_usage: 0
	property real ram_usage: 0
	property real ram_used: 0
	property real total_ram: 0

	property real _last_cpu_idle: 0
	property real _last_cpu_total: 0

	// Proceso para leer CPU
	property Process cpu_proc: Process {
		command: ["sh", "-c", "head -1 /proc/stat"]
		stdout: SplitParser {
			onRead: data => {
				let parsedData = data.trim().split(/\s+/)
				let idle = parseInt(parsedData[4]) + parseInt(parsedData[5])
				let total = parsedData.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
				if (root._last_cpu_total > 0) 
				root.cpu_usage = Math.round(100 * (1 - (idle - root._last_cpu_idle) / (total - root._last_cpu_total)))
				root._last_cpu_total = total
				root._last_cpu_idle = idle
			}
		}
		Component.onCompleted: running = true
	}
	// Proceso para leer RAM
	property Process ram_proc: Process {
		command: ["sh", "-c", "free | grep Mem"]
		stdout: SplitParser {
			onRead: data => {
				let parts = data.trim().split(/\s+/)
				let total = parseInt(parts[1]) || 1
				let used = parseInt(parts[2]) || 1
				if (!root.total_ram) root.total_ram = Math.ceil(total / (1024 ** 2))
				root.ram_used = (used / (1024 ** 2)).toFixed(2)
				root.ram_usage = Math.round(100 * used / total)
			}
		}
		Component.onCompleted: running = true
	}

	property Timer updateTimer: Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: {
			root.cpu_proc.running = true
			root.ram_proc.running = true
		}
	}
}
