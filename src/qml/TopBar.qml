import QtQuick.Layouts 1.0
import QtQuick 2.5
import QtQuick.Controls 2.0
import Fluid.Controls 1.0 as FluidControls

Rectangle {
    id: top_bar
    z:5
    opacity: 1
    anchors {
        top: parent.top
        right: parent.right
        left: parent.left
    }
    height: 60
    gradient: Gradient {
        GradientStop { position: 0.0; color: root.noMedia ? theme.primaryColor :  Qt.rgba(0,0,0,0.4) }
        GradientStop { position: 1.0; color: root.noMedia ? theme.primaryColor :  "transparent" }
    }
    Behavior on opacity {
        NumberAnimation { duration: 500 }
    }

    Row {
        anchors {
            left: parent.left
            top: parent.top
            margins: 15
        }
        spacing: 10
        FluidControls.IconButton {
            id: menuButton
            iconName: "navigation/menu"
            iconColor: "white"
            iconSize: 30
            onClicked: menu.open(menuButton,menu.width - menuButton.width,0)
        }
        FluidControls.IconButton {
            id: lockButton
            visible: false
            iconName: "action/lock"
            iconColor: "white"
            iconSize: 20
            onClicked: forceBars = !forceBars
        }
        FluidControls.IconButton {
            id: libraryButton
            visible: true
            iconName: "av/my_library_music"
            iconColor: "white"
            iconSize: 30
            onClicked: pageStack.push(libraryPage)
        }
        FluidControls.TitleLabel {
            text: "Liri Player"
            color: "white"
            visible: root.noMedia
        }
        FluidControls.TitleLabel {
            text: root.currentMedia.title
            color: "white"
            visible: !root.noMedia && !root.isAudio
        }

    }

    Menu {
        id: menu
        objectName: "menu"

        MenuItem {
            text: "Open"
            // FIXME: iconName doesn't exist
            //iconName: "file/folder_open"
            onClicked: {
                menu.close();
                filedialog.toPlay = true;
                filedialog.visible = true;
            }
        }
        MenuItem {
            text: "Open and add to queue"
            // FIXME: iconName doesn't exist
            //iconName: "av/queue_music"
            onClicked: {
                menu.close();
                filedialog.toPlay = false;
                filedialog.visible = true;
            }
        }
        MenuItem {
            text: "Stop"
            // FIXME: iconName doesn't exist
            //iconName: "av/stop"
            visible: !root.noMedia
            onClicked: {
                player.stop()
                menu.close()
            }
        }
        MenuItem {
            text: "Settings"
            // FIXME: iconName doesn't exist
            //iconName: "action/settings"
            onClicked: {
                menu.close();
                settingsDrawer.open()
            }
        }
        MenuItem {
            text: "Quit"
            // FIXME: iconName doesn't exist
            //iconName: "action/exit_to_app"
            onClicked: {
                menu.close()
                Qt.quit()
            }
        }
    }

    SystemButtons {
        id: sysbuttons
        z:90
        visible: !plugin
        color: "transparent"
        onShowMinimized: root.showMinimized();
        onShowMaximized: root.showMaximized();
        onShowNormal: root.showNormal();
        onClose: Qt.quit();
        iconsColor: "white"
        anchors {
            right: parent.right
            top: parent.top
            margins: 15
        }
    }
}
