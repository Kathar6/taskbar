import qs.singletons
import qs.ui.atoms

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Bar {
  current_color: Theme.neutral_main
  Layout.fillHeight: true
  implicitWidth: 200
	border {
		color: Theme.neutral_200
	}

  // If special ws is closed, will be -1
  property int special_ws_position: 0
  property int pointing_ws: -1

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      if (event.name !== "activespecial") return
      // is focusedWorkspace is empty, is closed event
      const focusedWorkspace = event.data.split(",")[0]

      if (!focusedWorkspace) {
        special_ws_position = -1
        return
      }

      special_ws_position = Hyprland.focusedWorkspace.id
    }
  }

  Row {
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 5

    Repeater {
      anchors.fill: parent

      model: 10

      Rectangle {
				id: rect
        property bool is_hover: false
        property var workspace: Hyprland.workspaces.values.find(w => w.id === index + 1)
        property bool is_active: Hyprland.focusedWorkspace?.id === (index + 1)
        implicitWidth: is_active ? 35 : 8
        implicitHeight: 8
        color: {
          if (is_hover)
          return Theme.secondary_main
          if (special_ws_position == index + 1)
          return Theme.secondary_800
          if (is_active)
          return Theme.primary_main
					if (workspace)
					return Theme.primary_600

          return Theme.neutral_400
        }
        radius: 6

        Behavior on implicitWidth {
          NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
          }
        }

        Connections {
          target: hoverArea
          function onEntered() {
            is_hover = true
          }
          function onExited() {
            is_hover = false
          }
        }

        MouseArea {
          id: hoverArea
          hoverEnabled: true
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: Hyprland.dispatch("workspace " + (index + 1))
        }
      }
    }
  }
}
