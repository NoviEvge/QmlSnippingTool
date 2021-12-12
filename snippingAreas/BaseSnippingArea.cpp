#include "BaseSnippingArea.h"
#include "MouseEventHandler.h"

void BaseSnippingArea::mouseEvent( QPoint point, QEvent::Type eventType )
{
    if( eventType ==  QEvent::MouseMove )
        mouseMove(point);
    else if( eventType == QEvent::MouseButtonPress )
        mousePress(point);
    else if( eventType == QEvent::MouseButtonRelease )
        mouseRelease(point);
}

void BaseSnippingArea::screenshotCreated()
{
    QObject::connect( MouseEventHandler::instance(),
                      &MouseEventHandler::mouseEvent,
                      this,
                      &BaseSnippingArea::mouseEvent );
}

void BaseSnippingArea::screenshotFinished()
{
    QObject::disconnect( MouseEventHandler::instance(),
                         &MouseEventHandler::mouseEvent,
                         this,
                         &BaseSnippingArea::mouseEvent );
}
