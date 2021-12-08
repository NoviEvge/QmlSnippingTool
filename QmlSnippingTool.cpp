#include "QmlSnippingTool.h"

#include "snippingAreas/RectangleSnippingArea.h"
#include "snippingAreas/FreeFormSnippingArea.h"
#include "snippingAreas/FullscreenSnippingArea.h"

QmlSnippingTool::QmlSnippingTool()
{
    imageProvider_m = new ImageProvider();
    captureMode_m = new CaptureMode();

    captureModeChanged( CaptureModes::eRectangle );
    QObject::connect( captureMode_m,
                      &CaptureMode::captureModeChanged,
                      this,
                      &QmlSnippingTool::captureModeChanged );
}

void QmlSnippingTool:: captureModeChanged( CaptureModes mode )
{
    switch( mode )
    {
        case CaptureModes::eRectangle:
            snippingArea_m.reset( new RectangleSnippingArea );
            break;
        case CaptureModes::eFreeForm:
            snippingArea_m.reset( new FreeFormSnippingArea );
            break;
        case CaptureModes::eFullScreen:
            snippingArea_m.reset( new FullscreenSnippingArea );
            break;
        default:
            return;
    }

    QObject::connect( imageProvider_m,
                      &ImageProvider::screenshotCreated,
                      snippingArea_m.get(),
                      &RectangleSnippingArea::screenshotCreated );

    QObject::connect( imageProvider_m,
                      &ImageProvider::screenshotFinished,
                      snippingArea_m.get(),
                      &RectangleSnippingArea::screenshotFinished );

    QObject::connect( snippingArea_m.get(),
                      &RectangleSnippingArea::screenshotUpdated,
                      imageProvider_m,
                      &ImageProvider::screenshotUpdated);

    QObject::connect( snippingArea_m.get(),
                      &RectangleSnippingArea::forceFinish,
                      imageProvider_m,
                      &ImageProvider::forceFinish);

    QObject::connect( snippingArea_m.get(),
                      &RectangleSnippingArea::finished,
                      imageProvider_m,
                      &ImageProvider::finished);
}

ImageProvider *QmlSnippingTool::imageProvider() const
{
    return imageProvider_m;
}

CaptureMode *QmlSnippingTool::captureMode() const
{
    return captureMode_m;
}
