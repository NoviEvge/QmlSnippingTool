import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.platform
import QtQuick.Controls.Material

Window {

    width:  layout.implicitWidth  + Constants.bigMarginSize;
    height: layout.implicitHeight + Constants.bigMarginSize;
    minimumWidth : width;
    minimumHeight: height;
    maximumWidth:  width;
    maximumHeight: height;
    modality: Qt.WindowModal

    onClosing: {
        Properties.setDelay( defaultDelay.currentIndex );
        Properties.setAutoCopyToClipboard( copyToClipboard.checked );
        Properties.setAutoSaveToFolder( autoSaveToFolder.checked );
        Properties.setSaveFolderPath( folderDialog.getFolderUrl() );
        Properties.setFileTypeIndex( fileType.currentIndex );
        Properties.setFileType( fileType.currentValue );
        Properties.propertiesUpdated();

        destroy();
    }

    ColumnLayout {
        id: layout;
        anchors.centerIn: parent;

        DelayBox {
            id: defaultDelay;
            Layout.fillWidth: true;
            currentIndex: Properties.getDelay();
        }

        CheckBox {
            id: copyToClipboard;
            checked: Properties.getAutoCopyToClipboard();
            text: "Always copy to clipboard";
        }

        CheckBox {
            id: autoSaveToFolder
            checked: Properties.getAutoSaveToFolder();
            text: "Auto save to folder";
        }

        RowLayout {
            enabled: autoSaveToFolder.checkState;
            spacing: 10;

            ColumnLayout {
                spacing: 0;

                Label {
                    text: "Folder for captures";
                }

                TextField {
                    id: defaultFolderPath;
                    text: folderDialog.getFolderPath();
                    ToolTip.visible: hovered;
                    ToolTip.text: folderDialog.getFolderPath() ? folderDialog.getFolderPath() : "Empty ( Documents folder by default )";
                    onTextEdited: folderDialog.setFolderPath( text );
                }
            }

            Button {
                text: "Browse";
                onClicked: folderDialog.open();
            }
        }

        ComboBox {
            id: fileType;
            enabled: autoSaveToFolder.checkState;
            Layout.fillWidth: true;
            currentIndex: Properties.getFileTypeIndex();
            displayText: "File type: " + currentValue;
            model: [ ".png", ".jpg", ".jpeg", ".bmp" ];
        }
    }

    FolderDialog {
        id: folderDialog;
        acceptLabel: "Select";
        folder: Properties.getSaveFolderPath();

        function getFolderUrl() {
              return getFolderPath() ? folder : Properties.getDefaultSaveFolderPath();
        }

        function getFolderPath() {
            return support.getCorrectFolderPath( folderDialog.folder.toString() );
        }

        function setFolderPath( path ) {
            folderDialog.folder = "file://" + ( Support.isWindowsOS() ? "/" : "" ) + path;
        }
    }

    Support {
        id: support;
    }
}
