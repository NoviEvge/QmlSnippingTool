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
        onActivated: support.copyImageToClipboard();
    }

    Shortcut {
        sequences: [ StandardKey.Delete ];
        onActivated: snippedImage.clearImage();
    }

    Shortcut {
        sequences: [ StandardKey.Print ];
        onActivated: support.createWindow( "qrc:/qmls/PreferencesWindow.qml" ).show();
    }

    Shortcut {
        enabled: ActionManager.isUndoActions();
        sequence: "Ctrl+Z";
        onActivated: ActionManager.undoLastAction();
    }

    Shortcut {
       enabled: ActionManager.isRedoActions();
        sequence: "Ctrl+Y, Ctrl+Shit+Z";
        onActivated: ActionManager.redoLastAction();
    }

    SaveFileDialog {
        id: fileDialog;
    }
}
