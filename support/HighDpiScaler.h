#ifndef HighDPIScaler_H
#define HighDPIScaler_H

#include <QRect>

class HighDPIScaler
{
public:
    QRect scale(const QRect &rect) const;
    QRect unscale(const QRect &rect) const;
    qreal scaleFactor() const;
};

#endif // HighDPIScaler_H
