import QtQuick 2.0
import QtQuick.Layouts
import QtQuick.Controls.Material

Popup {
    id: control;

    x: -width + parent.width / 2;
    y: parent.height - parent.height / 2;

    signal colorChanged( color color );
    signal widthChanged( int width );

    function updateCurrentColor( color ) {
        colorPalette.updateCurrentColor( color );
    }

    function updateCurrentWidth( width ) {
        widthSlider.updateCurrentWidth( width );
    }

    ColumnLayout
    {
        anchors.fill: parent;

        Label {
            Layout.alignment: Qt.AlignHCenter;
            font.pixelSize: Constants.fontPixelSize;
            text: "Color and Width";
        }

        ColorPalette {
            id: colorPalette;
            onColorChanged: ( color ) => control.colorChanged( color );
        }

        WidthSlider{
            id: widthSlider;
            onWidthChanged: ( width ) => control.widthChanged( width );
        }
    }
}
