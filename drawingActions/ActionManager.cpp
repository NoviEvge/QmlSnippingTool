#include "ActionManager.h"
#include "ImageProvider.h"
#include "PenAction.h"
#include "HighlighterAction.h"

ActionManager::ActionManager()
{
    auto imageProvider = ImageProvider::instance();

    QObject::connect( this,
                      &ActionManager::imageUpdated,
                      imageProvider,
                      &ImageProvider::imageUpdated );

    QObject::connect( this,
                      &ActionManager::finished,
                      imageProvider,
                      &ImageProvider::finished );
}

void ActionManager::setActionConnects( QSharedPointer< BaseAction > action )
{
    if( !action )
        return;

    QObject::connect( this,
                      &ActionManager::mouseReleaseToInternal,
                      action.data(),
                      &BaseAction::mouseRelease );

    QObject::connect( this,
                      &ActionManager::mousePressToInternal,
                      action.data(),
                      &BaseAction::mousePress );

    QObject::connect( this,
                      &ActionManager::mouseMove,
                      action.data(),
                      &BaseAction::mouseMove );

    QObject::connect( action.data(),
                      &BaseAction::imageUpdated,
                      ImageProvider::instance(),
                      &ImageProvider::imageUpdated );
}

void ActionManager::disconnectAction( QSharedPointer< BaseAction > action )
{
    if( !action )
        return;

    QObject::disconnect( this,
                         &ActionManager::mouseReleaseToInternal,
                         action.data(),
                         &BaseAction::mouseRelease );

    QObject::disconnect( this,
                         &ActionManager::mousePressToInternal,
                         action.data(),
                         &BaseAction::mousePress );

    QObject::disconnect( this,
                         &ActionManager::mouseMove,
                         action.data(),
                         &BaseAction::mouseMove );

    QObject::disconnect( action.data(),
                         &BaseAction::imageUpdated,
                         ImageProvider::instance(),
                         &ImageProvider::imageUpdated );
}

void ActionManager::reset()
{
    actionStack_m.clear();
    undoRedoActionStack_m.clear();
}

void ActionManager::mousePress( ActionType type, QPoint point, QColor color, int width )
{
    if( type == ActionType::None )
        return;

    undoRedoActionStack_m.clear();

    QImage image;
    if ( actionStack_m.empty() )
        image = ImageProvider::instance()->getOriginalImage();
    else
        image = actionStack_m.top()->getImage();

    QSharedPointer< BaseAction > action;
    if( type == ActionType::Pen )
        action.reset( new PenAction( image, color, width ) );
    else if( type == ActionType::Highlighter )
        action.reset( new HighlighterAction( image, color, width ) );

    setActionConnects( action );
    actionStack_m.emplaceBack( action );

    emit mousePressToInternal( point );
}

void ActionManager::mouseRelease( QPoint point )
{
    if( !actionStack_m.empty() )
    {
        emit mouseReleaseToInternal( point );
        emit finished( FinishStatus::Normal );
        disconnectAction( actionStack_m.top() );
    }
}

void ActionManager::undoLastAction()
{
    if( actionStack_m.empty() )
        return;

    undoRedoActionStack_m.emplaceBack( actionStack_m.pop() );

    emit imageUpdated( actionStack_m.empty() ? ImageProvider::instance()->getOriginalImage() : actionStack_m.top()->getImage(), ImageState::DrawingFinal );
    emit finished( FinishStatus::Normal );
}

void ActionManager::redoLastAction()
{
    if( undoRedoActionStack_m.empty() )
        return;

    auto action = undoRedoActionStack_m.pop();

    actionStack_m.emplaceBack( action );

    emit imageUpdated( action->getImage(), ImageState::DrawingFinal );
    emit finished( FinishStatus::Normal );
}

bool ActionManager::isUndoActions() const
{
    return !actionStack_m.empty();
}

bool ActionManager::isRedoActions() const
{
    return !undoRedoActionStack_m.empty();
}
