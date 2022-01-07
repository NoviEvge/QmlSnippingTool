import QtQuick
import Qt.labs.platform

Item {
    function createWindow( qmlFileName ) {
        var component = Qt.createComponent( qmlFileName );

        if( component.status != Component.Ready )
        {
            if( component.status == Component.Error )
                console.debug( "Error: " + component.errorString() );

            return;
        }

        return component.createObject( parent );
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
        return StandardPaths.writableLocation( path );
    }

    function copyImageToClipboard() {
        FileOperations.copyToClipboard();
    }

    function saveFile( path ) {
        FileOperations.saveFile( path );
    }

    function hexColorIsLight( color ) {
        var hex = color.toString().replace('#', '');
        var c_r = parseInt( hex.substr( 0, 2 ), 16 );
        var c_g = parseInt( hex.substr( 2, 2 ), 16 );
        var c_b = parseInt( hex.substr( 4, 2 ), 16 );
        var brightness = ( ( c_r * 299 ) + ( c_g * 587 ) + ( c_b * 114 ) ) / 1000;

        return brightness > 140;
    }
}
