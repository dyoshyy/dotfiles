import "root:/modules/common"
import "root:/modules/common/widgets"
import "root:/modules/common/functions/file_utils.js" as FileUtils
import "root:/services"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
    id: weather
    implicitWidth: content.implicitWidth
    implicitHeight: 32

    property string icon: ""
    property string temp: "--"

    Process {
        id: weatherShell
        // このスクリプトは Timer によって定期的に実行されます
        command: ["bash", FileUtils.trimFileProtocol(`${Directories.config}/quickshell/scripts/get-weather.sh`)]

        onExited: exitCode => {
            console.log("Weather: Process exited with code:", exitCode)
        }

        onStarted: {
            console.log("Weather: Process started")
        }

        stdout: SplitParser {
            onRead: data => {
                console.log("Weather: Raw data received:", data)
                try {
                    // スクリプトからのJSON出力をパースします
                    var jsonData = JSON.parse(data.trim())
                    console.log("Weather: Parsed JSON:", JSON.stringify(jsonData))
                    weather.icon = jsonData.icon || "?"
                    weather.temp = jsonData.temp || "--"
                    console.log("Weather: Updated - icon:", weather.icon, "temp:", weather.temp)
                } catch (e) {
                    console.log("Weather: Failed to parse JSON:", e, "Data:", data)
                }
            }
        }

        stderr: SplitParser {
            onRead: data => {
                console.log("Weather: Error output:", data)
            }
        }
    }

    // 15分（900,000ミリ秒）ごとに天気を更新します
    Timer {
        interval: 900000 
        running: true
        repeat: true
        onTriggered: {
            weatherShell.running = true
        }
    }

    // ウィジェットが最初に表示された時にも一度実行します
    Component.onCompleted: {
        console.log("Weather: Component completed, Directories.config:", Directories.config)
        console.log("Weather: Full command:", ["bash", FileUtils.trimFileProtocol(`${Directories.config}/quickshell/scripts/get-weather.sh`)])
        weatherShell.running = true
    }

    // 表示部分
    RowLayout {
        id: content
        anchors.centerIn: parent
        spacing: 4

        StyledText {
            text: weather.icon
            font.pixelSize: Appearance.font.pixelSize.large
        }
        StyledText {
            text: weather.temp + "°C"
            font.pixelSize: Appearance.font.pixelSize.medium
        }
    }
}
