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

        Process {
      // the command it will run, every argument is its own string
      command: ["date"]

      // run the command immediately
      running: true

      // process the stdout stream using a StdioCollector
      // Use StdioCollector to retrieve the text the process sends
      // to stdout.
      stdout: StdioCollector {
        // Listen for the streamFinished signal, which is sent
        // when the process closes stdout or exits.
        onStreamFinished: clock.text = this.text // `this` can be omitted
      }
    }
    }
}