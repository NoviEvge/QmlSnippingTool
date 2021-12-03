#ifndef BaseSnippingArea_H
#define BaseSnippingArea_H

#include "HighDpiScaler.h"

#include <QEvent>
#include <QImage>
#include <QObject>

class BaseSnippingArea : public QObject
{
    Q_OBJECT

protected:
    BaseSnippingArea() = default;

    virtual void mousePress( QPoint) {};
    virtual void mouseRelease( QPoint ) {};
    virtual void mouseMove( QPoint ) {};

public slots:
    void mouseEvent(QPoint point, QEvent::Type eventType);
    void screenshotCreated();
    void screenshotFinished();

signals:
    void screenshotUpdated( QImage image );
    void forceFinish();
    void finished();

protected:
    HighDPIScaler highDPIScaler_m;
};

#endif // BaseSnippingArea_H
