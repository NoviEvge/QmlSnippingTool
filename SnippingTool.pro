QT += quick

CONFIG += c++20

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        captureMode/CaptureMode.cpp \
        snippingAreas/BaseSnippingArea.cpp \
        snippingAreas/FreeFormSnippingArea.cpp \
        snippingAreas/FullscreenSnippingArea.cpp \
        snippingAreas/RectangleSnippingArea.cpp \
        ImageProvider.cpp \
        main.cpp \
        SnippingTool.cpp \
        support/FileOperationsManager.cpp \
        support/ImagesContainer.cpp \
        support/HighDpiScaler.cpp \
        support/MouseEventHandler.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    captureMode/CaptureMode.h \
    snippingAreas/BaseSnippingArea.h \
    snippingAreas/FreeFormSnippingArea.h \
    snippingAreas/FullscreenSnippingArea.h \
    snippingAreas/RectangleSnippingArea.h \
    ImageProvider.h \
    SnippingTool.h \
    support/FileOperationsManager.h \
    support/ImagesContainer.h \
    support/HighDpiScaler.h \
    support/MouseEventHandler.h

DISTFILES +=

