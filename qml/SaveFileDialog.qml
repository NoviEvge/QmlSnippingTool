import QtQuick.Dialogs
import Qt.labs.platform

FileDialog {
    folder: StandardPaths.writableLocation( StandardPaths.DocumentsLocation );
    fileMode: FileDialog.SaveFile;
    nameFilters: [ "Image files (*.png *.jpg *.jpeg *.bmp)","*.png", "*.jpg (*.jpg *.jpeg)", "*.bmp" ];
    onAccepted: FileOperations.saveFile( currentFile.toString().replace( /^(file:\/{2})/, "" ) );
}
