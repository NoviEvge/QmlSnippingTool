import QtQuick 2.15

Window
{
    id: transparentWindow
    visible: true
    visibility: "FullScreen"

    onClosing: {
        screenshotWindowLoader.active = false;
        mainWindow.show();
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton;
        onReleased: {
            snippedImage.enabled = true;
            transparentWindow.close();
        }
    }

    Image {
        id: screenshotImage
        anchors.fill: parent
        source: "image://ImageProvider/screenshot";
    }

    Connections {
        target: ImageProvider

        function onSignalNewFrameReady() {
            screenshotImage.source = "";
            screenshotImage.source = "image://ImageProvider/";
        }

        function onForceFinish() { clearAndFinish(); }
    }

    Item {
        focus: true
        Keys.onPressed: clearAndFinish();
    }

    function clearAndFinish() {
        snippedImage.clearImage();
        transparentWindow.close();
    }
}
