#ifndef IMAGESCONTAINER_H
#define IMAGESCONTAINER_H

#include <QImage>

class ImagesContainer
{
public:
    static ImagesContainer* instance();

    void setOriginalImage( QImage );
    void setEditableImage( QImage );

    QImage getOriginalImage() const;
    QImage getEditableImage() const;

private:
    ImagesContainer() = default;

private:
    QImage originalImage_m;
    QImage editableImage_m;
};

#endif // IMAGESCONTAINER_H
