import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.platform
import QtQuick.Controls.Material

ApplicationWindow {

    width:  Math.max( basePreferencesLayout.implicitWidth,  drawingPreferencesLayout.implicitWidth  );
    height: Math.max( basePreferencesLayout.implicitHeight, drawingPreferencesLayout.implicitHeight ) + toolBar.height;
    minimumWidth : width;
    minimumHeight: height;
    maximumWidth:  width;
    maximumHeight: height;
    modality: Qt.WindowModal

    onClosing: {
        Preferences.setDelay( defaultDelay.currentIndex );
        Preferences.setAutoCopyToClipboard( copyToClipboard.checked );
        Preferences.setAutoSaveToFolder( autoSaveToFolder.checked );
        Preferences.setSaveFolderPath( folderDialog.getFolderUrl() );
        Preferences.setFileTypeIndex( fileType.currentIndex );
        Preferences.setFileType( fileType.currentValue );

        destroy();
    }

    header: TabBar {
        id: toolBar;

        background: Rectangle {
            color: "#CFD8DC";
        }

        TabButton {
            text: "General";
        }

        TabButton {
            text: "Drawings";
        }
    }

    SwipeView
    {
        anchors.fill: parent;
        currentIndex: toolBar.currentIndex;

        ColumnLayout {
            id: basePreferencesLayout;
            spacing: 10;

            DelayBox {
                id: defaultDelay;
                currentIndex: Preferences.getDelay();
                Layout.fillWidth: true;
            }

            CheckBox {
                id: copyToClipboard;
                checked: Preferences.getAutoCopyToClipboard();
                text: "Always copy to clipboard";
            }

            CheckBox {
                id: autoSaveToFolder
                checked: Preferences.getAutoSaveToFolder();
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
                        ToolTip.delay: Constants.tooltipDelay;
                        onTextEdited: folderDialog.setFolderPath( text );
                        onTextChanged: setCursorToStart();
                        onFocusChanged: setCursorToStart();

                        function setCursorToStart() {
                            if( !focus )
                                cursorPosition = 0;
                        }
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
                currentIndex: Preferences.getFileTypeIndex();
                displayText: "File type: " + currentValue;
                model: [ ".png", ".jpg", ".jpeg", ".bmp" ];
            }
        }

        ColumnLayout {
            id: drawingPreferencesLayout;

            ColumnLayout {
                id: drawingsLayout;

                ColumnLayout {
                    spacing: 0;

                    Label {
                        text: "Pen width and color";
                    }

                    RowLayout {
                        SpinBox {
                            editable: true;
                            from: 1;
                            to: 100;
                            value: Preferences.getPenWidth();
                        }
                    }
                }

                ColumnLayout {
                    spacing: 0;

                    Label {
                        text: "Highlighter width and color";
                    }

                    RowLayout {
                        SpinBox {
                            editable: true;
                            from: 1;
                            to: 100;
                            value: Preferences.getHighlighterWidth();
                        }
                    }
                }
                ColumnLayout {
                    spacing: 0;

                    Label { text: "Selection area color"; }

                    RowLayout {

                    }
                }
            }
        }
    }

    FolderDialog {
        id: folderDialog;
        acceptLabel: "Select";
        folder: Preferences.getSaveFolderPath();

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
