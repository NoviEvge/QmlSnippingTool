pragma Singleton

import QtQuick
import Qt.labs.settings
import Qt.labs.platform

Item {

    // General
    Settings {
        id: generalSettings;
        property int delay: 0;
        property bool autoCopyToClipboard: true;
        property bool autoSaveToFolder: false;
        property url saveFolderPath: getDefaultSaveFolderPath();
        property int fileTypeIndex: 0;
        property string fileType: "*.png";
    }

    function setDelay( value ) {
        generalSettings.delay = value;
    }

    function getDelay() {
        return generalSettings.delay;
    }

    function setAutoCopyToClipboard( value ) {
        generalSettings.autoCopyToClipboard = value;
    }

    function getAutoCopyToClipboard() {
        return generalSettings.autoCopyToClipboard;
    }

    function setAutoSaveToFolder( value ) {
        generalSettings.autoSaveToFolder = value;
    }

    function getAutoSaveToFolder() {
        return generalSettings.autoSaveToFolder;
    }

    function setSaveFolderPath( value ) {
        generalSettings.saveFolderPath = value;
    }

    function getSaveFolderPath() {
        return generalSettings.saveFolderPath;
    }

    function getDefaultSaveFolderPath() {
        return StandardPaths.writableLocation( StandardPaths.DocumentsLocation )
    }

    function setFileTypeIndex( value ) {
        generalSettings.fileTypeIndex = value;
    }

    function getFileTypeIndex() {
        return generalSettings.fileTypeIndex;
    }

    function setFileType( value ) {
        generalSettings.fileType = value;
    }

    function getFileType() {
        return generalSettings.fileType;
    }

    function processActions() {
        if( getAutoCopyToClipboard() )
            support.copyImageToClipboard();

        if( getAutoSaveToFolder() )
        {
            var folderPath = support.getCorrectFolderPath( getSaveFolderPath().toString() ) + "/";
            var fileName = "Caption_" + Qt.formatDateTime( new Date(), "ddMMyy_hhmmss" );

            support.saveFile( folderPath + fileName + getFileType() );
        }
    }

    // Drawings
    Settings {
        id: drawingSettings;

        property color penColor: "red";
        property int penWidth: 5;

        property color highlighterColor: "yellow";
        property int highlighterWidth: 5;

        property color snippingColor: "red";
        property int snippingWidth: 1;
    }

    function setPenColor( value ) {
        drawingSettings.penColor = value;
    }

    function getPenColor() {
        return drawingSettings.penColor;
    }

    function setPenWidth( value ) {
        drawingSettings.penWidth = value;
    }

    function getPenWidth() {
        return drawingSettings.penWidth;
    }

    function getHighlighterColor() {
        return drawingSettings.highlighterColor;
    }

    function setHighlighterWidth( value ) {
        drawingSettings.highlighterWidth = value;
    }

    function getHighlighterWidth() {
        return drawingSettings.highlighterWidth;
    }

    function setSelectionAreaColor( value ) {
        drawingSettings.snippingColor = value;
    }

    function getSelectionAreaColor() {
        return drawingSettings.snippingColor;
    }

    function setSelectionAreaWidth( value ) {
        drawingSettings.snippingWidth = value;
    }

    function getSelectionAreaWidth() {
        return drawingSettings.snippingWidth;
    }

    Support {
        id: support;
    }
}
