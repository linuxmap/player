import QtQuick.Layouts 1.0
import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0
import Fluid.Controls 1.0 as FluidControls

FluidControls.FluidWindow {
    id: root
    width: 750
    height: 430

    property QtObject app

    property var player: playerRoot.player

    property var cliFile
    property bool fullscreen: visibility == 5
    property bool forceBars: player.state != "3"
    property bool noMedia: player.state == "0" || player.state == "5"

    property var currentMedia

    property ListModel currentPlaylistModel: ListModel {
        id: currentPlaylistModel
    }

    property bool isAudio

    Material.primary: Material.Red
    Material.accent: Material.DeepOrange

    visible: true
    property Settings settings: Settings {
        id: settings
        property alias x: root.x
        property alias y: root.y
        property color accentColor
        property color primaryColor
        property var recents
        /*property alias width: root.width
        property alias height: root.height*/
    }

    initialPage: Page {
        // FIXME: backgroundColor doesn't exist
        //backgroundColor: noMedia ? Material.color(Material.Grey, Material.Shade100) : "black"
        // FIXME: actionBar doesn't exist
        //actionBar.hidden: true

        PlayerRoot { id: playerRoot}

        Shortcuts {}

    }


    property Page libraryPage: LibraryPage {}

    Component.onCompleted: {
        settings.accentColor = Qt.binding(function() { return Material.accentColor; });
        settings.primaryColor = Qt.binding(function() { return Material.primaryColor; });
    }
}
