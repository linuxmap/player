import QtQuick 2.0
import QtQuick.Controls 2.0


Popup {
    id: colorPicker
    property alias color: colorChooser.color
    property alias titel: colorChooser.title

    width: 300
    height: 196

    ColorChooser {
        id: colorChooser
        colorPicker: colorPicker
        anchors.fill: parent
    }
}
