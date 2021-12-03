#include "RectangleSnippingArea.h"
#include "ImagesContainer.h"

#include <QPainter>

void RectangleSnippingArea::mousePress(QPoint point)
{
    startPoint_m = point;
}

void RectangleSnippingArea::mouseRelease(QPoint point)
{
    const auto selectionArea = getSelectionArea( point );
    if( selectionArea.width() <= 0 && selectionArea.height() <= 0 )
    {
        emit forceFinish();
        return;
    }

    auto imageContainer = ImagesContainer::instance();
    auto origImage = imageContainer->getOriginalImage();
    const auto scaledSelectionArea = highDPIScaler_m.scale( selectionArea );

    imageContainer->setOriginalImage( origImage.copy( scaledSelectionArea ) );

    emit finished();
}

void RectangleSnippingArea::mouseMove(QPoint point)
{
    auto imageContainer = ImagesContainer::instance();
    auto editImage = imageContainer->getEditableImage();
    auto origImage = imageContainer->getOriginalImage();

    auto selectionArea = getSelectionArea( point );
    auto scaledSelectionArea = highDPIScaler_m.scale( selectionArea );

    QPainter painter(&editImage);
    painter.drawImage( selectionArea, origImage, scaledSelectionArea );

    emit screenshotUpdated(editImage);
}

QRect RectangleSnippingArea::getSelectionArea( QPoint point ) const
{
    int width = qAbs( point.x() - startPoint_m.x() );
    int height = qAbs( point.y() - startPoint_m.y() );
    int x = qMin( point.x(),startPoint_m.x() );
    int y = qMin( point.y(), startPoint_m.y() );

    QRect result( x,y, width, height);

    return result.normalized();
}
