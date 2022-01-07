#pragma once

#include "BaseAction.h"

#include <QPolygon>

class FreeFormSnippingArea : public BaseAction
{
public:
    FreeFormSnippingArea( QImage image, QColor color, int width );

    virtual void mousePress(   QPoint point ) override;
    virtual void mouseRelease( QPoint )       override;
    virtual void mouseMove(    QPoint point ) override;

private:
    void insertPoint( QPoint point );

private:
    QPolygon polygons_m;
};
