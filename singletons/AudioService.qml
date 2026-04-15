pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

QtObject {
	id: root

	readonly property PwNode sink: Pipewire.defaultAudioSink
	readonly property PwObjectTracker tracker: PwObjectTracker {
		objects: [sink]
	}

	property int volume: Math.round((sink?.audio?.volume ?? 0) * 100)
	property real precise_volume: sink?.audio?.volume ?? 0
	property bool muted: sink?.audio?.muted

	function setVolume(new_value) {
		if (!sink || !sink.audio) return

		sink.audio.volume = new_value / 100
	}

	function toggleMute() {
		if (!sink || !sink.audio) return

		sink.audio.muted = !sink.audio.muted
	}
}
