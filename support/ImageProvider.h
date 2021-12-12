#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QImage>
#include <QQuickImageProvider>

class ImageProvider : public QQuickImageProvider
{
    Q_OBJECT

public:
    ImageProvider();
    QImage requestImage( const QString& id, QSize* size, const QSize& requestedSize ) override;
    Q_INVOKABLE void clear();

    virtual ~ImageProvider() override = default;
signals:
    void newFrameReady();
    void screenshotCreated();
    void screenshotFinished();
    void forceFinish();
    void finished();

private:
    QImage takeScreenshot();

public slots:
    void screenshotUpdated( QImage image );

private:
    QImage image_m;
};

#endif // IMAGEPROVIDER_H
