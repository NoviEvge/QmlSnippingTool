#pragma once

#include <QObject>

enum ImageState {
    Template = 0,
    SnippingFinal,
    DrawingFinal
};

class ImageProviderEnum
{
    Q_GADGET

public:
    ImageProviderEnum() = delete;

    enum FinishStatus {
        Normal = 0,
        ForcedExit = 1
    };

    Q_ENUM(FinishStatus)
};

using FinishStatus = ImageProviderEnum::FinishStatus;
