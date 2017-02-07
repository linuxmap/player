import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0 as FluidControls

Item {
    id: settingsRoot
    z:2
    width: 300
    anchors {
        left: parent.left
        top: parent.top
        bottom: parent.bottom
        leftMargin: -width - 20
    }

    Behavior on anchors.leftMargin {
        NumberAnimation {
            duration: 300
        }
    }

    function open() {
        anchors.leftMargin = 0
        shadow.visible = true
    }

    function close() {
        anchors.leftMargin = -width - 20
        shadow.visible = false
    }

    Column {
        anchors.fill: parent
        Item {
            height: 50
            width: parent.width
            FluidControls.HeadlineLabel {
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    margins: 15
                }

                text: "Settings"
            }
        }
        FluidControls.ListItem {
            text: "Accent Color"
            rightItem: Rectangle {
                id: accentcolorSample
                width: 30
                height: width
                radius: width*0.5
                color: accentColorPicker.color
                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin:5
                    rightMargin: 15
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: accentColorPicker.open()
                }
            }
        }
        ColorPicker {
            id: accentColorPicker
            x: accentcolorSample.x + 30
            y: accentcolorSample.y - 4
            color: Material.accentColor
        }
        FluidControls.ListItem {
            text: "Primary Color"
            rightItem: Rectangle {
                id: primarycolorSample
                width: 30
                height: width
                radius: width*0.5
                color: primaryColorPicker.color
                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin:5
                    rightMargin: 15
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: primaryColorPicker.open()
                }
            }
        }
        ColorPicker {
            id: primaryColorPicker
            x: primarycolorSample.x + 30
            y: primarycolorSample.y - 4
            color: Material.primaryColor
        }
    }
    Row {
        anchors{
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            margins: 15
        }
        spacing: 15
        Button {
            text: "Save"
            Material.elevation: 1
            // FIXME: backgroundColor doesn't exist
            //backgroundColor: theme.accentColor
            onClicked: {
                Material.accentColor = accentColorPicker.color
                Material.primaryColor = primaryColorPicker.color
                close()
            }
        }
        Button {
            text: "reset"
            Material.elevation: 1
            onClicked: {
                accentColorPicker.color = Material.accentColor
                primaryColorPicker.color = Material.primaryColor
                close()
            }
        }
    }
}

