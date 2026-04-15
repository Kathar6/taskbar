import qs.singletons
import qs.ui.molecules

import Quickshell
import QtQuick
import QtQuick.Layouts

ColumnLayout {
	Layout.fillWidth: true
	Layout.preferredHeight: 100
	AppFormSlider {
		icon: {
			if (AudioService.muted) return "\uf466"
			if (AudioService.volume > 30) return ""
			return "\uf027"
		}
		label: "VOLUME"
		value: AudioService.volume
		steps: 1

		onClickIcon: () => AudioService.toggleMute()

		onValueChange: (new_value) => AudioService.setVolume(new_value)
	}
	AppFormSlider {
		icon: {
			if (BrightnessService.brightness > 86) return "\udb80\udce0"
			if (BrightnessService.brightness > 72) return "\udb80\udcdf"
			if (BrightnessService.brightness > 58) return "\udb80\udcde"
			if (BrightnessService.brightness > 44) return "\udb80\udcdd"
			if (BrightnessService.brightness > 30) return "\udb80\udcdc"
			if (BrightnessService.brightness > 15) return "\udb80\udcdb"
			return "\udb80\udcda"
		}
		label: "BRIGHTNESS"
		value: BrightnessService.brightness
		steps: 1

		onValueChange: (new_value) => BrightnessService.setBrightness(new_value)
	}
}
