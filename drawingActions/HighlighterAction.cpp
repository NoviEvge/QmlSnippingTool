#include "HighlighterAction.h"
#include "HighDpi.h"

#include <QPainter>
#include <QPainterPath>
#include <QDebug>
HighlighterAction::HighlighterAction( QImage image, QColor color, int width ) : BaseAction( image, color, width )
{
}

void HighlighterAction::mousePress( QPoint point )
{
    lastPoint_m = utility::highDPI::unscale( point );
    insertPoint( lastPoint_m );
    drawImage( lastPoint_m );
}

void HighlighterAction::mouseRelease( QPoint )
{
    emit imageUpdated( image_m, ImageState::DrawingFinal );
}

void HighlighterAction::mouseMove( QPoint point )
{
    point = utility::highDPI::unscale( point );

    insertPoint( point );
    drawImage( point );

    lastPoint_m = point;
}

void HighlighterAction::insertPoint( QPoint point )
{
    if( dots_m.count() > 4 )
        dots_m.pop_front();

    dots_m.emplaceBack( point );
}

void HighlighterAction::drawImage( QPoint )
{
    if( dots_m.count() < 4 )
        return;

    qDebug()<<dots_m;
    QPainterPath bezierPath;
      bezierPath.moveTo(dots_m.first());

    QPainterPath painterPath;
    bezierPath.cubicTo( dots_m.at(1), dots_m.at(2), dots_m.at(3));
    QPainter painter{ &image_m };
    painter.setRenderHint( QPainter::Antialiasing );
    QColor color = getColor();
    color.setAlphaF(0.3);
    QPen pen(color  , getWidth() );
        //pen.setCapStyle(Qt::FlatCap);
    painter.setCompositionMode(QPainter::CompositionMode_Source);
    painter.setPen(pen);
   // painter.drawPath(bezierPath );
    painter.setOpacity( 0.5);
       painter.drawEllipse(20,20,200,100);

    emit imageUpdated( image_m, ImageState::Template );
}
