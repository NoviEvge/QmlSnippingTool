#include "SnippingAreaManager.h"
#include "ImageProvider.h"
#include "RectangleSnippingArea.h"
#include "FreeFormSnippingArea.h"

void SnippingAreaManager::reset()
{
    snippingArea_m.reset( nullptr );
}

void SnippingAreaManager::mousePress( CaptureMode mode, QPoint point, QColor color, int width )
{
    if( mode == CaptureMode::None )
        return;

    auto imageProvider = ImageProvider::instance();

    QImage image = imageProvider->getCurrentImage();
    if( mode == CaptureMode::Rectangle )
        snippingArea_m.reset( new RectangleSnippingArea( image, color, width ) );
    else if( mode == CaptureMode::FreeForm )
        snippingArea_m.reset( new FreeFormSnippingArea( image, color, width ) );

    QObject::connect( snippingArea_m.data(),
                      &BaseAction::imageUpdated,
                      imageProvider,
                      &ImageProvider::imageUpdated );

    QObject::connect( snippingArea_m.data(),
                      &BaseAction::finished,
                      imageProvider,
                      &ImageProvider::finished );

    QObject::connect( this,
                      &SnippingAreaManager::mouseMove,
                      snippingArea_m.data(),
                      &BaseAction::mouseMove );

    QObject::connect( this,
                      &SnippingAreaManager::mousePressToInternal,
                      snippingArea_m.data(),
                      &BaseAction::mousePress );

    QObject::connect( this,
                      &SnippingAreaManager::mouseRelease,
                      snippingArea_m.data(),
                      &BaseAction::mouseRelease );

    emit mousePressToInternal( point );
}
