import QtQuick.Layouts 1.0
import Material 0.2
import Material.ListItems 0.1 as ListItem
import QtQuick 2.5
import QtMultimedia 5.0

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
        Label {
            id: txtTitle
            width: parent.width
            wrapMode: Text.WordWrap
            style: "display1"
            text: currentMedia.title
            color: "white"
        }
        Label {
            style: "headline"
            width: parent.width
            wrapMode: Text.WordWrap
            text: currentMedia.artist
            color: "white"
            opacity: 0.8
        }
        Label {
            style: "headline"
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
