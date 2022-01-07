#include "HighDpi.h"

#include <QGuiApplication>
#include <QScreen>

namespace utility::highDPI {

QRect scale( const QRect& rect )
{
    auto factor = scaleFactor();
    return {
             static_cast< int >( rect.x() * factor ),
             static_cast< int >( rect.y() * factor ),
             static_cast< int >( rect.width() * factor ),
             static_cast< int >( rect.height() * factor )
    };
}

QPoint scale( const QPoint& point )
{
    auto factor = scaleFactor();
    return {
             static_cast< int >( point.x() * factor ),
             static_cast< int >( point.y() * factor ),
    };
}

QRect unscale( const QRect& rect )
{
    auto factor = unscaleFactor();
    return {
             static_cast< int >( rect.x() * factor ),
             static_cast< int >( rect.y() * factor ),
             static_cast< int >( rect.width()  * factor ),
             static_cast< int >( rect.height() * factor )
    };
}

QPoint unscale( const QPoint& point )
{
    auto factor = unscaleFactor();
    return {
             static_cast< int >( point.x() * factor ),
             static_cast< int >( point.y() * factor )
    };
}

qreal scaleFactor()
{
    return QGuiApplication::primaryScreen()->devicePixelRatio();
}

qreal unscaleFactor()
{
    qreal factor = scaleFactor();
    return ( factor < 1 ) ? factor : ( 1 / factor );
}

} // utility::highDPI
