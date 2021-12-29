import QtQuick

Grid {
    id: control;
    rows: 5
    columns: 5
    spacing: 15;

    property int currentIndex: 0;

    signal colorChanged( color color );

    property var model: [ "#FFFFFF", "#C0C0C0", "#808080", "#778899", "#000000",
                          "#FFFF00", "#FFA500", "#FF4500", "#FF0000", "#8B0000",
                          "#87CEFA", "#00BFFF", "#6495ED", "#0000FF", "#00008B",
                          "#7CFC00", "#00FA9A", "#32CD32", "#008000", "#006400",
                          "#EE82EE", "#BA55D3", "#FF00FF", "#9400D3", "#800080" ];

    function updateCurrentColor( color ) {
        for( var index = 0; index < repeater.count; ++index ) {
            if( Qt.colorEqual( control.model[ index ], color ) ) {
                updateCurrentState( index );
                break;
            }
        }
    }

    function updateCurrentState( index ) {
        repeater.itemAt( currentIndex ).state = "";
        repeater.itemAt( index ).state = "current";

        currentIndex = index;

        colorChanged( getCurrentColor() );
    }

    function getCurrentColor() {
        return model[ currentIndex ];
    }

    Repeater {
        id: repeater;
        model: control.model;

        ExtendedRoundButton{
            id: button;
            property int elementIndex: index;
            color: control.model[ index ];

            states: [
                State {
                    name: "current";
                    PropertyChanges {
                        target: button;
                        icon.source: "qrc:/images/plus.svg";
                        icon.color: support.hexColorIsLight( button.color ) ? "black" : "white";
                    }
                }
            ]

            onClicked: updateCurrentState( elementIndex );
        }
    }
}
