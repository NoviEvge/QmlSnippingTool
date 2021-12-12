import QtQuick

Item {
    Shortcut {
        sequences: [ StandardKey.New ];
        onActivated: createBtn.clicked();
    }

    Shortcut {
        sequences: [ StandardKey.Save ];
        onActivated: fileDialog.open();
    }

    Shortcut {
        sequence: "Ctrl+C";
        onActivated: FileOperations.copyToClipboard();
    }

    Shortcut {
        sequences: [ StandardKey.Delete ];
        onActivated: snippedImage.clearImage();
    }

    Shortcut {
        sequences: [ StandardKey.Print ];
        onActivated: support.createWindow( "qrc:/qml/SettingsWindow.qml" ).show();
    }

    SaveFileDialog {
        id: fileDialog;
    }
}
