import qs.singletons

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Item {
	id: root
	width: 200
	height: 100
	property var audioData: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	property bool can_run: true
	property string config_path: Qt.resolvedUrl("../../cava_config.conf")
	Process {
		command: ["cava", "-p", root.config_path.replace("file://", "")]
		running: root.can_run

		stdout: SplitParser {
			onRead: data => {
				let values = data.trim().split(';').filter(x => x !== "")
				if (!values.length) return
				
				audioData = values.map(Number)
			}
		}
	}

	onCan_runChanged: {
		if (root.can_run) return

		root.audioData = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	}

	RowLayout {
		anchors.fill: parent
		anchors.bottom: parent.bottom
		spacing: 4
		Repeater {
			model: audioData
			Rectangle {
				Layout.alignment: Qt.AlignBottom
				width: 15

				height: Math.max(2, modelData) 

				color: Theme.primary_main
				radius: 2

				Behavior on height {
					NumberAnimation { duration: 50 }
				}
			}
		}
	}
}
