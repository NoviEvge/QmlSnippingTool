#ifndef FreeFormSnippingArea_H
#define FreeFormSnippingArea_H

#include "BaseSnippingArea.h"

#include <QPolygon>

class FreeFormSnippingArea : public BaseSnippingArea
{
protected:
    virtual void mousePress( QPoint point ) override;
    virtual void mouseRelease( QPoint) override;
    virtual void mouseMove( QPoint point ) override;

private:
    void insertPoint( QPoint point );

private:
    QPolygon polygons_m;
};

#endif // FreeFormSnippingArea_H
