pragma Singleton

import QtQuick

Item {
    property int marginSize: 0;
    property int bigMarginSize: 50;
    property int tooltipDelay: 1000; // ms

    property bool isFlatElements: true;
    property bool isHoverable: true;

    property int minDrawingActionsWidth: 1;
    property int maxDrawingActionsWidth: 100;

    property int fontPixelSize: 16;
}
