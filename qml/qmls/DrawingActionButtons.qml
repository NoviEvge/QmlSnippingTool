import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import Qt.labs.platform
import qt.ActionTypesEnum

RowLayout {
    visible: snippedImage.enabled;
    spacing: Constants.marginSize;

    ButtonWithDropDown {
        icon.source: "qrc:/images/pen.svg";
        ToolTip.text: "Pen";
        ToolTip.delay: Constants.tooltipDelay;
        actionType: ActionTypesEnum.Pen;
    }

    ButtonWithDropDown {
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
    }

    CustomWidthButton {
        id: redoAction;
        enabled: false;
        icon.source: "qrc:/images/redo.svg";
        ToolTip.text: "Redo";
        ToolTip.delay: Constants.tooltipDelay;
        onClicked: ActionManager.redoLastAction();
        actionType: ActionTypesEnum.Redo;
    }

    function refreshUndoRedoButtons() {
        undoAction.enabled = ActionManager.isUndoActions();
        redoAction.enabled = ActionManager.isRedoActions();
    }
}
