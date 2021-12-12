import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

import MouseEventHandler

ApplicationWindow {
    id: mainWindow;
    visible: true;
    maximumWidth:  Screen.desktopAvailableWidth;
    maximumHeight: Screen.desktopAvailableHeight;
    minimumWidth:  rowLayout.implicitWidth;
    minimumHeight: rowLayout.implicitHeight + captureBox.height * ( captureBox.count - 0.5 );
    width:  Math.max( minimumWidth, snippedImage.scaledWidth + 2 * Constants.bigMarginSize + 1 ); // 2 - both borders
    height: Math.max( minimumHeight, rowLayout.implicitHeight + snippedImage.scaledHeight + 2 * Constants.bigMarginSize + 1 ); // 2 - both borders

    onWidthChanged:  x = ( ( x + width  ) < maximumWidth  ) ? maximumWidth  * 0.2 : 0;  // 0.2 = 20%,
    onHeightChanged: y = ( ( y + height ) < maximumHeight ) ? maximumHeight * 0.2 : 30; // 0.2 = 20%, position with "main header"

    MouseArea {
        anchors.fill: parent;
        Connections {
            target: MouseEventHandler;
        }
    }

    header: Rectangle {
        height: rowLayout.height;
        color: "light gray";

        RowLayout {
            id: rowLayout;
            spacing: Constants.marginSize;

            Button {
                id: createBtn;
                text: "Create";
                Material.background: "white";
                Layout.leftMargin: spacing * 2;
                icon.source: "qrc:/qml/images/scissors.svg";

                property var startFunction: function() {
                    var fullScreenModeIndex = 2;
                    if( captureBox.currentIndex === 2 ) {
                        snippedImage.enabled = true;
                        mainWindow.show();
                    }
                    else {
                        support.createWindow( "qrc:/qml/ScreenshotWindow.qml" ).showFullScreen();
                    }
                }

                onClicked: {
                    snippedImage.clearImage();
                    mainWindow.hide();
                    support.delay( 250 + delayBox.sleepValue, startFunction );
                }
            }

            ComboBox {
                id: captureBox;
                onCurrentIndexChanged: CaptureMode.changeMode( currentIndex );
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
                Layout.rightMargin: -Constants.marginSize / 2;
                Layout.leftMargin:  -Constants.marginSize / 2;
            }

            ActionButtons {
                Layout.rightMargin: Constants.marginSize;
            }
        }
    }

    Flickable {
        id: flickable;
        clip: true;
        anchors.fill: parent;
        anchors.margins: Constants.bigMarginSize;
        boundsBehavior: Flickable.StopAtBounds;

        width:  Math.min( snippedImage.scaledWidth,  mainWindow.width );
        height: Math.min( snippedImage.scaledHeight, mainWindow.height );
        contentWidth:  snippedImage.scaledWidth;
        contentHeight: snippedImage.scaledHeight;

        Image {
            id : snippedImage;
            enabled: false;
            cache: false;
            transform: support.getTransformScale();
            source: enabled ? "image://ImageProvider/snipped" : "";

            onEnabledChanged: Properties.processActions();
            onWidthChanged:  scaledWidth  = support.getScaledValue( width );
            onHeightChanged: scaledHeight = support.getScaledValue( height );

            function clearImage() {
               ImageProvider.clear();
               snippedImage.enabled = false;
            }

            property int scaledWidth:  0;
            property int scaledHeight: 0;
        }

        ScrollBar.vertical: ScrollBar {
            visible: flickable.height < snippedImage.scaledHeight;
            anchors {
                top:    flickable.top;
                bottom: flickable.bottom;
                right:  flickable.right;
            }

            contentItem: Rectangle {
                 color: "grey";
            }
        }

        ScrollBar.horizontal: ScrollBar {
            visible: flickable.width < snippedImage.scaledWidth;
            anchors {
                left:   flickable.left;
                right:  flickable.right;
                bottom: flickable.bottom;
            }

            contentItem: Rectangle {
                 color: "grey";
            }
        }
    }

    Support {
        id: support;
    }

    Sequences {}
}
