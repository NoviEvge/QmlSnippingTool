import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Button {
    id: control;

    width:  30;
    height: 30;

    property color color: "grey";

    property bool shadowed: true;

    background: Rectangle {
        anchors.fill : parent;
        radius: height / 2;

        property color backgroundDefaultColor: control.color;
        property color backgroundPressedColor: getChangedColor( 1.2, 1.4, "#494b4c" );
        property color backgroundHoveredColor: getChangedColor( 1.1, 1.3, "#2f3233" );

        function getChangedColor( darkerValue, lighterValue, instedOfBlack ) {
            if( Qt.colorEqual( backgroundDefaultColor, "#000000" ) )
                return instedOfBlack;
            else if( support.hexColorIsLight( backgroundDefaultColor ) )
                return Qt.darker( backgroundDefaultColor, darkerValue );
            else
                return Qt.lighter( backgroundDefaultColor, lighterValue );
        }

        color: control.down ? backgroundPressedColor : ( control.hovered ? backgroundHoveredColor : backgroundDefaultColor );

        layer.enabled: control.enabled && shadowed;
        layer.effect: DropShadow {
            transparentBorder: true;
            horizontalOffset: 3;
            verticalOffset:   3;
            radius: height / 2;
            color: "grey";
        }
    }
}
