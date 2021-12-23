#pragma once

#include "ActionManager.h"
#include "SnippingAreaManager.h"

#include <QObject>

class QmlSnippingTool : public QObject
{
    Q_OBJECT

public:
    QmlSnippingTool();

    QSharedPointer< ActionManager > actionManager() const;
    QSharedPointer< SnippingAreaManager > snippingAreaManager() const;

private:
    QSharedPointer< ActionManager > actionManager_m;
    QSharedPointer< SnippingAreaManager > snippingAreaManager_m;
};
