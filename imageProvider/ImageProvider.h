#pragma once

#include "ImageProviderEnum.h"

#include <QQuickImageProvider>
#include <QImage>

class ImageProvider : public QQuickImageProvider
{
    Q_OBJECT

public:
    static ImageProvider* instance();

    QImage requestImage( const QString& id, QSize* size, const QSize& requestedSize ) override;

    QImage getOriginalImage();
    QImage getCurrentImage();

signals:
    void frameUpdated();
    void finished( FinishStatus status );

private:
    ImageProvider();
    QImage takeScreenshot();

public slots:
    void imageUpdated( QImage image, ImageState state );
    void reset();

private:
    QImage originalImage_m;
    QImage currentImage_m;
};
