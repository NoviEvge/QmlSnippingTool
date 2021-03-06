#pragma once

#include "BaseAction.h"

class HighlighterAction : public BaseAction
{
public:
    HighlighterAction( QImage image, QColor color, int width );

protected:
    virtual void mousePress(   QPoint point ) override;
    virtual void mouseRelease( QPoint )       override;
    virtual void mouseMove(    QPoint point ) override;

private:
    void drawImage( QPoint point );

private:
    QPoint lastPoint_m;
};
