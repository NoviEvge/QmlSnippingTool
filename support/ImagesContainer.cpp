#include "ImagesContainer.h"

ImagesContainer *ImagesContainer::instance()
{
    static ImagesContainer* obj = new ImagesContainer();
    return obj;
}

void ImagesContainer::setOriginalImage(QImage image)
{
    originalImage_m = image;
}

void ImagesContainer::setEditableImage(QImage image)
{
    editableImage_m = image;
}

QImage ImagesContainer::getOriginalImage() const
{
    return originalImage_m;
}

QImage ImagesContainer::getEditableImage() const
{
    return editableImage_m;
}

