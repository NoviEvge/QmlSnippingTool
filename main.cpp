#include "QmlSnippingTool.h"
#include "ImageProvider.h"
#include "FileOperationsManager.h"
#include "SnippingAreaEnum.h"
#include "ActionTypesEnum.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "QQmlContext"

int main( int argc, char *argv[] )
{
    QGuiApplication app( argc, argv );

    app.setOrganizationName( "QmlSnippingTool" );
    app.setApplicationName(  "QmlSnippingTool" );

    qmlRegisterUncreatableType< ImageProviderEnum >( "qt.ImageProviderEnum", 1, 0, "ImageProviderEnum", "Not creatable as it is an enum type" );
    qmlRegisterUncreatableType< ActionTypesEnum   >( "qt.ActionTypesEnum",   1, 0, "ActionTypesEnum",   "Not creatable as it is an enum type" );
    qmlRegisterUncreatableType< SnippingAreaEnum  >( "qt.SnippingAreaEnum",  1, 0, "SnippingAreaEnum",  "Not creatable as it is an enum type" );

    QmlSnippingTool snippingTool;
    QQmlApplicationEngine engine;
    engine.addImageProvider( "ImageProvider", ImageProvider::instance() );

    QQmlContext* context = engine.rootContext();
    context->setContextProperty( "FileOperations", new utility::fileOperations::FileOperationsManager() );
    context->setContextProperty( "ImageProvider", ImageProvider::instance() );
    context->setContextProperty( "ActionManager", snippingTool.actionManager().data() );
    context->setContextProperty( "SnippingAreaManager", snippingTool.snippingAreaManager().data() );

    engine.load( "qrc:/qmls/main.qml" );

    return app.exec();
}
