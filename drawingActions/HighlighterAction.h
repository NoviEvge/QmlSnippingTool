#pragma once

#include "BaseAction.h"

#include <QList>

class HighlighterAction : public BaseAction
{
public:
    HighlighterAction( QImage image, QColor color, int width );

protected:
    virtual void mousePress(   QPoint point ) override;
    virtual void mouseRelease( QPoint )       override;
    virtual void mouseMove(    QPoint point ) override;

private:
    void insertPoint( QPoint point );
    void drawImage( QPoint point );

private:
    QList< QPoint > dots_m;
    QPoint lastPoint_m;
};
