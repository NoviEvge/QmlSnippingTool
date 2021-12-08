#ifndef QMLMouseEventHandler_H
#define QMLMouseEventHandler_H

#include <QObject>
#include <QPoint>
#include <qevent.h>

class QQmlEngine;
class QJSEngine;

class MouseEventHandler : public QObject
{
Q_OBJECT

public:
   static QObject *singletoneInstance( QQmlEngine*, QJSEngine* );
   static MouseEventHandler* instance();

protected:
   bool eventFilter( QObject* sender, QEvent* event );

signals:
   void mouseEvent( QPoint cursorPosition, QEvent::Type eventType );

private:
   bool isMouseEventAllowed( const QMouseEvent* event );

private:
   QEvent::Type lastEventType_m;
   QPoint lastMouseMovePoint_m;
};

#endif // QMLMouseEventHandler_H
