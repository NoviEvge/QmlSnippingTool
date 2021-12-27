#include "PenAction.h"
#include "HighDpi.h"

#include <QPainter>

PenAction::PenAction( QImage image, QColor color, int width) : BaseAction( image, color, width )
{
}

void PenAction::mousePress( QPoint point )
{
    lastPoint_m = utility::highDPI::unscale( point );

    drawImage( lastPoint_m );
}

void PenAction::mouseRelease( QPoint )
{
    emit imageUpdated( image_m, ImageState::DrawingFinal );
}

void PenAction::mouseMove( QPoint point )
{
    point = utility::highDPI::unscale( point );

    drawImage( point );

    lastPoint_m = point;
}

void PenAction::drawImage( QPoint point )
{
    QPainter painter{ &image_m };
    painter.setRenderHint( QPainter::Antialiasing );
    painter.setCompositionMode( QPainter::CompositionMode_Source );

    QColor color = getColor();

    QPen pen( color, getWidth(), Qt::SolidLine, Qt::RoundCap );
    painter.setPen( pen );

    if( lastPoint_m == point )
        painter.drawPoint( point );
    else
        painter.drawLine( lastPoint_m, point );

    emit imageUpdated( image_m, ImageState::Template );
}
