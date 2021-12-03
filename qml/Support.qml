import QtQuick

Item {
    function createWindow( qmlFileName, position = {} ) {
        var component = Qt.createComponent(qmlFileName);
        return component.createObject(parent, position );
    }

    Timer {
        id: timer
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime
        timer.repeat = false
        timer.triggered.disconnect(cb)
        timer.triggered.connect(cb)
        timer.start()
    }
}
