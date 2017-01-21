import QtQuick 2.2
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.folderlistmodel 2.1
//import Username 1.0
import Fluid.Controls 1.0 as FluidControls

FluidControls.TabbedPage {
    id: page
    title: "My Library"
    // FIXME: backgroundColor is not available
    //backgroundColor: Material.color(Material.Grey, Material.Shade200)

    FluidControls.Tab {
        title: "Music"

        ListView {
            y: 150
            width: 200; height: 400

            FolderListModel {
                folder: musicDir
                id: musicFolderModel
                nameFilters: ["*.mp3"]
            }

            Component {
                id: musicDelegate
                Pane {
                    height: 40
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: FluidControls.Units.gu(1)
                    }

                    Material.elevation: 1
                    Label {
                        anchors {
                            left: parent.left
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                            margins: 10
                        }
                        text: fileName
                        MouseArea {
                            anchors.fill: parent
                            onClicked: player.mrl = fileURL
                        }
                    }
                }
            }

            model: musicFolderModel
            delegate: musicDelegate
        }
    }

    FluidControls.Tab {
        title: "Videos"

        ListView {
            y: 150
            width: 200; height: 400

            FolderListModel {
                folder: moviesDir
                id: moviesFolderModel
                nameFilters: ["*.mp4", "*.mkv", "*.wmv"]
            }

            Component {
                id: movieDelegate
                Pane {
                    height: 40
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: FluidControls.Units.gu(1)
                    }

                    Material.elevation: 1
                    Label {
                        anchors {
                            left: parent.left
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                            margins: 10
                        }
                        text: fileName
                        MouseArea {
                            anchors.fill: parent
                            onClicked: player.mrl = fileURL
                        }
                    }
                }
            }

            model: moviesFolderModel
            delegate: movieDelegate
        }
    }


    //I couldn't figure out what this is supposed to be. Is it just a placeholder or is there a plan for it? -CN
    FluidControls.Tab {
        title: "Projects"

        Rectangle { color: Material.color(Material.Purple, Material.Shade200) }
    }
}
