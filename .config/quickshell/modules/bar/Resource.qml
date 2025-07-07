import "root:/modules/common"
import "root:/modules/common/widgets"
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Io

Item {
    required property string iconName
    required property double percentage
    property bool shown: true
    clip: true
    visible: width > 0 && height > 0
    implicitWidth: resourceRowLayout.x < 0 ? 0 : childrenRect.width
    implicitHeight: childrenRect.height

    RowLayout {
        spacing: 4
        id: resourceRowLayout
        x: shown ? 0 : -resourceRowLayout.width

        CircularProgress {
            Layout.alignment: Qt.AlignVCenter
            lineWidth: 3
            value: percentage
            size: 30
            secondaryColor: Qt.rgba(1, 1, 1, 0.1)
            primaryColor: {
                // アイコン名に基づいて色を変更（CPUかメモリか）
                if (iconName.includes("cpu") || iconName.includes("processor")) {
                    return "#2196F3"  // 青色 (CPU)
                } else if (iconName.includes("memory") || iconName.includes("ram")) {
                    return "#9C27B0"  // 紫色 (メモリ)
                } else {
                    return "#4CAF50"  // 緑色 (その他)
                }
            }

            // グラデーション効果のための追加のプロパティ
            Rectangle {
                anchors.fill: parent
                radius: parent.size / 2
                color: "transparent"
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.2)
            }

            MaterialSymbol {
                anchors.centerIn: parent
                fill: 1
                text: iconName
                iconSize: Appearance.font.pixelSize.normal
                color: parent.primaryColor
            }

        }

        StyledText {
            Layout.alignment: Qt.AlignVCenter
            color: Appearance.colors.colOnLayer1
            text: `${Math.round(percentage * 100)}`
        }

        Behavior on x {
            animation: Appearance.animation.elementMove.numberAnimation.createObject(this)
        }

    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: Appearance.animation.elementMove.duration
            easing.type: Appearance.animation.elementMove.type
            easing.bezierCurve: Appearance.animation.elementMove.bezierCurve
        }
    }
}
