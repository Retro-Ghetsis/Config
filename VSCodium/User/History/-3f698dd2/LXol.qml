import Quickshell
import QtQuick
import Quickshell.Io

Variants {
    model: Quickshell.screens
    delegate: Component {

    }
}

PanelWindow {
    anchors {
        right: true
        top: true
        left: true
    }

    implicitHeight: 30

    
}