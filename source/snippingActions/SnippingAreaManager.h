#pragma once

#include "BaseAction.h"
#include "SnippingAreaEnum.h"

#include <QObject>

class SnippingAreaManager final : public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE void reset();

signals:
    void mouseRelease( QPoint point );
    void mouseMove(    QPoint point );
    void mousePressToInternal( QPoint point );

public slots:
    void mousePress( CaptureMode mode, QPoint point, QColor color, int width );

private:
    QScopedPointer< BaseAction > snippingArea_m;
};
