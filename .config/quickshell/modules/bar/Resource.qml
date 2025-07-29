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
    property string resourceName: ""
    clip: true
    visible: width > 0 && height > 0
    implicitWidth: resourceRowLayout.x < 0 ? 0 : childrenRect.width
    implicitHeight: childrenRect.height

    RowLayout {
        spacing: 3
        id: resourceRowLayout
        x: shown ? 0 : -resourceRowLayout.width

        // テキスト情報部分
        Column {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: 35  // より小さい固定幅
            spacing: 1
            
            // リソース名
            StyledText {
                color: Appearance.colors.colOnLayer1
                text: resourceName
                font.pixelSize: Appearance.font.pixelSize.smaller
                font.weight: Font.Medium
            }
            
            // パーセンテージ
            StyledText {
                color: Appearance.colors.colOnLayer1
                text: `${Math.round(percentage * 100)}%`
                font.pixelSize: Appearance.font.pixelSize.smaller
                font.weight: Font.Bold
            }
        }

        // 横向きのゲージバー
        Rectangle {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: 30  // より小さい固定幅
            width: 30
            height: 4
            radius: 2
            color: Qt.rgba(1, 1, 1, 0.1)
            
            Rectangle {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width * percentage
                height: parent.height
                radius: parent.radius
                color: {
                    if (iconName.includes("cpu") || iconName.includes("processor") || iconName.includes("settings_slow_motion")) {
                        return "#2196F3"  // 青色 (CPU)
                    } else if (iconName.includes("memory") || iconName.includes("ram")) {
                        return "#9C27B0"  // 紫色 (メモリ)
                    } else if (iconName.includes("developer_board") || iconName.includes("gpu")) {
                        return "#FF9800"  // オレンジ色 (GPU)
                    } else {
                        return "#4CAF50"  // 緑色 (その他)
                    }
                }
                
                Behavior on width {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutQuad
                    }
                }
            }
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
