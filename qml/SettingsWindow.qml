import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.platform
import QtQuick.Controls.Material

import Properties

Window {

    width:  layout.implicitWidth + spacingAroundLayout;
    height: layout.implicitHeight + spacingAroundLayout;
    minimumWidth : width;
    minimumHeight: height;
    maximumWidth:  width;
    maximumHeight: height;

    property int spacingAroundLayout: 50;

    //Component.onCompleted: mainWindow. = false;

    onClosing: {
        Properties.setDelay( defaultDelay.currentIndex );
        Properties.setAutoCopyToClipboard( copyToClipboard.checked );
        Properties.setAutoSaveToFolder( autoSaveToFolder.checked );
        Properties.setSaveFolderPath( folderDialog.folder );
        Properties.setFileType( fileType.currentValue );
        Properties.propertiesUpdated();
       // mainWindow.active = true;

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
                    ToolTip.text: folderDialog.getFolderPath();
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
            displayText: "File type: " + currentValue;
            model: [ ".png", ".jpg", ".jpeg", ".bmp" ];
        }
    }

    FolderDialog {
        id: folderDialog;
        acceptLabel: "Select";
        folder: Properties.getSaveFolderPath();

        function getFolderPath() {
            return folderDialog.folder.toString().replace(/^(file:\/{2})/,"")
        }

        function setFolderPath( path ) {
            folderDialog.folder = "file://" + path;
        }
    }
}
