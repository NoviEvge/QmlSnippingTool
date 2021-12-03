#include "FreeFormSnippingArea.h"

#include <QPainter>
#include <QPainterPath>
#include "ImagesContainer.h"

void FreeFormSnippingArea::mousePress(QPoint point)
{
    insertPoint(point);
}

void FreeFormSnippingArea::mouseRelease(QPoint)
{
    if( polygons_m.size() <= 1 )
    {
        emit forceFinish();
        return;
    }

    auto imageContainer = ImagesContainer::instance();
    auto originalImage = imageContainer->getOriginalImage();

    QPainterPath painterPath;
    painterPath.addPolygon( polygons_m);

    QImage newImage( originalImage.size(), QImage::Format_ARGB32 );
    newImage.fill(Qt::transparent);
    newImage.setDevicePixelRatio(highDPIScaler_m.scaleFactor());

    QPainter painter(&newImage);
    painter.setRenderHint(QPainter::Antialiasing);
    painter.setClipPath(painterPath);
    painter.drawImage( QPoint{}, originalImage, originalImage.rect());

    auto polygonRect = polygons_m.boundingRect().intersected(originalImage.rect());
    polygonRect = highDPIScaler_m.scale( polygonRect );

    imageContainer->setOriginalImage( newImage.copy(polygonRect) );
    polygons_m.clear();

    emit finished();
}

void FreeFormSnippingArea::mouseMove(QPoint point)
{
    auto imageContainer = ImagesContainer::instance();
    insertPoint( point );

    auto fromPoint = polygons_m.at(polygons_m.size() - 2 );
    auto toPoint = polygons_m.at(polygons_m.size() - 1 );

    auto newImage = imageContainer->getEditableImage();

    QPainter painter(&newImage);
    painter.setRenderHint(QPainter::Antialiasing);

    QPen pen(Qt::red, 3, Qt::SolidLine, Qt::RoundCap, Qt::RoundJoin);
    painter.setPen(pen);
    painter.drawLine(fromPoint,toPoint);

    imageContainer->setEditableImage( newImage );

    emit screenshotUpdated(newImage);
}

void FreeFormSnippingArea::insertPoint(QPoint point)
{
    polygons_m << point;
}
