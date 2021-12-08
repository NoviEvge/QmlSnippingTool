#include "CaptureMode.h"

void CaptureMode::changeMode( CaptureModes mode )
{
    emit captureModeChanged( mode );
}
