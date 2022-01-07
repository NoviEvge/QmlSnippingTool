import QtQuick
import qt.ImageProviderEnum

Window {
    id: transparentWindow

    onClosing: {
        SnippingAreaManager.reset();
        mainWindow.show();
        destroy();
    }

    ExtendedImage {
        source: "image://ImageProvider/screenshot";

        sendMouseEventSignalCaller: SnippingAreaManager;
        onPressCreationColorFunc: function() { return Preferences.getSelectionAreaColor(); }
        onPressCreationWidthFunc: function() { return Preferences.getSelectionAreaWidth(); }
        onPressCreationType: captureBox.currentIndex + 1;

        mouseAreaCursor: Qt.CrossCursor;

        onFinishedCallback: function( status ) {
            if ( ImageProviderEnum.ForcedExit === status ) {
                clearAndFinish();
            }
            else {
                snippedImage.enabled = true;
                transparentWindow.close();
            }
        }
    }

    Item {
        focus: true;
        Keys.onPressed: clearAndFinish();
    }

    function clearAndFinish() {
        mainWindow.resetState();
        transparentWindow.close();
    }

    Support {
        id: support;
    }
}
