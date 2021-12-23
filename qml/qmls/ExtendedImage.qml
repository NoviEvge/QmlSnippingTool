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
    property int onPressCreationType: 2;     // 0 == None

    MouseArea {
        anchors.fill: parent;
        acceptedButtons: Qt.LeftButton;
        preventStealing: true;

        onPositionChanged: sendMouseEventSignalCaller.mouseMove( Qt.point( mouseX, mouseY ) );
        onPressed: sendMouseEventSignalCaller.mousePress( onPressCreationType, Qt.point( mouseX,  mouseY ), "yellow", 15 );// onPressCreationColorFunc(), onPressCreationWidthFunc() );
        onReleased: sendMouseEventSignalCaller.mouseRelease( Qt.point( mouseX, mouseY ) );
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

    Support {
        id: support;
    }
}
