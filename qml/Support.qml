import QtQuick

Item {
    function createWindow( qmlFileName, position = {} ) {
        var component = Qt.createComponent( qmlFileName );
        return component.createObject( parent, position );
    }

    Timer {
        id: timer
    }

    function delay( delayTime, cb ) {
        timer.interval = delayTime
        timer.repeat = false
        timer.triggered.disconnect( cb )
        timer.triggered.connect( cb )
        timer.start()
    }

    function scaleFactor() {
        var pixelRatio = Screen.devicePixelRatio;
        return ( pixelRatio < 1 ) ? pixelRatio : ( 1 / pixelRatio );
    }

    function getScaledValue( value ) {
        return ( value * scaleFactor() );
    }

    Scale {
        id: transformScale;
        xScale: scaleFactor();
        yScale: scaleFactor();
    }

    function getTransformScale() {
        return transformScale;
    }

    function isWindowsOS() {
        return ( "windows" === Qt.platform.os );
    }

    function getCorrectFolderPath( path ) {
        if( isWindowsOS() )
            return path.replace( /^(file:\/{3})/, "" );
        else
            return path.replace( /^(file:\/{2})/, "" );
    }

    function getWritablePath( path ) {
        return StandardPaths.writableLocation(path);
    }
}
