import QtQuick

Image {
    id: extendetImage;
    anchors.fill: parent;
    cache: false;

    onEnabledChanged: {
        if( !enabled ) {
            source = "";
            onPressCreationType = 0; // 0 == None
        }
    }

    property var sendMouseEventSignalCaller: undefined;
    property var onFinishedCallback:         undefined;
    property var onPressCreationColorFunc:   undefined;
    property var onPressCreationWidthFunc:   undefined;
    property int onPressCreationType: 0;    // 0 == None
    property bool actionsAllowed: true;

    MouseArea {
        anchors.fill: parent;
        acceptedButtons: Qt.LeftButton;
        preventStealing: true;

        onPositionChanged: {
            if( validate( "onPositionChanged" ) )
                sendMouseEventSignalCaller.mouseMove( Qt.point( mouseX, mouseY ) );
        }

        onPressed: {
            if( validate( "onPressed" ) )
                sendMouseEventSignalCaller.mousePress( onPressCreationType,
                                                      Qt.point( mouseX,  mouseY ),
                                                      onPressCreationColorFunc(),
                                                      onPressCreationWidthFunc() );
        }

        onReleased: {
            if( validate( "onReleased" ) )
                sendMouseEventSignalCaller.mouseRelease( Qt.point( mouseX, mouseY ) );
        }
    }

    Connections {
        target: ImageProvider
        enabled: extendetImage.enabled;

        function onFrameUpdated() {
            source = "";
            source = "image://ImageProvider/";
        }

        function onFinished( status ) {
            onFinishedCallback( status );
        }
    }

    function validate( objectName ) {
        if ( typeof sendMouseEventSignalCaller === 'undefined' ) {
            console.error( objectName + " is undefined" );

            return false;
        }

        return actionsAllowed;
    }
}
