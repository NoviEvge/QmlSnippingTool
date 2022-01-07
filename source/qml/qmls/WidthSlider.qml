import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

RowLayout {
    id: control;

    function updateCurrentWidth( width ) {
        widthValue.text = width;
    }

    signal widthChanged( int width );

    property int from: 1;
    property int to: 100;

    Slider {
        id: widthSlider;
        Layout.fillWidth:  true;

        from: control.from;
        to:   control.to;
        stepSize: 1;

        onPositionChanged: widthValue.text = widthSlider.value;
    }

    TextField {
        id: widthValue;
        implicitWidth: 30;

        text:"0";

        validator: IntValidator {
            bottom: control.from;
            top:    control.to;
        }

        onTextChanged: {
            widthSlider.value = widthValue.text;
            control.widthChanged( text );
        }
    }
}
