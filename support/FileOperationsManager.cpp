#include "FileOperationsManager.h"
#include "support/ImagesContainer.h"

#include <QGuiApplication>
#include <QClipboard>

void FileOperationsManager::copyToClipboard()
{
    QGuiApplication::clipboard()->setImage( ImagesContainer::instance()->getOriginalImage() );
}

void FileOperationsManager::saveFile(QString filePath)
{
    ImagesContainer::instance()->getOriginalImage().save(filePath);
}
