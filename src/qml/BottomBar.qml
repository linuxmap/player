import QtQuick.Layouts 1.0
import QtQuick 2.5
import QtQuick.Controls 2.0
import Fluid.Controls 1.0 as FluidControls

Rectangle {
    id: bottomBar
    opacity: 1
    anchors {
        bottom: parent.bottom
        right: parent.right
        left: parent.left
    }
    height: 88
    gradient: Gradient {
        GradientStop { position: 0.0; color: "transparent" }
        GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.6) }
    }
    Behavior on opacity {
        NumberAnimation { duration: 500 }
    }

    function n(n){
        return n > 9 ? "" + n: "0" + n;
    }

    function getTime (ms,h) {
        ms = ms/1000 + ""
        var sec_num = parseInt(ms, 10);
        var hours   = Math.floor(sec_num / 3600);
        var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
        var seconds = sec_num - (hours * 3600) - (minutes * 60);
        if (hours   < 10) {hours   = "0"+hours;}
        if (minutes < 10) {minutes = "0"+minutes;}
        if (seconds < 10) {seconds = "0"+seconds;}
        var time = h ? hours+':'+minutes+':'+seconds : minutes+':'+seconds
        return time;
    }
    Column {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 15
        }
        spacing: -2

        Slider {
            value: player.position
            visible: player.state != "0"
            width: (bottomBar.width - parent.anchors.leftMargin - parent.anchors.rightMargin)
            onPressedChanged: player.time = value * player.length
        }

        Row {
            spacing: 10
            FluidControls.IconButton {
                id: prevButton
                iconName: "av/skip_previous"
                iconColor: "white"
                iconSize: 30
                MouseArea {
                    anchors.fill: parent
                    onClicked: player.playlist.prev()
                }
            }
            FluidControls.IconButton {
                id: playButton
                iconName: "av/play_arrow"
                iconColor: "white"
                iconSize: 30
                /*MouseArea {
                    anchors.fill: parent
                    onPressAndHold: player.stop()
                }*/
            }
            FluidControls.IconButton {
                id: nextButton
                iconName: "av/skip_next"
                iconColor: "white"
                iconSize: 30
                MouseArea {
                    anchors.fill: parent
                    onClicked: player.playlist.next()
                }
            }
            Rectangle {
                height: playButton.height
                color: "transparent"
                width: (bottomBar.width - bottomBar.anchors.leftMargin - bottomBar.anchors.rightMargin) - playButton.width - rightButtons.width - rightButtons.spacing - 20 - 60
                Label {
                    id: time
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    color: "white"
                    property bool h: ~~(player.time/1000/3600) == 0
                    text: getTime(player.time,h) + " / " + getTime(player.length,h)
                }
            }
            Row {
                id: rightButtons
                width: cropButton.size * 5 + 50 + 100
                spacing: 10
                FluidControls.IconButton {
                    id: volumeButton
                    iconName: mute ? "av/volume_mute" : "av/volume_up"
                    iconColor: "white"
                    iconSize: 30
                    property bool mute: player.volume == 0
                    onClicked: {
                        if(mute)
                            player.volume = 100
                        else
                            player.volume = 0
                    }
                }
                Slider {
                    value: player.volume
                    width: 100
                    from: 0
                    to: 100
                    onPressedChanged: {
                        if(pressed)
                            player.volume = Math.floor(value)
                    }
                }

                FluidControls.IconButton {
                    id: playlistButton
                    iconName: "av/queue_music"
                    iconColor: "white"
                    iconSize: 30
                    onClicked: {
                        playlistDrawer.open()
                    }
                }
                FluidControls.IconButton {
                    id: cropButton
                    iconName: "image/crop_16_9"
                    iconColor: "white"
                    iconSize: 30
                    onClicked: {
                        if(player.state == "3")
                            root.height = Math.round((player.video.height / player.video.width) * (root.width + 16))
                    }
                }
                FluidControls.IconButton {
                    id: fsButton
                    iconName: root.fullscreen ? "navigation/fullscreen_exit" : "navigation/fullscreen"
                    iconColor: "white"
                    iconSize: 30
                    onClicked: if(root.fullscreen) showNormal(); else showFullScreen();
                }
            }
        }
    }
    Item{
        state: player.state
        states: [
            State {
                name: "0"
                PropertyChanges { target: playButton; iconName: "file/folder_open"; onClicked: filedialog.visible = true; }
                PropertyChanges { target: time; text:  "Open a file" }
            },
            State {
                name: "1"
                PropertyChanges { target: playButton; iconName: "notification/sync"; onClicked: filedialog.visible = true }
                PropertyChanges { target: time; text:  "Opening..." }
            },
            State {
                name: "2"
                PropertyChanges { target: playButton; iconName: "notification/sync"; onClicked: filedialog.visible = true }
                PropertyChanges { target: time; text:  "Buffering..." }
            },
            State {
                name: "3"
                PropertyChanges { target: playButton; iconName: "av/pause"; onClicked: player.pause() }
                PropertyChanges { target: time; text:  getTime(player.time) + " / " + getTime(player.length) }
            },
            State {
                name: "4"
                PropertyChanges { target: playButton; iconName: "av/play_arrow"; onClicked: player.play() }
                PropertyChanges { target: time; text:  getTime(player.time) + " / " + getTime(player.length) }
            },
            State {
                name: "5"
                PropertyChanges { target: playButton; iconName: "file/folder_open"; onClicked: filedialog.visible = true }
                PropertyChanges { target: time; text:  "Open a file" }
            },
            State {
                name: "6"
                PropertyChanges { target: playButton; iconName: "av/replay"; onClicked: player.play(filedialog.fileUrl) }
                PropertyChanges { target: time; text:  "Replay..." }
            },
            State {
                name: "7"
                PropertyChanges { target: playButton; iconName: "alert/error"; onClicked: player.play(filedialog.fileUrl) }
                PropertyChanges { target: time; text:  "Error" }
            }
        ]
    }
}
