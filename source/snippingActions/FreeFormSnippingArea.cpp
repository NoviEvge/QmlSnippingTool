#include "FreeFormSnippingArea.h"
#include "ImageProvider.h"
#include "HighDpi.h"

#include <QPainter>
#include <QPainterPath>

FreeFormSnippingArea::FreeFormSnippingArea( QImage image, QColor color, int width ) : BaseAction( image, color, width )
{
}

void FreeFormSnippingArea::mousePress( QPoint point )
{
    insertPoint( point );
}

void FreeFormSnippingArea::mouseRelease( QPoint )
{
    if( polygons_m.size() <= 1 )
    {
        emit finished( FinishStatus::ForcedExit );
        return;
    }

    auto originalImage = ImageProvider::instance()->getOriginalImage();

    QPainterPath painterPath;
    painterPath.addPolygon( polygons_m );

    QImage newImage{ originalImage.size(), QImage::Format_ARGB32 };
    newImage.fill( Qt::transparent );
    newImage.setDevicePixelRatio( utility::highDPI::scaleFactor() );

    QPainter painter{ &newImage };
    painter.setRenderHint( QPainter::Antialiasing );
    painter.setClipPath( painterPath );
    painter.drawImage( QPoint{}, originalImage, originalImage.rect() );

    auto polygonRect = polygons_m.boundingRect().intersected( originalImage.rect() );
    polygonRect = utility::highDPI::scale( polygonRect );

    emit imageUpdated( newImage.copy( polygonRect ), ImageState::SnippingFinal );

    emit finished( FinishStatus::Normal );
}

void FreeFormSnippingArea::mouseMove( QPoint point )
{
    insertPoint( point );

    auto fromPoint = polygons_m.at( polygons_m.size() - 2 );
    auto toPoint   = polygons_m.at( polygons_m.size() - 1 );

    QPainter painter{ &image_m };
    painter.setRenderHint( QPainter::Antialiasing );

    QPen pen{ getColor(), getWidth(), Qt::SolidLine, Qt::RoundCap, Qt::RoundJoin };
    painter.setPen( pen );
    painter.drawLine( fromPoint, toPoint );

    emit imageUpdated( image_m, ImageState::Template );
}

void FreeFormSnippingArea::insertPoint( QPoint point )
{
    polygons_m << point;
}
