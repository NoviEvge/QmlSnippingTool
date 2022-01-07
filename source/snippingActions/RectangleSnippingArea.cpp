#include "RectangleSnippingArea.h"
#include "ImageProvider.h"
#include "HighDpi.h"

#include <QPainter>

RectangleSnippingArea::RectangleSnippingArea( QImage image, QColor color, int width ) : BaseAction( image, color, width )
{
}

void RectangleSnippingArea::mousePress( QPoint point )
{
    startPoint_m = point;
}

void RectangleSnippingArea::mouseRelease( QPoint point )
{
    const auto selectionArea = getSelectionArea( point );
    if( selectionArea.width() <= 0 && selectionArea.height() <= 0 )
    {
        emit finished( FinishStatus::ForcedExit );
        return;
    }

    auto origImage = ImageProvider::instance()->getOriginalImage();
    const auto scaledSelectionArea = utility::highDPI::scale( selectionArea );

    emit imageUpdated( origImage.copy( scaledSelectionArea ), ImageState::SnippingFinal );
    emit finished( FinishStatus::Normal );
}

void RectangleSnippingArea::mouseMove( QPoint point )
{
    auto editImage = getImage();
    auto origImage = ImageProvider::instance()->getOriginalImage();

    auto selectionArea = getSelectionArea( point );
    auto scaledSelectionArea = utility::highDPI::scale( selectionArea );

    QPainter painter{ &editImage };
    painter.drawImage( selectionArea, origImage, scaledSelectionArea );

    QPen pen{ getColor(), getWidth(), Qt::SolidLine, Qt::RoundCap, Qt::RoundJoin };
    painter.setPen( pen );

    selectionArea += QMargins( getWidth() / 2, getWidth() / 2, getWidth() / 2, getWidth() / 2 );
    painter.drawRect( selectionArea);

    emit imageUpdated( editImage, ImageState::Template );
}

QRect RectangleSnippingArea::getSelectionArea( QPoint point ) const
{
    int width  = qAbs( point.x() - startPoint_m.x() );
    int height = qAbs( point.y() - startPoint_m.y() );
    int x = qMin( point.x(), startPoint_m.x() );
    int y = qMin( point.y(), startPoint_m.y() );

    QRect result( x, y, width, height );

    return result.normalized();
}
