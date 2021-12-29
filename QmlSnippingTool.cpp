#include "QmlSnippingTool.h"

QmlSnippingTool::QmlSnippingTool()
{
    actionManager_m.reset( new ActionManager() );
    snippingAreaManager_m.reset( new SnippingAreaManager() );
}

QSharedPointer< ActionManager > QmlSnippingTool::actionManager() const
{
    return actionManager_m;
}

QSharedPointer< SnippingAreaManager > QmlSnippingTool::snippingAreaManager() const
{
    return snippingAreaManager_m;
}
