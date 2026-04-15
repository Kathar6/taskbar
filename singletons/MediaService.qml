pragma Singleton

import Quickshell
import Quickshell.Services.Mpris
import QtQuick

QtObject {
	id: root

	property int players_count: Mpris.players?.values?.length || 0
	property MprisPlayer active_player: null

	function updateActivePlayer() {
		let current_players = Mpris.players.values
		if (!current_players?.length) return null

		let new_player = null
		for (const current_player of current_players) {
			if (current_player.isPlaying) new_player = current_player
		}
		if (!new_player) new_player = current_players[0]

		root.active_player = new_player
	}

	function formatTime(value) {
		if (!active_player) return "0:00"
		if (!value || value <= 0) return "0:00";

		let totalSeconds = Math.floor(value);
		let minutes = Math.floor(totalSeconds / 60);
		let seconds = totalSeconds % 60;

		return minutes + ":" + (seconds < 10 ? "0" : "") + seconds
	}

	onPlayers_countChanged: {
		root.updateActivePlayer()
	}

	Component.onCompleted: {
		root.updateActivePlayer()
	}

	property bool is_playing: active_player?.isPlaying ?? false
	property string title: active_player?.trackTitle ?? "N/A"
	property string artist: active_player?.trackArtist || "Unkown Artist"
	property string album: active_player?.trackAlbumArtist || "Unkown Album"
	property string image: active_player?.trackArtUrl ?? ""
	property string length: formatTime(active_player?.length)
	property string position: formatTime(active_player?.position)

	function setActivePlayer(index) {
		let current_players = Mpris.players.values
		if (!current_players?.length || !current_players[index]) return
		root.active_player = current_players[index]
	}

	function play() {
		if (!active_player) return
		active_player.play()
	}

	function pause() {
		if (!active_player) return
		active_player.pause()
	}

	function next() {
		if (!active_player) return
		active_player.next()
	}
	
	function previous() {
		if (!active_player) return
		active_player.previous()
	}

	function stop() {
		if (!active_player) return
		active_player.stop()
	}

	function getPlayers() {
		let current_players = Mpris.players.values

		if (!current_players) return []

		return current_players
	}
}
