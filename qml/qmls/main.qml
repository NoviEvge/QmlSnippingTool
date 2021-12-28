import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import Qt.labs.platform
import qt.SnippingAreaEnum
import qt.ActionTypesEnum

ApplicationWindow {
    id: mainWindow;
    visible: true;

    width:  Math.max( mainWindow.minimumWidth,  snippedImage.scaledWidth + 2 * Constants.bigMarginSize + 1 ); // 2 - both borders
    height: Math.max( mainWindow.minimumHeight, rowLayout.implicitHeight + snippedImage.scaledHeight + 2 * Constants.bigMarginSize + 1 ); // 2 - both borders

    onWidthChanged:  x = ( ( x + width  ) < maximumWidth  ) ? maximumWidth  * 0.2 : 0;  // 0.2 = 20%,
    onHeightChanged: y = ( ( y + height ) < maximumHeight ) ? maximumHeight * 0.2 : 30; // 0.2 = 20%, position with "main header"

    Component.onCompleted: {
        maximumWidth  = Screen.desktopAvailableWidth;
        maximumHeight = Screen.desktopAvailableHeight;
        minimumWidth  = rowLayout.implicitWidth;
        minimumHeight = rowLayout.implicitHeight + captureBox.height * ( captureBox.count - 0.5 );
    }

    header: Rectangle {
        height: rowLayout.height;
        color: "#CFD8DC";

        RowLayout {
            id: rowLayout;
            spacing: Constants.marginSize;

            ExtendedButton {
                id: createBtn;
                text: "Create";
                icon.source: "qrc:/images/scissors.svg";

                property var startFunction: function() {
                    if( captureBox.currentIndex + 1 === SnippingAreaEnum.FullScreen ) {
                        snippedImage.enabled = true;
                        mainWindow.show();
                    }
                    else {
                        support.createWindow( "qrc:/qmls/ScreenshotWindow.qml" ).showFullScreen();
                    }
                }

                onClicked: function() {
                    resetState();
                    mainWindow.hide();
                    support.delay( 250 + delayBox.sleepValue, startFunction );
                }
            }

            ComboBox {
                id: captureBox;
                flat: Constants.isFlatElements;
                hoverEnabled: Constants.isHoverable;

                model: ListModel {
                    ListElement { text: "Rectangle"  }
                    ListElement { text: "Free Form"  }
                    ListElement { text: "Fullscreen" }
                }
            }

            DelayBox {
                id: delayBox;

                Component.onCompleted: currentIndex = Preferences.getDelay();

                property int sleepValue: 1000 * delayBox.currentValue;
            }

            ToolSeparator {}

            BaseActionButtons {}

            ToolSeparator {
                visible: snippedImage.enabled;
            }

            DrawingActionButtons {
                id: drawingActionButtons;
            }
        }
    }

    Flickable {
        id: flickable;
        clip: true;
        anchors.fill: parent;
        anchors.margins: Constants.bigMarginSize;
        boundsBehavior:  Flickable.StopAtBounds;

        width:  Math.min( snippedImage.scaledWidth,  mainWindow.width );
        height: Math.min( snippedImage.scaledHeight, mainWindow.height );
        contentWidth:  snippedImage.scaledWidth;
        contentHeight: snippedImage.scaledHeight;

        Image {
            id : snippedImage;
            enabled: false;
            cache: false;
            transform: support.getTransformScale();

            onEnabledChanged: {
                if( enabled ) {
                    source  = "image://ImageProvider/snipped";
                    Preferences.processActions();
                }
                else {
                    source = "";
                }
            }

            onWidthChanged:  scaledWidth  = support.getScaledValue( width );
            onHeightChanged: scaledHeight = support.getScaledValue( height );

            property int scaledWidth:  0;
            property int scaledHeight: 0;

            ExtendedImage {
                id: drawingActionImage;

                enabled: snippedImage.enabled;
                actionsAllowed: false;

                sendMouseEventSignalCaller: ActionManager;
                onFinishedCallback: function() {
                    drawingActionButtons.refreshUndoRedoButtons();
                    Preferences.processActions();
                }
            }
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

    function resetState() {
        ImageProvider.reset();
        ActionManager.reset();
        snippedImage.enabled = false;
        drawingActionButtons.refreshUndoRedoButtons();
    }

    Support {
        id: support;
    }

    Sequences {}
}
