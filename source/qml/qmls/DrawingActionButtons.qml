import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import qt.ActionTypesEnum

RowLayout {
    visible: snippedImage.enabled;
    spacing: Constants.marginSize;

    CustomWidthButton {
        icon.source: "qrc:/images/pen.svg";
        ToolTip.text: "Pen";
        ToolTip.delay: Constants.tooltipDelay;
        actionType: ActionTypesEnum.Pen;
    }

    ExtendedRoundButton {
        id: penColorControl;
        implicitWidth:  20;
        implicitHeight: 20;
        shadowed: false;
        onClicked: penColorPicker.open();

        Component.onCompleted: {
            penColorPicker.updateCurrentColor( TemporaryPreferences.getPenColor() );
            penColorPicker.updateCurrentWidth( TemporaryPreferences.getPenWidth() );
        }

        ColorAndWidthPopup {
            id: penColorPicker;

            onColorChanged: ( color ) => {
                                penColorControl.color = color;
                                TemporaryPreferences.setPenColor( color );
                            }

            onWidthChanged: ( width ) => TemporaryPreferences.setPenWidth( width );
        }
    }

    CustomWidthButton {
        icon.source: "qrc:/images/highlighter.svg";
        ToolTip.text: "Highlighter";
        ToolTip.delay: Constants.tooltipDelay;
        actionType: ActionTypesEnum.Highlighter;
    }

    CustomWidthButton {
        id: undoAction;
        enabled: false;
        icon.source: "qrc:/images/undo.svg";
        ToolTip.text: "Undo";
        ToolTip.delay: Constants.tooltipDelay;
        onClicked: ActionManager.undoLastAction();
        actionType: ActionTypesEnum.Undo;
        actionsAllowed: false;
    }

    CustomWidthButton {
        id: redoAction;
        enabled: false;
        icon.source: "qrc:/images/redo.svg";
        ToolTip.text: "Redo";
        ToolTip.delay: Constants.tooltipDelay;
        onClicked: ActionManager.redoLastAction();
        actionType: ActionTypesEnum.Redo;
        actionsAllowed: false;
    }

    function refreshUndoRedoButtons() {
        undoAction.enabled = ActionManager.isUndoActions();
        redoAction.enabled = ActionManager.isRedoActions();
    }
}
