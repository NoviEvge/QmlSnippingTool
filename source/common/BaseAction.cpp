#include "BaseAction.h"

BaseAction::BaseAction( QImage image, QColor color, qreal width ) : image_m{ image },
                                                                    color_m{ color },
                                                                    width_m{ width }
{
}

QImage BaseAction::getImage() const
{
    return image_m;
}

QColor BaseAction::getColor() const
{
    return color_m;
}

qreal BaseAction::getWidth() const
{
    return width_m;
}
