#pragma once

#include "IMouseEvents.h"
#include "ImageProviderEnum.h"

#include <QImage>
#include <QPoint>

class BaseAction : public IMouseEvents
{
    Q_OBJECT

public:
    BaseAction( QImage image, QColor color, qreal width );

    QImage getImage() const;

protected:
    QColor getColor() const;
    qreal  getWidth() const;

signals:
    void imageUpdated( QImage image, ImageState state );
    void finished( FinishStatus status );

protected:
    QImage image_m;

private:
    QColor color_m;
    qreal  width_m;
};
