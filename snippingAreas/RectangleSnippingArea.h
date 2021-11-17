#ifndef RectangleSnippingArea_H
#define RectangleSnippingArea_H

#include "BaseSnippingArea.h"

class RectangleSnippingArea : public BaseSnippingArea
{
protected:
    virtual void mousePress( QPoint point ) override;
    virtual void mouseRelease( QPoint point ) override;
    virtual void mouseMove( QPoint point ) override;

private:
    QRect getSelectionArea( QPoint point ) const;

private:
    QPoint startPoint_m;
};

#endif // RectangleSnippingArea_H
