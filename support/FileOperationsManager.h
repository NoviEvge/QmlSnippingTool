#pragma once

#include <QObject>

namespace utility::fileOperations {

class FileOperationsManager : public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE void copyToClipboard();
    Q_INVOKABLE void saveFile( QString filePath );
};

} // utility::fileOperations
