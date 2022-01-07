#pragma once

#include <QObject>

class ActionTypesEnum
{
    Q_GADGET

public:
    ActionTypesEnum() = delete;

    enum ActionType {
        None = 0,
        Pen,
        Highlighter,
        Undo, // only for qml
        Redo  // only for qml
    };

    Q_ENUM(ActionType)
};

using ActionType = ActionTypesEnum::ActionType;
