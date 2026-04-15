pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: theme

    property color primary_main: "#E5E7EB"
    property color primary_100: "#191C1F"
    property color primary_200: "#2D3134"
    property color primary_300: "#44474A"
    property color primary_400: "#5C5F62"
    property color primary_500: "#74777B"
    property color primary_600: "#8E9195"
    property color primary_700: "#A9ABAF"
    property color primary_800: "#C4C7CA"
    property color primary_900: "#E0E2E6"
    property color primary_000: "#EFF1F5"

		property color secondary_main: "#94A3B8"
    property color secondary_100: "#0D1C2D"
    property color secondary_200: "#233143"
    property color secondary_300: "#39485A"
    property color secondary_400: "#516072"
    property color secondary_500: "#69788C"
    property color secondary_600: "#8392A6"
    property color secondary_700: "#9DACC2"
    property color secondary_800: "#B9C8DE"
    property color secondary_900: "#D4E4FA"
    property color secondary_000: "#E9F1FF"

    property color tertiary_main: "#F8FAFC"

    property color neutral_main: "#0F172A"
    property color neutral_100: "#131B2E"
    property color neutral_200: "#283044"
    property color neutral_300: "#3F465C"
    property color neutral_400: "#565E74"
    property color neutral_500: "#6F778E"
    property color neutral_600: "#8990A8"
    property color neutral_700: "#A3ABC4"
    property color neutral_800: "#BEC6E0"
    property color neutral_900: "#DAE2FD"
    property color neutral_000: "#EEF0FF"

    property string fontFamily: "DepartureMono Nerd Font"
    property color white: "#FAFAFA"

		property string user_icon: ""
}
