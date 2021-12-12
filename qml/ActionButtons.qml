import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

RowLayout {
    spacing: Constants.marginSize;

    Button {
        visible: snippedImage.enabled;
        Material.background: "white";
        onClicked: fileDialog.open();
        icon.source: "qrc:/qml/images/save.svg";
        ToolTip.visible: hovered;
        ToolTip.text: "Save screenshot( Ctrl+S )";
    }

    Button {
        visible: snippedImage.enabled;
        Material.background: "white";
        onClicked: FileOperations.copyToClipboard();
        icon.source: "qrc:/qml/images/clipboard.svg";
        ToolTip.visible: hovered;
        ToolTip.text: "Copy to clipboard( Ctrl+C )";
    }

    Button {
        visible: snippedImage.enabled;
        Material.background: "white";
        onClicked: snippedImage.clearImage();
        icon.source: "qrc:/qml/images/reset.svg";
        ToolTip.visible: hovered;
        ToolTip.text: "Remove screenshot( Del, Ctrl+D )";
    }

    Button {
        Material.background: "white";
        onClicked: support.createWindow( "qrc:/qml/SettingsWindow.qml" ).show();
        icon.source: "qrc:/qml/images/settings.svg";
        ToolTip.visible: hovered;
        ToolTip.text: "Settings ( Ctrl+P )";
    }

    SaveFileDialog {
        id: fileDialog;
    }

    Support {
        id: support;
    }
}
