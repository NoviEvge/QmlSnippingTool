#ifndef SNIPPINGTOOL_H
#define SNIPPINGTOOL_H

#include <QObject>

#include "captureMode/CaptureMode.h"
#include "snippingAreas/BaseSnippingArea.h"
#include "ImageProvider.h"

class SnippingTool : public QObject
{
    Q_OBJECT

public:
    SnippingTool();

    ImageProvider* imageProvider() const;
    CaptureMode* captureMode() const;

private slots:
    void captureModeChanged( CaptureModes mode );

private:
    QScopedPointer< BaseSnippingArea > snippingArea_m;
    ImageProvider* imageProvider_m;
    CaptureMode* captureMode_m;
};

#endif // SNIPPINGTOOL_H
