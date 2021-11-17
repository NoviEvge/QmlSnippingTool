#ifndef FullscreenSnippingArea_H
#define FullscreenSnippingArea_H

#include "BaseSnippingArea.h"

class FullscreenSnippingArea : public BaseSnippingArea
{
protected:
    virtual void mousePress( QPoint point ) override;
};

#endif // FullscreenSnippingArea_H
