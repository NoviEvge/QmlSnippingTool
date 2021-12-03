#include "FullscreenSnippingArea.h"
#include "ImagesContainer.h"

void FullscreenSnippingArea::mousePress(QPoint)
{
    auto image = ImagesContainer::instance()->getOriginalImage();
    emit screenshotUpdated(image);
}
