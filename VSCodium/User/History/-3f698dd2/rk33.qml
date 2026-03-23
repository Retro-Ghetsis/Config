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
            id: dateProc
            command: ["date"]

            running: true

            stdout: StdioCollector {
                onStreamFinished: clock.text = this.text
            }
        }
        Timer {
            
        }
    }
}