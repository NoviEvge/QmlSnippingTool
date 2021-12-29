#pragma once

#include <QObject>

class SnippingAreaEnum
{
    Q_GADGET

public:
    SnippingAreaEnum() = delete;

    enum CaptureMode {
        None = 0,
        Rectangle,
        FreeForm,
        FullScreen // only for qml
    };

    Q_ENUM(CaptureMode)
};

using CaptureMode = SnippingAreaEnum::CaptureMode;
