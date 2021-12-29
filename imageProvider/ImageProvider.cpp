#include "ImageProvider.h"

#include <QGuiApplication>
#include <QScreen>
#include <QPainter>

ImageProvider::ImageProvider() : QQuickImageProvider( QQuickImageProvider::Image )
{
}

ImageProvider *ImageProvider::instance()
{
    static ImageProvider* instance = new ImageProvider();
    return instance;
}

QImage ImageProvider::requestImage( const QString& id, QSize* size, const QSize& )
{
    if( id == "screenshot" )
    {
        currentImage_m = takeScreenshot();
    }
    else if( id == "snipped" )
    {
        currentImage_m = getCurrentImage();;
        if( currentImage_m.isNull() )
        {
            takeScreenshot();
            currentImage_m = getOriginalImage();
        }
    }

    if( !currentImage_m.isNull() )
        *size = currentImage_m.size();

    return currentImage_m;
}

QImage ImageProvider::getOriginalImage()
{
    return originalImage_m;
}

QImage ImageProvider::getCurrentImage()
{
    return currentImage_m;
}

QImage ImageProvider::takeScreenshot()
{
    QScreen* screen = QGuiApplication::primaryScreen();
    if( screen )
    {
        originalImage_m = screen->grabWindow( 0 ).toImage();
        originalImage_m.convertTo( QImage::Format_ARGB32 );

        currentImage_m = originalImage_m;
        QPainter painter{ &currentImage_m };
        painter.fillRect( currentImage_m.rect(), QColor( 128, 128, 128, 80 ) );
    }

    return currentImage_m;
}

void ImageProvider::imageUpdated( QImage image, ImageState state )
{
    if( state == ImageState::SnippingFinal )
        originalImage_m = image;

    currentImage_m = image;

    emit frameUpdated();
}

void ImageProvider::reset()
{
    originalImage_m = {};
    currentImage_m  = {};
}
