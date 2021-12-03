import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

import MouseEventHandler
import Properties

ApplicationWindow {
    id: mainWindow
    visible: true
    minimumWidth: rowLayout.width;
    minimumHeight: rowLayout.height + captureBox.height * ( captureBox.count - 0.5 );
    maximumWidth: Math.min( Screen.desktopAvailableWidth,  snippedImage.implicitWidth + marginSize * 2 ); // 2 - both margin sides
    maximumHeight: Math.min( Screen.desktopAvailableHeight, rowLayout.height + snippedImage.implicitHeight + marginSize * 2 ); // 2 - both margin sides
    width: maximumWidth;
    height: maximumHeight;

    property int marginSize: vbar.width; // == hbar.height

    MouseArea {
        anchors.fill: parent;
        Connections { target: MouseEventHandler }
    }

    header: Rectangle {
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
                icon.source: "qrc:/resources/scissors.svg";

                property var startFunction: function() {
                    var fullScreenModeIndex = 2;
                    if(captureBox.currentIndex === fullScreenModeIndex) {
                        snippedImage.enabled = true;
                        mainWindow.show();
                    }
                    else {
                        support.createWindow("qrc:/qml/ScreenshotWindow.qml").showFullScreen();
                    }
                }

                onClicked: {
                    snippedImage.clearImage();
                    mainWindow.hide();
                    support.delay( 150 + delayBox.sleepValue, startFunction);
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

            DelayBox {
                id: delayBox;

                Connections {
                    target: Properties
                    function onPropertiesUpdated() {
                        delayBox.currentIndex = Properties.getDelay();
                    }
                }

                property int sleepValue: 1000 * delayBox.currentValue;
            }

            ToolSeparator {
                Layout.rightMargin: -marginSize / 2;
                Layout.leftMargin: -marginSize / 2;
            }

            ActionButtons {
                Layout.rightMargin: marginSize;
            }
        }
    }

    Rectangle {
        id: frame;
        clip: true;
        anchors.fill: parent;
        anchors.margins: marginSize;

        Image {
            id : snippedImage;
            enabled: false;
            cache: false;
            x: -hbar.position * width;
            y: -vbar.position * height ;
            source: enabled ? "image://ImageProvider/snipped" : "";
            onEnabledChanged: {
                hbar.position = vbar.position = 0; // reset scrollbars
                Properties.processActions();
            }

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

        anchors{
            top: parent.top;
            topMargin: marginSize;
            bottom: parent.bottom;
            bottomMargin: marginSize;
            right: parent.right;
        }
    }

    ScrollBar {
        id: hbar
        orientation: Qt.Horizontal;
        size: frame.width / snippedImage.implicitWidth;
        visible: frame.width < snippedImage.implicitWidth;

        anchors {
            left: parent.left;
            leftMargin: marginSize;
            right: parent.right;
            rightMargin: marginSize;
            bottom: parent.bottom;
        }
    }

    Support {
        id: support;
    }

    Sequences {}
}
