import Quickshell
import QtQuick

PanelWindow {
    anchors {
        right: true
        top: true
        left: true
    }

    implicitHeight: 30

    Text {
        id: clock
        anchors.centerIn: parent
        
        Process {
            commad: ["date"]

            running: true

            stdout: StdioCollecter {
                onStreamFinished: clock.text = .text
            }
        }
    }
}