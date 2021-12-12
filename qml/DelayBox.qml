import QtQuick.Controls
import QtQuick.Controls.Material

ComboBox {
    displayText: "Delay: " + currentIndex;
    model: [ 0, 1, 2, 3, 4, 5 ];
}
