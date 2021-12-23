#pragma once

#include <QObject>
#include <QPoint>

class IMouseEvents : public QObject
{
    Q_OBJECT

public:
    virtual ~IMouseEvents() = default;

public slots:
    virtual void mousePress(   QPoint point ) = 0;
    virtual void mouseRelease( QPoint point ) = 0;
    virtual void mouseMove(    QPoint point ) = 0;
};
