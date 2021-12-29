pragma Singleton

import QtQuick 2.0
import qt.ActionTypesEnum

Item {
    Item {
        id: actionsPreferences;

        property color penColor: "red" ;
        property int   penWidth: 5;

        property color highlighterColor: "yellow";
        property int   highlighterWidth: 5;

        Component.onCompleted: {
            penColor = Preferences.getPenColor();
            penWidth = Preferences.getPenWidth();

            highlighterColor = Preferences.getHighlighterColor();
            highlighterWidth = Preferences.getHighlighterWidth();
        }
    }

    function setPenColor( value ) {
        actionsPreferences.penColor = value;
    }

    function getPenColor() {
        return actionsPreferences.penColor;
    }

    function setPenWidth( value ) {
        actionsPreferences.penWidth = value;
    }

    function getPenWidth() {
        return actionsPreferences.penWidth;
    }

    function getHighlighterColor() {
        return actionsPreferences.highlighterColor;
    }

    function setHighlighterWidth( value ) {
        actionsPreferences.highlighterWidth = value;
    }

    function getHighlighterWidth() {
        return actionsPreferences.highlighterWidth;
    }

    function getActionColor( action ) {
        if( action === ActionTypesEnum.Pen )
            return getPenColor();
        else if( action === ActionTypesEnum.Highlighter )
            return getHighlighterColor();
    }

    function getActionWidth( action ) {
        if( action === ActionTypesEnum.Pen )
            return getPenWidth();
        else if( action === ActionTypesEnum.Highlighter )
            return getHighlighterWidth();
    }
}
