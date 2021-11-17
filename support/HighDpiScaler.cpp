#include "HighDpiScaler.h"

#include <QGuiApplication>
#include <QScreen>

QRect HighDPIScaler::scale(const QRect &rect) const
{
    auto factor = scaleFactor();
    return {
             static_cast<int>(rect.x() * factor),
             static_cast<int>(rect.y() * factor),
             static_cast<int>(rect.width() * factor),
             static_cast<int>(rect.height() * factor)
    };
}

QRect HighDPIScaler::unscale(const QRect &rect) const
{
    auto factor = scaleFactor();
    return {
             static_cast<int>(rect.x() / factor),
             static_cast<int>(rect.y() / factor),
             static_cast<int>(rect.width() / factor),
             static_cast<int>(rect.height() / factor)
    };
}

qreal HighDPIScaler::scaleFactor() const
{
    return QGuiApplication::primaryScreen()->devicePixelRatio();
}
