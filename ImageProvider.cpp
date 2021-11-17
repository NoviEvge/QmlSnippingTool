#include "ImageProvider.h"

#include <QGuiApplication>
#include <QScreen>
#include <QPainter>

#include <support/ImagesContainer.h>

ImageProvider::ImageProvider() : QQuickImageProvider(QQuickImageProvider::Image)
{
}

QImage ImageProvider::requestImage(const QString &id, QSize *size, const QSize &)
{
    if( id == "screenshot")
    {
        image_m = takeScreenshot();

        emit screenshotCreated();
    }
    else if ( id == "snipped" )
    {
        image_m = ImagesContainer::instance()->getOriginalImage();
        if (image_m.isNull())
        {
            takeScreenshot();
            image_m = ImagesContainer::instance()->getOriginalImage();
        }

        emit screenshotFinished();
    }

    if ( !image_m.isNull() )
    {
        size->setWidth( image_m.width() );
        size->setHeight( image_m.height() );
    }

    return image_m;
}

void ImageProvider::clear()
{
    image_m = {};
    auto instance = ImagesContainer::instance();
    instance->setOriginalImage( {} );
    instance->setEditableImage( {} );
    emit screenshotFinished();
}

QImage ImageProvider::takeScreenshot()
{
    QImage image;
    QScreen *screen = QGuiApplication::primaryScreen();
    if (screen)
    {
        image = screen->grabWindow(0).toImage();
        image.convertTo(QImage::Format_ARGB32);

        ImagesContainer::instance()->setOriginalImage( image );

        QPainter p(&image);
        p.fillRect(image.rect(),QColor( 128, 128, 128, 80));

        ImagesContainer::instance()->setEditableImage( image );
    }

    return image;
}

void ImageProvider::screenshotUpdated(QImage image )
{
    image_m = image;

    emit signalNewFrameReady();
}
