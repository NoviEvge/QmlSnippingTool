import QtQuick 2.15

Item
{
    Shortcut {
        sequences: [StandardKey.New];
        onActivated: createBtn.clicked();
    }

    Shortcut {
        sequences: [StandardKey.Save];
        onActivated: fileDialog.open();
    }

    Shortcut {
        sequence: "Ctrl+C";
        onActivated: FileOperations.copyToClipboard();
    }

    Shortcut {
        sequences: [StandardKey.Delete];
        onActivated: snippedImage.clearImage();
    }
}
