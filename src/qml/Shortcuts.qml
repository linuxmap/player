import QtQuick 2.0
import Fluid.Controls 1.0 as FluidControls


Item {
    FluidControls.Action {
        shortcut: "Space"
        onTriggered: {
            player.togglePause()
        }
    }
    FluidControls.Action {
        shortcut: "Ctrl+N"
        onTriggered: {
            root.app.createWindow()
        }
    }
    FluidControls.Action {
        shortcut: "Esc"
        onTriggered: {
        if(root.fullscreen) showNormal(); else null();
        }
    }
    FluidControls.Action {
        shortcut: "Ctrl+F"
        onTriggered: {
        if(root.fullscreen) null(); else showFullScreen();
        }
    }

}
