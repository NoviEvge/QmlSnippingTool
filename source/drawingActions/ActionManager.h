#pragma once

#include "BaseAction.h"
#include "ActionTypesEnum.h"

#include <QSharedPointer>
#include <QStack>

class ActionManager final : public QObject
{
    Q_OBJECT

public:
    ActionManager();

    Q_INVOKABLE bool isUndoActions() const;
    Q_INVOKABLE bool isRedoActions() const;

private:
    void setActionConnects( QSharedPointer< BaseAction > action );
    void disconnectAction(  QSharedPointer< BaseAction > action );

signals:
    void mouseMove( QPoint point );
    void finished( FinishStatus status );

    void imageUpdated( QImage image, ImageState state );
    void mousePressToInternal( QPoint point );
    void mouseReleaseToInternal( QPoint point );

public slots:
    void mousePress( ActionType type, QPoint point, QColor color, int width );
    void mouseRelease( QPoint point );

    void reset();

    void undoLastAction();
    void redoLastAction();

private:
    QStack< QSharedPointer< BaseAction > > actionStack_m;

    QStack< QSharedPointer< BaseAction > > undoRedoActionStack_m;
};
