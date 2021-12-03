#ifndef QMLSNIPPINGTOOL_H
#define QMLSNIPPINGTOOL_H

#include <QObject>

#include "support/CaptureMode.h"
#include "support/ImageProvider.h"
#include "snippingAreas/BaseSnippingArea.h"

class QmlSnippingTool : public QObject
{
    Q_OBJECT

public:
    QmlSnippingTool();

    ImageProvider* imageProvider() const;
    CaptureMode* captureMode() const;

private slots:
    void captureModeChanged( CaptureModes mode );

private:
    QScopedPointer< BaseSnippingArea > snippingArea_m;
    ImageProvider* imageProvider_m;
    CaptureMode* captureMode_m;
};

#endif // QMLSNIPPINGTOOL_H
