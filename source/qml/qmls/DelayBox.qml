import QtQuick.Controls.Material
import qt.ActionTypesEnum

ComboBox {
    flat: Constants.isFlatElements;
    hoverEnabled: Constants.isHoverable;

    displayText: "Delay: " + currentIndex;
    model: [ 0, 1, 2, 3, 4, 5 ];
}
