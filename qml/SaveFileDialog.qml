import QtQuick.Dialogs
import Qt.labs.platform

FileDialog {
    folder: StandardPaths.writableLocation( StandardPaths.DocumentsLocation );
    fileMode: FileDialog.SaveFile;
    selectedNameFilter.index: 0;
    nameFilters: [ "*.png", "*.jpg", "*.jpeg", "*.bmp" ];
    onAccepted: {
            var fileName = currentFile.toString();
            if( fileName.lastIndexOf(".") === -1 )
                fileName += selectedNameFilter.name.substring( 1, selectedNameFilter.name.length );

            FileOperations.saveFile( support.getCorrectFolderPath( fileName ) );
    }

    Support {
        id: support;
    }
}
