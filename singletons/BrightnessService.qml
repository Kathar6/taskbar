pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
	id: root

	property real brightness: 100

	function setBrightness(value) {
		let safe_value = Math.max(5, Math.min(100, value));
		root.brightness = safe_value;

		let decimal_value = safe_value / 100.0;
		setProcess.command = ["busctl", "--user", "set-property", "rs.wl-gammarelay", "/", "rs.wl.gammarelay", "Brightness", "d", decimal_value.toString()];
		setProcess.running = true;
	}

	property Process setProcess: Process {
		id: setProc
	}

	property Process initialRead: Process {
		id: readProc
		command: ["sh", "-c", "busctl --user get-property rs.wl-gammarelay / rs.wl.gammarelay Brightness | awk '{print $2 * 100}'"]
		running: true
		stdout: SplitParser {
			onRead: data => {
				let val = parseFloat(data);
				if (!isNaN(val)) {
					root.brightness = val;
				}
			}
		}
	}
}
