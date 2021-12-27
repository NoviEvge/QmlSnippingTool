#include "HighlighterAction.h"
#include "HighDpi.h"

#include <QPainter>
#include <QPainterPath>
#include "QDebug"
HighlighterAction::HighlighterAction( QImage image, QColor color, int width ) : BaseAction( image, color, width )
{
}

void HighlighterAction::mousePress( QPoint point )
{
    lastPoint_m = utility::highDPI::unscale( point );

    polygon_m.moveTo( lastPoint_m );
    drawImage( lastPoint_m );
}

void HighlighterAction::mouseRelease( QPoint )
{
    emit imageUpdated( image_m, ImageState::DrawingFinal );
}

void HighlighterAction::mouseMove( QPoint point )
{
    point = utility::highDPI::unscale( point );

    polygon_m.lineTo( point );
    drawImage( point );

    lastPoint_m = point;
}

void HighlighterAction::drawImage( QPoint point )
{
    QPainter painter{ &image_m };
    painter.setRenderHint( QPainter::Antialiasing );

    QColor color = getColor();
    color.setAlphaF( 0.5 );
    QBrush brush{color};
    QPen pen( color, getWidth(), Qt::SolidLine, Qt::RoundCap );
    painter.setPen( pen );
    painter.setBrush(brush);
    painter.setOpacity(0.5);
painter.drawPath( polygon_m);
polygon_m.clear();
polygon_m.moveTo(point);
    qDebug()<<point;

    emit imageUpdated( image_m, ImageState::Template );
}
