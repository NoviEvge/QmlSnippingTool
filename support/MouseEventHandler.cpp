#include "MouseEventHandler.h"

#include <QGuiApplication>
#include <QMouseEvent>

QObject* MouseEventHandler::singletoneInstance( QQmlEngine*, QJSEngine* )
{
    auto object = instance();
    static bool isInited = false;
    if( !isInited )
    {
        QGuiApplication* app = qGuiApp;
        app->installEventFilter( object );
        isInited = true;
    }

    return object;
}

MouseEventHandler* MouseEventHandler::instance()
{
    static MouseEventHandler* object;
    if( !object )
        object = new MouseEventHandler();

    return object;
}

bool MouseEventHandler::eventFilter( QObject* sender, QEvent* event )
{
    QEvent::Type eventType = event->type();
    if( eventType == QEvent::MouseButtonPress   ||
        eventType == QEvent::MouseButtonRelease ||
        eventType == QEvent::MouseMove )
    {
        QMouseEvent* evt = static_cast< QMouseEvent* >( event );
        if( isMouseEventAllowed( evt ) )
            emit mouseEvent( evt->pos(), eventType );

        if( eventType == QEvent::MouseMove )
            lastMouseMovePoint_m = evt->pos();
        else
            lastEventType_m = eventType;
    }

    return QObject::eventFilter( sender, event );
}

bool MouseEventHandler::isMouseEventAllowed( const QMouseEvent* event )
{
    bool isAllowed = false;
    auto eventType = event->type();

    if( eventType == QEvent::MouseMove && lastEventType_m == QEvent::MouseButtonPress )
        isAllowed = ( lastMouseMovePoint_m != event->pos() );
    else if(eventType == QEvent::MouseButtonPress || eventType == QEvent::MouseButtonRelease )
        isAllowed = ( lastEventType_m != eventType );

    return isAllowed;
}
