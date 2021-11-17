#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QImage>
#include <QQuickImageProvider>

class ImageProvider : public QQuickImageProvider
{
    Q_OBJECT

public:
    ImageProvider();
    QImage requestImage(const QString &id, QSize *size, const QSize&);

    Q_INVOKABLE void clear();

signals:
    void signalNewFrameReady();
    void screenshotCreated();
    void screenshotFinished();
    void forceFinish();

private:
    QImage takeScreenshot();

public slots:
    void screenshotUpdated(QImage image );

private:
    QImage image_m;
};

#endif // IMAGEPROVIDER_H
