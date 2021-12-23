import QtQuick 2.0
import qt.ActionTypesEnum

Item {
    Item {
        id: actionsPreferences;

        property color penColor: Preferences.getPenColor();
        property int   penWidth: Preferences.getPenWidth();

        property color highlighterColor: Preferences.getHighlighterColor();
        property int   highlighterWidth: Preferences.getHighlighterWidth();
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

    function setHighlighterColor( value ) {
        actionsPreferences.highlighterColor = value;
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
