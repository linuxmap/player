import QtQuick 2.4
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0 as FluidControls

Rectangle {
    id:_back
    width:_row.implicitWidth
    height:  _row.implicitHeight
    property color iconsColor
    signal showMinimized;
    signal showMaximized;
    signal showFullScreen;
    signal showNormal;
    signal close;

    RowLayout {
        id: _row
        anchors{
            right: parent.right
            top: parent.top
        }

        spacing: 10

        Item {
            width: 1
        }
        FluidControls.IconButton {
            iconSource: "qrc:///images/window-minimize.svg"
            iconSize: 20
            iconColor: _back.iconsColor
            onClicked: _back.showMinimized()
        }

        FluidControls.IconButton {
            iconSource: root.visibility == 4 ? "qrc:///images/window-restore.svg" : "qrc:///images/window-maximize.svg"
            id: sysbtn_max
            iconSize: 20
            iconColor: _back.iconsColor
            onClicked: {
                if(root.visibility == 2)
                    _back.showMaximized();
                else
                    _back.showNormal();
            }
        }

        FluidControls.IconButton {
            iconSource: "qrc:///images/window-close.svg"
            iconSize: 20
            iconColor: _back.iconsColor
            onClicked: _back.close()
        }
    }
}
