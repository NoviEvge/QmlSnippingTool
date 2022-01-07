import QtQuick.Dialogs
import Qt.labs.platform

FileDialog {
    folder: support.getWritablePath( StandardPaths.DocumentsLocation );
    fileMode: FileDialog.SaveFile;
    nameFilters: [ "*.png", "*.jpg", "*.jpeg", "*.bmp" ];
    selectedNameFilter.index: 0;

    onAccepted: {
        var fileName = currentFile.toString();
        if( fileName.lastIndexOf(".") === -1 )
            fileName += selectedNameFilter.name.substring( 1, selectedNameFilter.name.length );

        support.saveFile( support.getCorrectFolderPath( fileName ) );
    }

    Support {
        id: support;
    }
}
