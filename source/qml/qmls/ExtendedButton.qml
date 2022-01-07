import QtQuick.Controls.Material
import qt.ActionTypesEnum

RoundButton {
    flat: Constants.isFlatElements;
    hoverEnabled: Constants.isHoverable;

    property int actionType: ActionTypesEnum.None;
    property bool actionsAllowed: true;

    onClicked: {
        if( actionType != ActionTypesEnum.None ) {
            drawingActionImage.onPressCreationType = actionType;
            drawingActionImage.onPressCreationColorFunc = function() { return TemporaryPreferences.getActionColor( actionType ); }
            drawingActionImage.onPressCreationWidthFunc = function() { return TemporaryPreferences.getActionWidth( actionType ); }
            drawingActionImage.actionsAllowed = actionsAllowed;
        }
    }
}
