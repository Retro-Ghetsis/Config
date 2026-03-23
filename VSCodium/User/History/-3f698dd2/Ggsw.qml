import Quickshell
import QtQuick
import Quickshell.Io

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
            command: ["date"]

            running: true

            stdout: StdioCollecter {
                onStreamFinished: clock.text = this.text
            }
        }
    }
}