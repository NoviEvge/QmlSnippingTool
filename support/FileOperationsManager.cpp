#include "FileOperationsManager.h"
#include "ImageProvider.h"
#include <QGuiApplication>
#include <QClipboard>
#include <QFileInfo>
#include <QDir>

namespace utility::fileOperations {

void FileOperationsManager::copyToClipboard()
{
    QGuiApplication::clipboard()->setImage( ImageProvider::instance()->getCurrentImage() );
}

void FileOperationsManager::saveFile( QString filePath )
{
    QFileInfo fileInfo{ filePath };
    QDir().mkpath( fileInfo.dir().path() );

    qDebug() <<ImageProvider::instance()->getCurrentImage();
    ImageProvider::instance()->getCurrentImage().save( filePath );
}

} // utility::fileOperations
