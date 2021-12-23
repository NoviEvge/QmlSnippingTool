import QtQuick.Controls.Material
import qt.ActionTypesEnum

Button {
    flat: Constants.isFlatElements;
    hoverEnabled: Constants.isHoverable;

    property int actionType: ActionTypesEnum.None;

    onClicked: {
        drawingActionImage.onPressCreationType = actionType;
        drawingActionImage.onPressCreationColorFunc = function() { return TemporaryPreferences.getActionColor( actionType ); }
        drawingActionImage.onPressCreationWidthFunc = function() { return TemporaryPreferences.getActionWidth( actionType ); }
    }
}
