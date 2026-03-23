import Quickshell
import QtQuick

PanelWindow {
    anchors {
        right: true
        bottom: true
        left: true
    }

    implicitHeight: 30

    Text {
        anchors.centerIn: parent
        text: "First Shell"
    }
}