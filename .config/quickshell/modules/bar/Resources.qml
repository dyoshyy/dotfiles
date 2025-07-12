import "root:/modules/common"
import "root:/modules/common/widgets"
import "root:/services"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris

Item {
    id: root
    property bool borderless: Config.options.bar.borderless
    property bool alwaysShowAllResources: false
    implicitWidth: rowLayout.implicitWidth + rowLayout.anchors.leftMargin + rowLayout.anchors.rightMargin
    implicitHeight: 28

    RowLayout {
        id: rowLayout

        spacing: 6
        anchors.fill: parent
        anchors.leftMargin: 6
        anchors.rightMargin: 6

        // CPU リソース
        Resource {
            iconName: "settings_slow_motion"
            percentage: ResourceUsage.cpuUsage
            resourceName: "CPU"
            shown: Config.options.bar.resources.alwaysShowCpu || 
                !(MprisController.activePlayer?.trackTitle?.length > 0) ||
                root.alwaysShowAllResources
        }

        // GPU リソース
        Resource {
            iconName: "developer_board"
            percentage: ResourceUsage.gpuUsage
            resourceName: "GPU"
            shown: ResourceUsage.gpuUsage > 0 || root.alwaysShowAllResources
        }

        // メモリリソース
        Resource {
            iconName: "memory"
            percentage: ResourceUsage.memoryUsedPercentage
            resourceName: "RAM"
        }

        // スワップリソース
        Resource {
            iconName: "swap_horiz"
            percentage: ResourceUsage.swapUsedPercentage
            resourceName: "SWAP"
            shown: (Config.options.bar.resources.alwaysShowSwap && percentage > 0) || 
                (MprisController.activePlayer?.trackTitle == null) ||
                root.alwaysShowAllResources
        }

    }

}
