#ifndef FILEOPERATIONSMANAGER_H
#define FILEOPERATIONSMANAGER_H

#include <QObject>

class FileOperationsManager : public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE void copyToClipboard();
    Q_INVOKABLE void saveFile( QString filePath );
};

#endif // FILEOPERATIONSMANAGER_H
