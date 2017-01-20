import QtQuick 2.5
import QtMultimedia 5.0

Item {
    signal fileSelected()
    onFileSelected: video.source = filedialog.fileUrl

    Video {
        source: video
        anchors.fill: parent
    }
}
