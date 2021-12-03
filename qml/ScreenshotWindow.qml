import QtQuick

Window {
    id: transparentWindow

    onClosing: {
        mainWindow.show();

        destroy();
    }

    Image {
        id: screenshotImage
        anchors.fill: parent
        source: "image://ImageProvider/screenshot";
    }

    Connections {
        target: ImageProvider

        function onNewFrameReady() {
            screenshotImage.source = "";
            screenshotImage.source = "image://ImageProvider/";
        }

        function onForceFinish() {
            clearAndFinish();
        }

        function onFinished() {
            snippedImage.enabled = true;
            transparentWindow.close();
        }
    }

    Item {
        focus: true;
        Keys.onPressed: clearAndFinish();
    }

    function clearAndFinish() {
        snippedImage.clearImage();
        transparentWindow.close();
    }
}
