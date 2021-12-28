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

    onClosing: destroy();

    ColumnLayout {
        id: layout;
        anchors.centerIn: parent;

        Label {
            Layout.alignment: Qt.AlignHCenter;
            text: "General";
            font.pixelSize: Constants.fontPixelSize;
            font.bold: true;
        }

        DelayBox {
            flat: false;
            Layout.fillWidth: true;
            currentIndex: Preferences.getDelay();
            onCurrentIndexChanged: Preferences.setDelay( currentIndex );
        }

        CheckBox {
            text: "Always copy to clipboard";
            checked: Preferences.getAutoCopyToClipboard();
            onCheckedChanged: Preferences.setAutoCopyToClipboard( checked );
        }

        CheckBox {
            id: autoSaveToFolder
            text: "Auto save to folder";
            checked: Preferences.getAutoSaveToFolder();
            onCheckedChanged: Preferences.setAutoSaveToFolder( checked )
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

                    Layout.fillWidth: true;

                    ToolTip.visible: hovered;
                    ToolTip.text: folderDialog.getFolderPath() ? folderDialog.getFolderPath() : "Empty ( Documents folder by default )";
                    ToolTip.delay: Constants.tooltipDelay;

                    onTextEdited: folderDialog.setFolderPath( text );
                    onTextChanged: setCursorToStart();
                    onFocusChanged: {
                        if( !focus )
                            setCursorToStart();
                    }

                    function setCursorToStart() {
                        cursorPosition = 0;
                        Preferences.setSaveFolderPath( folderDialog.getFolderUrl() );
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

            onCurrentValueChanged: {
                Preferences.setFileTypeIndex( currentIndex );
                Preferences.setFileType( model[currentIndex] );
            }
        }

        Label {
            Layout.alignment: Qt.AlignHCenter;
            Layout.topMargin: 10;

            text: "Drawings"
            font.pixelSize: Constants.fontPixelSize;
            font.bold: true;
        }

        GridLayout {
            columns: 3
            rows: 3;

            Label {
                text: "Pen: ";
            }

            ExtendedRoundButton {
                id: penColorControl;

                Layout.bottomMargin: -10;

                implicitWidth:  30;
                implicitHeight: 30;

                onClicked: penPalettePopup.open();

                Popup {
                    id: penPalettePopup;

                    y: -height + parent.height / 2 ;
                    x: parent.width / 2;

                    ColorPalette {
                        Component.onCompleted: updateCurrentColor( Preferences.getPenColor() );

                        onColorChanged: ( color ) => {
                                            penColorControl.color = color;
                                            Preferences.setPenColor( color );
                                        }
                    }
                }
            }

            WidthSlider{
                Component.onCompleted: updateCurrentWidth( Preferences.getPenWidth() );

                onWidthChanged: ( width ) => Preferences.setPenWidth( width );
            }

            Label {
                text: "Highlighter: ";
            }

            ExtendedRoundButton {
                enabled: false;
                hoverEnabled: false;

                implicitWidth:  30;
                implicitHeight: 30;

                color: Preferences.getHighlighterColor();
                Layout.bottomMargin: -10;
            }

            WidthSlider {
                Component.onCompleted: updateCurrentWidth( Preferences.getHighlighterWidth() );

                onWidthChanged: ( width ) => Preferences.setHighlighterWidth( width );
            }

            Label {
                text: "Selection rect: ";
            }

            ExtendedRoundButton {
                id: selectionAreaColorControl;

                implicitWidth:  30;
                implicitHeight: 30;

                onClicked: selectionAreaPalettePopup.open();

                Popup
                {
                    id: selectionAreaPalettePopup;

                    y: -height + parent.height / 2 ;
                    x: parent.width / 2;

                    ColorPalette {
                        Component.onCompleted: updateCurrentColor( Preferences.getSelectionAreaColor() );

                        onColorChanged: ( color ) => {
                                            selectionAreaColorControl.color = color;
                                            Preferences.setSelectionAreaColor( color );
                                        }
                    }
                }
            }

            WidthSlider {
                from: 1;
                to: 20;

                Component.onCompleted: updateCurrentWidth( Preferences.getSelectionAreaWidth() );

                onWidthChanged: ( width ) => Preferences.setSelectionAreaWidth( width );
            }
        }
    }

    FolderDialog {
        id: folderDialog;
        acceptLabel: "Select";
        folder: Preferences.getSaveFolderPath();

        function getFolderUrl() {
            return getFolderPath() ? folder : Preferences.getDefaultSaveFolderPath();
        }

        function getFolderPath() {
            return support.getCorrectFolderPath( folderDialog.folder.toString() );
        }

        function setFolderPath( path ) {
            folderDialog.folder = "file://" + ( support.isWindowsOS() ? "/" : "" ) + path;
        }
    }

    Support {
        id: support;
    }
}
