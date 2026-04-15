pragma Singleton

import QtQuick

QtObject {
	property bool show_config_panel: false
	property bool show_logout_panel: false
	property bool show_media_panel: false
	property var active_screen: null

	function toggleMediaPanel(screen) {
		if (active_screen === screen && show_media_panel) {
			show_media_panel = false
			return
		}
		active_screen = screen
		show_media_panel = true
	}

	function toggleConfigPanel(screen) {
		if (active_screen === screen && show_config_panel) {
			show_config_panel = false
			return
		}
		active_screen = screen
		show_config_panel = true
	}

	function toggleLogoutPanel() {
		show_logout_panel = !show_logout_panel
	}
}
