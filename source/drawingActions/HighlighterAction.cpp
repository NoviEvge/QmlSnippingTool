#include "HighlighterAction.h"
#include "HighDpi.h"

#include <QPainter>

HighlighterAction::HighlighterAction( QImage image, QColor color, int width ) : BaseAction( image, color, width )
{
}

void HighlighterAction::mousePress( QPoint point )
{
    lastPoint_m = utility::highDPI::unscale( point );

    drawImage( lastPoint_m );
}

void HighlighterAction::mouseRelease( QPoint )
{
    emit imageUpdated( image_m, ImageState::DrawingFinal );
}

void HighlighterAction::mouseMove( QPoint point )
{
    point = utility::highDPI::unscale( point );

    drawImage( point );

    lastPoint_m = point;
}

void HighlighterAction::drawImage( QPoint point )
{
    QPainter painter{ &image_m };
    painter.setRenderHint( QPainter::Antialiasing );
    painter.setCompositionMode( QPainter::CompositionMode_Multiply );

    QPen pen( getColor(), getWidth(), Qt::SolidLine, Qt::RoundCap );
    painter.setPen( pen );

    if( lastPoint_m == point )
        painter.drawPoint( point );
    else
        painter.drawLine( lastPoint_m, point );

    emit imageUpdated( image_m, ImageState::Template );
}
