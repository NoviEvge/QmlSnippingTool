#ifndef CAPTUREMODE_H
#define CAPTUREMODE_H

#include <QObject>

enum class CaptureModes
{
    eRectangle,
    eFreeForm,
    eFullScreen,
    eNone
};

class CaptureMode : public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE void changeMode( CaptureModes mode );

signals:
    void captureModeChanged( CaptureModes mode );
};

#endif // CAPTUREMODE_H
