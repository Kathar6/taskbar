import qs.singletons
import qs.ui.atoms
import qs.ui.organisms

import Quickshell
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

PanelWindow {
	id: media_window
	required property var current_screen
	screen: current_screen


	implicitWidth: 600
	implicitHeight: 260
	exclusionMode: ExclusionMode.Ignore
	color: "transparent"

	QtObject {
		id: internal
		property bool can_show: WindowManager.show_media_panel && WindowManager.active_screen === current_screen
		property int margin_top: -330

		onCan_showChanged: {
			if (can_show) {
				margin_top = 42
				return
			}

			margin_top = -330
		}

		Behavior on margin_top {
			NumberAnimation {
				duration: 200
				easing.type: Easing.OutCubic
			}
		}
	}

	anchors {
		top: true
		left: true
	}

	margins {
		top: internal.margin_top
		left: 5
	}

	visible: internal.can_show

	CavaPlayer {
		id: visualizer
		can_run: internal.can_show
		x: 0
		y: 0
		width: 600
		height: 260

		layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Rectangle {
            width: visualizer.width
            height: visualizer.height
            radius: 6 
        }
    }
	}

	Bar {
		anchors.fill: parent
		color: Qt.alpha(Theme.neutral_main, 0.8)
		border {
			color: Theme.neutral_200
		}

		ColumnLayout {
			anchors.fill: parent
			anchors.margins: 10

			// Image - Title Row
			RowLayout {
				Layout.fillWidth: true
				Layout.preferredHeight: 80
				spacing: 20

				AppImage {
					source: MediaService.image
				}

				ColumnLayout {
					Layout.fillWidth: true
					Layout.fillHeight: true
					spacing: 5

					AppText {
						text: MediaService.title
						Layout.maximumWidth: 400
						wrapMode: Text.NoWrap
						elide: Text.ElideRight
						font.pixelSize: 16

						AppToolTip {
							text: MediaService.title
							visible: hover_area.containsMouse
						}

						MouseArea {
							id: hover_area
							hoverEnabled: true
							anchors.fill: parent
						}
					}

					AppText {
						text: `${MediaService.artist} - ${MediaService.album}`
						font.pixelSize: 14
					}
				}
			}

			// Player Row
			ColumnLayout {
				Layout.fillWidth: true
				Layout.preferredHeight: 80
				spacing: 10

				RowLayout {
					Layout.fillWidth: true

					Item {
						Layout.fillWidth: true
					}
					AppButton {
						Layout.preferredWidth: 40
						Layout.preferredHeight: 40
						text: "\udb81\udcae"
						pixelSize: 24
						onClick: () => MediaService.previous()
					}
					AppButton {
						Layout.preferredWidth: 40
						Layout.preferredHeight: 40
						text: MediaService.is_playing ? "\uf04c" : "\uf04b"
						onClick: () => {
							if (MediaService.is_playing) return MediaService.pause()
							MediaService.play()
						}
					}
					AppButton {
						Layout.preferredWidth: 40
						Layout.preferredHeight: 40
						text: "\udb81\udcad"
						pixelSize: 24
						onClick: () => MediaService.next()
					}
					Item {
						Layout.fillWidth: true
					}
				}

				RowLayout {
					Layout.fillWidth: true
					AppSlider {
						id: slider
						Layout.fillWidth: true
						from: 0
						to: MediaService.active_player?.length || 1
						value: MediaService.active_player?.position || 0
						Binding {
							target: slider
							property: "value"
							value: MediaService.active_player?.position || 0
							when: !slider.pressed 
						}

						onMoved: {
							if (MediaService.active_player) {
								MediaService.active_player.position = slider.value
							}
						}
					}
				}

				RowLayout {
					Layout.fillWidth: true
					Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

					AppText {
						text: `${MediaService.position} / ${MediaService.length}`
					}
				}
			}

			// Player Selector Row
			RowLayout {
				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
				Layout.fillWidth: true
				Layout.preferredHeight: 50
				visible: MediaService.players_count > 1

				AppSelect {
					id: apps
					Layout.preferredWidth: 200
					textRole: "text"
					valueRole: "value"
					currentIndex: MediaService.active_player_index
					model: {
						const players = MediaService.getPlayers()

						const formattedOptions = players.map((current_player, index) => {
							return { value: index, text: qsTr(current_player.identity)}
						})

						return formattedOptions
					}
					onActivated: (index) => MediaService.setActivePlayer(index)
				}
			}
		}
		Timer {
			running: MediaService.is_playing
			interval: 1000
			repeat: true
			onTriggered: MediaService.active_player.positionChanged()
		}
	}
}
