import QtQuick 2.5
import Fluid.Controls 1.0 as FluidControls

Rectangle {
    id: noMediaSurface
    visible: root.noMedia
    anchors{
        margins: Units.gu(1)
        topMargin: Units.dp(10) + topBar.height
        fill: parent
    }
    color: "transparent"
    Column {
        spacing: Units.dp(10)
        FluidControls.DisplayLabel {
            text: "Recent"
            level: 2
        }

        ListView {
            width: noMediaSurface.width
            height:noMediaSurface.height - Units.dp(10) - topBar.height
            model: application.recentlyPlayedModel
            delegate: FluidControls.ListItem {
                iconName: type == "audio" ? "av/album" : "av/movie"
                text: name + "   <font color='#757575'>"+ (artist ? "- " + artist : "") + "</font>"
                // FIXME: backgroundColor doesn't exist
                //backgroundColor: "white"
                onClicked: player.mrl = url
            }
        }
    }
}

