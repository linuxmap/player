import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0 as FluidControls

Item {
    id: playlistRoot
    z:10
    width: 350
    anchors {
        right: parent.right
        top: parent.top
        bottom: parent.bottom
        rightMargin: -width - 20
    }

    Behavior on anchors.rightMargin {
        NumberAnimation {
            duration: 300
        }
    }
    function open() {
        anchors.rightMargin = 0
        shadow.visible = true
        topBar.opacity = 100
    }

    function close() {
        anchors.rightMargin = -width - 20
        shadow.visible = false
    }

    Column  {
        anchors.fill: parent
        Item {
            height: 50
            width: parent.width
            FluidControls.HeadlineLabel {
                id: label
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    margins: 15
                }

                text: "Playlist"
            }
            FluidControls.IconButton {
                id: clearPlaylist

                anchors {
                    left: label.right
                    leftMargin: 16
                    verticalCenter: parent.verticalCenter
                }
                iconName: "action/done_all"

                onClicked: {
                    root.currentPlaylistModel.clear()
                    player.playlist.clear()
                }
            }
            Label {
                id: labelclr
                anchors {
                    left: clearPlaylist.right
                    leftMargin: 8
                    verticalCenter: parent.verticalCenter
                }


                text: "Clear"
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
                iconsColor: "grey"
                anchors {
                    top: parent.top
                    margins: 15
                    right: parent.right
                }
            }
        }
        ListView {
            model: root.currentPlaylistModel
            width: playlistRoot.width
            height: playlistRoot.height
            delegate: FluidControls.ListItem {
                id: delegate
                text: title
                iconName: index == player.playlist.currentItem ? "av/play_arrow" : ""
                onClicked: player.playlist.playItem(index)
            }
        }
    }
    Row {
        anchors{
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            margins: 0
        }
        spacing: 0

        Rectangle {
            color: "white"
            width: playlistDrawer.width
            height: 50


        Button {
            text: "add"
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: parent.bottom

                rightMargin: 30
                leftMargin: 30
                bottomMargin: 5
                topMargin: 7
            }
            id: addbutton
            Material.elevation: 2
            onClicked: {
                filedialog.toPlay = false;
                filedialog.visible = true;
            }
        }
        }
    }

}

