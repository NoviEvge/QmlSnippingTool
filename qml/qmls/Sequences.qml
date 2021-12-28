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
        onActivated: mainWindow.resetState();
    }

    Shortcut {
        sequences: [ StandardKey.Print ];
        onActivated: support.createWindow( "qrc:/qmls/PreferencesWindow.qml" ).show();
    }

    Shortcut {
        sequence: "Ctrl+Z";
        onActivated: ActionManager.undoLastAction();
    }

    Shortcut {
        sequence: "Ctrl+Y";
        onActivated: ActionManager.redoLastAction();
    }

    SaveFileDialog {
        id: fileDialog;
    }
}
