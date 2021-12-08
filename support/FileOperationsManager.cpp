#include "FileOperationsManager.h"
#include "ImagesContainer.h"

#include <QGuiApplication>
#include <QClipboard>
#include <QFileInfo>
#include <QDir>

void FileOperationsManager::copyToClipboard()
{
    QGuiApplication::clipboard()->setImage( ImagesContainer::instance()->getOriginalImage() );
}

void FileOperationsManager::saveFile( QString filePath )
{
    QFileInfo fileInfo{ filePath };
    QDir().mkpath( fileInfo.dir().path() );

    ImagesContainer::instance()->getOriginalImage().save( filePath );
}
