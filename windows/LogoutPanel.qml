import qs.singletons
import qs.ui.atoms
import qs.ui.organisms

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

PanelWindow {
	id: logout_window

	exclusionMode: ExclusionMode.Ignore
	color: "transparent"

	QtObject {
		id: internal
		property bool can_show: WindowManager.show_logout_panel
	}

	anchors {
		top: true
		right: true
		left: true
		bottom: true
	}

	margins {
		top: 0
	}

	visible: internal.can_show

	Rectangle {
		anchors.fill: parent
		color: Qt.alpha(Theme.neutral_100, 0.6)

		MouseArea {
			anchors.fill: parent
			onClicked: () => WindowManager.toggleLogoutPanel()
		}

		RowLayout {
			anchors.fill: parent

			Bar {
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
				Layout.preferredWidth: 400
				Layout.preferredHeight: 300
				current_color: Qt.alpha(Theme.neutral_main, 0.8)

				border {
					color: Theme.neutral_200
				}

				ColumnLayout {
					Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
					anchors.fill: parent
					anchors.margins: 15
					spacing: 10

					LogoutButton {
						Layout.fillWidth: true
						Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
						text: "\udb81\udd94  Suspend"
						onClick: () => suspend_proc.running = true
					}
					LogoutButton {
						Layout.fillWidth: true
						Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
						text: "\udb80\udf43  Logout"
						onClick: () => logout_proc.running = true
					}
					LogoutButton {
						Layout.fillWidth: true
						Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
						text: "\udb81\udc53  Reboot"
						onClick: () => reboot_proc.running = true
					}
					LogoutButton {
						Layout.fillWidth: true
						Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
						text: "\u23fb  Shutdown"
						onClick: () => shutdown_proc.running = true
					}
					Item {
						Layout.fillHeight: true
					}
				}

			}
		}

		Process {
			id: suspend_proc
			running: false
			command: ["systemctl", "suspend"]
		}

		Process {
			id: logout_proc
			running: false
			command: ["hyprctl", "dispatch",  "exit"]
		}

		Process {
			id: shutdown_proc
			running: false
			command: ["systemctl", "poweroff"]
		}

		Process {
			id: reboot_proc
			running: false
			command: ["systemctl", "reboot"]
		}

	}
}
