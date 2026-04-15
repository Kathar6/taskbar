import qs.singletons
import qs.ui.atoms

import Quickshell
import QtQuick

AppText {
	id: root
	font.pixelSize: 16

	text: {
		Qt.formatDateTime(clock.date, "hh:mm AP");
	}

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}
