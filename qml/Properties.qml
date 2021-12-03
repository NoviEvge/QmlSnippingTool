pragma Singleton

import QtQuick
import Qt.labs.settings
import Qt.labs.platform

import QtQuick.Controls.Material

Item {
    signal propertiesUpdated;

    Settings {
        id: settings;
        property int delay: 0;
        property bool autoCopyToClipboard: true;
        property bool autoSaveToFolder: false;
        property url saveFolderPath: StandardPaths.writableLocation( StandardPaths.DocumentsLocation );
        property string fileType: ".png";
    }

    function setDelay( value ) {
        settings.delay = value;
    }

    function getDelay() {
        return settings.delay;
    }

    function setAutoCopyToClipboard( value ) {
        settings.autoCopyToClipboard = value;
    }

    function getAutoCopyToClipboard() {
        return settings.autoCopyToClipboard;
    }

    function setAutoSaveToFolder( value ) {
        settings.autoSaveToFolder = value;
    }

    function getAutoSaveToFolder() {
        return settings.autoSaveToFolder;
    }

    function setSaveFolderPath( value ) {
        settings.saveFolderPath = value;
    }

    function getSaveFolderPath() {
        return settings.saveFolderPath;
    }

    function setFileType( value ) {
        settings.fileType = value;
    }

    function getFileType() {
        return settings.fileType;
    }

    function processActions() {
        if( getAutoSaveToFolder() )
            FileOperations.copyToClipboard();

        if( getAutoSaveToFolder() )
        {
            var folderPath = getSaveFolderPath().toString().replace(/^(file:\/{2})/,"") + "/";
            var fileName = "Caption_" + Qt.formatDateTime( new Date(), "ddMMyy_hhmmss");
            FileOperations.saveFile( folderPath + fileName + getFileType() );
        }
    }
}
