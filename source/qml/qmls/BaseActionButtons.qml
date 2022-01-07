import QtQuick.Controls
import QtQuick.Layouts
import QtQml

RowLayout {
    spacing: Constants.marginSize;

    RowLayout {
        visible: snippedImage.enabled;
        spacing: Constants.marginSize;

        CustomWidthButton {
            onClicked: fileDialog.open();
            icon.source: "qrc:/images/save.svg";
            ToolTip.text: "Save As( Ctrl+S )";
            ToolTip.delay: Constants.tooltipDelay;
        }

        CustomWidthButton {
            onClicked: support.copyImageToClipboard();
            icon.source: "qrc:/images/clipboard.svg";
            ToolTip.text: "Copy to clipboard( Ctrl+C )";
            ToolTip.delay: Constants.tooltipDelay;
        }

        CustomWidthButton {
            onClicked: mainWindow.resetState();
            icon.source: "qrc:/images/reset.svg";
            ToolTip.text: "Remove( Del, Ctrl+D )";
            ToolTip.delay: Constants.tooltipDelay;
        }
    }

    CustomWidthButton {
        onClicked: support.createWindow( "qrc:/qmls/PreferencesWindow.qml" ).show();
        icon.source: "qrc:/images/settings.svg";
        ToolTip.text: "Settings( Ctrl+P )";
        ToolTip.delay: Constants.tooltipDelay;
    }

    SaveFileDialog {
        id: fileDialog;
    }

    Support {
        id: support;
    }
}
