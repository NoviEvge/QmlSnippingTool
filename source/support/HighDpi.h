#pragma once

#include <QRect>

namespace utility::highDPI {

    QRect scale(   const QRect &rect );
    QPoint scale(  const QPoint &point );
    QRect unscale( const QRect &rect );
    QPoint unscale( const QPoint& point );
    qreal scaleFactor();
    qreal unscaleFactor();

} // utility::highDPI::highDPI
