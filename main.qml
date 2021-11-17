import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.3
import Qt.labs.platform 1.1

import MouseEventHandler 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    minimumWidth: rowLayout.width;
    minimumHeight: rowLayout.height + captureBox.height * ( captureBox.count - 1.5 );
    maximumWidth: Math.min( Screen.desktopAvailableWidth,  snippedImage.implicitWidth + marginSize * 2 ); // 2 - both margin sides
    maximumHeight: Math.min( Screen.desktopAvailableHeight, rowLayout.height + snippedImage.implicitHeight + marginSize * 2 ); // 2 - both margin sides
    width: maximumWidth
    height: maximumHeight

    property int marginSize: vbar.width // == hbar.height

    MouseArea
    {
        anchors.fill: parent
        Connections { target: MouseEventHandler }
    }

    Timer {
        id: timer
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime
        timer.repeat = false
        timer.triggered.disconnect(cb)
        timer.triggered.connect(cb)
        timer.start()
    }

    header: Rectangle
    {
        height: rowLayout.height;
        color: "light gray";

        RowLayout {
            id: rowLayout;
            spacing: marginSize;

            Button {
                id: createBtn;
                text: "Create";
                Material.background: "white";
                Layout.leftMargin: spacing * 2;
                icon.source: "qrc:/Sources/scissors.svg";

                property var startFunction: function() {
                    if(captureBox.currentIndex === 2)
                    {
                        snippedImage.enabled = true;
                        mainWindow.show();
                    }
                    else
                    {
                        screenshotWindowLoader.active = true;
                    }
                }

                onClicked: {
                    snippedImage.clearImage();
                    mainWindow.hide();

                    delay(150 + delayBox.sleepValue, startFunction );
                }
            }

            ComboBox {
                id: captureBox;
                onCurrentIndexChanged: CaptureMode.changeMode(currentIndex);
                model: ListModel {
                    ListElement { text: "Rectangle"  }
                    ListElement { text: "Free Form"  }
                    ListElement { text: "Fullscreen" }
                }
            }

            ComboBox {
                id: delayBox;
                Layout.rightMargin: separator.visible ? 0 : rowLayout.spacing;
                displayText: "Delay: " + currentIndex;
                model: [ 0, 1, 2, 3, 4, 5 ];

                property int sleepValue: 1000 * delayBox.currentValue;
            }

            ToolSeparator { id: separator; visible: snippedImage.enabled; }

            Button {
                id: saveBtn;
                visible: snippedImage.enabled;
                Material.background: "white";
                onClicked: fileDialog.open();
                icon.source: "qrc:/Sources/save.svg";
                ToolTip.visible: hovered;
                ToolTip.text: qsTr("Save screenshot( Ctrl+S )" );
            }

            Button {
                id: clipboardBtn;
                visible: snippedImage.enabled;
                Material.background: "white";
                onClicked: FileOperations.copyToClipboard();
                icon.source: "qrc:/Sources/clipboard.svg";
                ToolTip.visible: hovered;
                ToolTip.text: qsTr("Copy to clipboard( Ctrl+C )" );
            }

            Button {
                id: clearBtn;
                visible: snippedImage.enabled;
                Material.background: "white";
                onClicked: snippedImage.clearImage();
                icon.source: "qrc:/Sources/reset.svg";
                ToolTip.visible: hovered;
                ToolTip.text: qsTr("Remove screenshot( Del, Ctrl+D )" );
                Layout.rightMargin: rowLayout.spacing;
            }
        }
    }

    Rectangle {
        id: frame;
        clip: true;
        anchors.fill: parent;
        anchors.margins: marginSize;

        Image {
            id : snippedImage
            enabled: false;
            x: -hbar.position * width;
            y: -vbar.position * height;
            source: enabled ? "image://ImageProvider/snipped" : "";
            onEnabledChanged: resetScrollbar();

            function clearImage() {
                ImageProvider.clear();
                snippedImage.enabled = false;
            }
        }
    }

    ScrollBar {
        id: vbar;
        orientation: Qt.Vertical;
        size: frame.height / snippedImage.implicitHeight;
        visible: frame.height < snippedImage.implicitHeight;

        anchors.top: parent.top;
        anchors.topMargin: marginSize;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: marginSize;
        anchors.right: parent.right;
    }

    ScrollBar {
        id: hbar
        orientation: Qt.Horizontal;
        size: frame.width / snippedImage.implicitWidth;
        visible: frame.width < snippedImage.implicitWidth;

        anchors.left: parent.left;
        anchors.leftMargin: marginSize;
        anchors.right: parent.right;
        anchors.rightMargin: marginSize;
        anchors.bottom: parent.bottom;
    }

    function resetScrollbar() { hbar.position = vbar.position = 0; }

    Loader {
        id: screenshotWindowLoader;
        active: false;
        source: "ScreenshotWindow.qml";
    }

    FileDialog
    {
        id: fileDialog;
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation);
        fileMode: FileDialog.SaveFile;
        nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp)","*.png", "*.jpg (*.jpg *.jpeg)", "*.bmp" ];
        onAccepted: FileOperations.saveFile( currentFile.toString().replace(/^(file:\/{2})/,"") );
    }

    Sequences {}
}
