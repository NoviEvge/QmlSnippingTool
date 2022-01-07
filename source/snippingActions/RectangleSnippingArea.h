#pragma once

#include "BaseAction.h"

class RectangleSnippingArea : public BaseAction
{
public:
    RectangleSnippingArea( QImage image, QColor color, int width );

    virtual void mousePress(   QPoint point ) override;
    virtual void mouseRelease( QPoint point ) override;
    virtual void mouseMove(    QPoint point ) override;

private:
    QRect getSelectionArea( QPoint point ) const;

private:
    QPoint startPoint_m;
};
