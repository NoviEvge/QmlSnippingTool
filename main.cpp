#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "QQmlContext"

#include "QmlSnippingTool.h"
#include "support/MouseEventHandler.h"
#include "support/FileOperationsManager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setOrganizationName("QmlQmlSnippingTool");
    app.setApplicationName("QmlQmlSnippingTool");

    qmlRegisterSingletonType<MouseEventHandler>("MouseEventHandler", 1, 0, "MouseEventHandler", MouseEventHandler::singletoneInstance);
    qmlRegisterSingletonType(QUrl("qrc:/qml/Properties.qml"), "Properties", 1, 0, "Properties");
    QmlSnippingTool snippingTool;
    QQmlApplicationEngine engine;
    engine.addImageProvider( "ImageProvider", snippingTool.imageProvider() );

    QQmlContext* context = engine.rootContext();
    context->setContextProperty( "CaptureMode", snippingTool.captureMode() );
    context->setContextProperty( "ImageProvider", snippingTool.imageProvider());
    context->setContextProperty( "FileOperations", new FileOperationsManager());

    engine.load("qrc:/qml/main.qml");

    return app.exec();
}
