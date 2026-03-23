import Quickshell
import QtQuick

PanelWindow {
    anchors {
        right: true
        bottom: true
    }

    implicitHeight: 1600

    Text {
        anchors.centerIn: parent
        text: "First Shell"
    }
}