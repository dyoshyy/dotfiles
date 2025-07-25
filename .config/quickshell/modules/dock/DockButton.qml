import "root:/"
import "root:/modules/common"
import "root:/modules/common/widgets"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RippleButton {
    Layout.fillHeight: true
    Layout.topMargin: Appearance.sizes.elevationMargin - Appearance.sizes.hyprlandGapsOut
    implicitWidth: implicitHeight - topInset - bottomInset
    implicitHeight: 60 // Set minimum height for dock buttons
    buttonRadius: Appearance.rounding.normal

    topInset: Appearance.sizes.hyprlandGapsOut + dockRow.padding
    bottomInset: Appearance.sizes.hyprlandGapsOut + dockRow.padding
}
