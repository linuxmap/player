import QtQuick 2.0
import Fluid.Controls 1.0 as FluidControls
import Fluid.Material 1.0 as FluidMaterial


Item {
    id: colorChooser
    property color color
    property string title
    property Item colorPicker

    width: 300
    height: 196

    FluidControls.TitleLabel {
        id: lblTitle
        font.family: root.fontFamily
        text: title || qsTr("Choose a color")
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 24

    }

    Grid {
        columns: 7
        spacing: 8
        id: grid
        anchors.top: lblTitle.bottom
        anchors.topMargin: 24
        anchors.horizontalCenter: parent.horizontalCenter

        Repeater {
            model: [
                "red", "pink", "purple", "deepPurple", "indigo",
                "blue", "lightBlue", "cyan", "teal", "green",
                "lightGreen", "lime", "yellow", "amber", "orange",
                "deepOrange", "grey", "blueGrey", "brown", "black",
                "white"
            ]

            Rectangle {
                width: 30
                height: 30
                radius: 2
                // TODO: color
                //color: Palette.colors[modelData]["500"]
                border.width: color === colorChooser.color ? 2 : 0
                //border.color: Theme.alpha("#000", 0.26)

                FluidMaterial.Ripple {
                    anchors.fill: parent

                    onPressed: {
                        colorChooser.color = parent.color;
                        if (colorPicker) colorPicker.close();
                    }
                }
            }
        }
    }
}
