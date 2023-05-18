import QtQuick 2.12

Item {
    id: root
    property alias posterSource: imagePoster.source
    property string emptyBorderBackground: "transparent"

    Image {
        id: imagePoster
        sourceSize: Qt.size(350, 500)
        fillMode: Image.PreserveAspectCrop
        anchors.centerIn: parent
        width: parent.width - 4
        height: parent.height - 4
        clip: true

        Rectangle {
            anchors.fill: parent
            color: applicationThemeViewModel.currentItems.colorPosterFilter
        }
    }

    Rectangle {
        anchors.fill: parent
        border.color: applicationThemeViewModel.posterBorder
        border.width: 2
        color: "transparent"
        radius: 4
        clip: true
    }
}

