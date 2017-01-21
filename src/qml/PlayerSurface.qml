import QtQuick.Layouts 1.0
import QtQuick 2.5
import QtQuick.Controls 2.0
import QtMultimedia 5.0
import Fluid.Controls 1.0 as FluidControls

Video {
    source: player
    anchors.fill: parent

    MouseArea {
        anchors.fill: parent
        anchors.topMargin:topBar.height
        anchors.bottomMargin:bottomBar.height
        hoverEnabled: true
        onPositionChanged: restartBarsTimer()
        onClicked: player.togglePause()
        onDoubleClicked: {fullscreen ? showNormal() : showFullScreen(); console.log(player.playlist.itemCount)}
        cursorShape: Qt.BlankCursor;
    }

    Column {
        //anchors.top: parent.top
        visible: isAudio && !root.noMedia
        //anchors.bottom: parent.bottom
        width: root.width - artwork.width - anchors.leftMargin * 3
        anchors.left: parent.left
        anchors.leftMargin: Units.dp(15)
        anchors.topMargin: topBar.height + Units.dp(15)
        anchors.bottomMargin: bottomBar.height + Units.dp(15)
        anchors.verticalCenter: parent.verticalCenter
        FluidControls.DisplayLabel {
            id: txtTitle
            width: parent.width
            wrapMode: Text.WordWrap
            text: currentMedia.title
            color: "white"
        }
        FluidControls.HeadlineLabel {
            width: parent.width
            wrapMode: Text.WordWrap
            text: currentMedia.artist
            color: "white"
            opacity: 0.8
        }
        FluidControls.HeadlineLabel {
            wrapMode: Text.WordWrap
            width: parent.width
            text: currentMedia.album
            color: "white"
            opacity: 0.6
        }
    }

    Image {
        id: artwork
        source: currentMedia.artworkURL
        width: height
        visible: !root.noMedia
        anchors{
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }
    }
}
