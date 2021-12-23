import QtQuick
import QtQuick.Controls.Material

    /*
ExtendedButton {
    id: buttonWithDropDown;

    contentItem: Item {
        Row {
            anchors.fill: parent
            spacing: 5;
            Component.onCompleted: {

                buttonWithDropDown.implicitWidth = implicitWidth;
                buttonWithDropDown.implicitHeight = implicitHeight;
}
            Image {
                source: buttonWithDropDown.icon.source;
                width:  buttonWithDropDown.icon.width;
                height: buttonWithDropDown.icon.height;
                anchors.verticalCenter: parent.verticalCenter;
                onSourceChanged:  {
                    console.log("3 " + width + " " + implicitWidth   );
                }
            }

            Text {
                text: buttonWithDropDown.text;
                font: buttonWithDropDown.font;
                anchors.verticalCenter: parent.verticalCenter;
            }

            ToolButton {
                hoverEnabled: false;
                icon.source: "qrc:/images/down-arrow.svg";
                anchors.verticalCenter: parent.verticalCenter;
                onClicked: menu.open();
            }
        }
    }

    Menu {
        id: menu
        contentItem: ListView {
            model:  ListModel {
                                       ListElement { text: "Rectangle"  }
                                       ListElement { text: "Free Form"  }
                                       ListElement { text: "Fullscreen" }
                                   }
        }
    }
}


*/

import QtQuick.Controls.impl
import QtQuick.Controls.Material.impl
ExtendedButton {
    id: buttonWithDropDown;

    property var model: undefined;

   // property alias model: listView.model;
    contentItem: Item {
        Row {
            anchors.fill: parent
            spacing: 5;
            Component.onCompleted:  buttonWithDropDown.implicitWidth = implicitWidth;

            Image {
                source: buttonWithDropDown.icon.source;
                width:  buttonWithDropDown.icon.width;
                height: buttonWithDropDown.icon.height;
                anchors.verticalCenter: parent.verticalCenter;
            }

            Text {
                text: buttonWithDropDown.text;
                font: buttonWithDropDown.font;
                anchors.verticalCenter: parent.verticalCenter;
            }

            ToolButton {
                hoverEnabled: false;
                icon.source: "qrc:/images/down-arrow.svg";
                anchors.verticalCenter: parent.verticalCenter;
                onClicked: popup.open();
            }
        }
    }

    Popup {
        y: parent.y + parent.height;
        id: popup;
        width: buttonWithDropDown.width
        height: contentItem.implicitHeight * 2;
        //transformOrigin: Item.Top
        /*contentItem: TextField {
            padding: 6
            leftPadding: 12
            rightPadding: 0

                color: buttonWithDropDown.enabled ? buttonWithDropDown.Material.foreground : buttonWithDropDown.Material.hintTextColor
            selectionColor: buttonWithDropDown.Material.accentColor
            verticalAlignment: Text.AlignVCenter

            cursorDelegate: CursorDelegate { }
        }*/
        //width: 100;
       // height: 100;
        font.family: "Courier"
      //  width: buttonWithDropDown.width
       // height: Math.min(contentItem.implicitHeight, buttonWithDropDown.Window.height - topMargin - bottomMargin)
        transformOrigin: Item.Top
//        ListView {
//                  id: listView
//                  currentIndex: 0
//                  anchors.fill: parent

//                  delegate: ItemDelegate {
//                      text: modelData
//                      width: parent.width
//                      highlighted: index === listView.currentIndex

//                  }
//              }

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: buttonWithDropDown.model
            //currentIndex: control.highlightedIndex
            highlightMoveDuration: 0

        }



    }
}
