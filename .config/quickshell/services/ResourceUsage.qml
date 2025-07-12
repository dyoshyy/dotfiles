pragma Singleton
pragma ComponentBehavior: Bound

import "root:/modules/common"
import QtQuick
import Quickshell
import Quickshell.Io

/**
 * Simple polled resource usage service with RAM, Swap, and CPU usage.
 */
Singleton {
	property double memoryTotal: 1
	property double memoryFree: 1
	property double memoryUsed: memoryTotal - memoryFree
    property double memoryUsedPercentage: memoryUsed / memoryTotal
    property double swapTotal: 1
	property double swapFree: 1
	property double swapUsed: swapTotal - swapFree
    property double swapUsedPercentage: swapTotal > 0 ? (swapUsed / swapTotal) : 0
    property double cpuUsage: 0
    property var previousCpuStats
    property double gpuUsage: 0
    property double gpuMemoryUsage: 0

	Timer {
		interval: 1
        running: true 
        repeat: true
		onTriggered: {
            // Reload files
            fileMeminfo.reload()
            fileStat.reload()

            // Parse memory and swap usage
            const textMeminfo = fileMeminfo.text()
            memoryTotal = Number(textMeminfo.match(/MemTotal: *(\d+)/)?.[1] ?? 1)
            memoryFree = Number(textMeminfo.match(/MemAvailable: *(\d+)/)?.[1] ?? 0)
            swapTotal = Number(textMeminfo.match(/SwapTotal: *(\d+)/)?.[1] ?? 1)
            swapFree = Number(textMeminfo.match(/SwapFree: *(\d+)/)?.[1] ?? 0)

            // Parse CPU usage
            const textStat = fileStat.text()
            const cpuLine = textStat.match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/)
            if (cpuLine) {
                const stats = cpuLine.slice(1).map(Number)
                const total = stats.reduce((a, b) => a + b, 0)
                const idle = stats[3]

                if (previousCpuStats) {
                    const totalDiff = total - previousCpuStats.total
                    const idleDiff = idle - previousCpuStats.idle
                    cpuUsage = totalDiff > 0 ? (1 - idleDiff / totalDiff) : 0
                }

                previousCpuStats = { total, idle }
            }
            
            // GPU使用率の取得（nvidia-smi コマンドを使用）
            gpuProcessNvidia.running = true
            
            interval = Config.options?.resources?.updateInterval ?? 3000
        }
	}

	FileView { id: fileMeminfo; path: "/proc/meminfo" }
    FileView { id: fileStat; path: "/proc/stat" }
    
    // GPU使用率を取得するためのプロセス
    Process {
        id: gpuProcessNvidia
        command: ["nvidia-smi", "--query-gpu=utilization.gpu,memory.used,memory.total", "--format=csv,noheader,nounits"]
        
        stdout: SplitParser {
            onRead: data => {
                const lines = data.trim().split('\n')
                if (lines.length > 0) {
                    const values = lines[0].split(',').map(s => s.trim())
                    if (values.length >= 3) {
                        gpuUsage = Number(values[0]) / 100.0
                        const memUsed = Number(values[1])
                        const memTotal = Number(values[2])
                        gpuMemoryUsage = memTotal > 0 ? memUsed / memTotal : 0
                    }
                }
            }
        }
        
        stderr: SplitParser {
            onRead: data => {
                // NVIDIA GPU が見つからない場合は AMD GPU を試す
                if (data.includes("No devices")) {
                    gpuProcessAmd.running = true
                }
            }
        }
    }
    
    // AMD GPU用のプロセス
    Process {
        id: gpuProcessAmd
        command: ["radeontop", "-d", "-l", "1"]
        
        stdout: SplitParser {
            onRead: data => {
                const match = data.match(/gpu\s+(\d+\.?\d*)%/)
                if (match) {
                    gpuUsage = Number(match[1]) / 100.0
                }
            }
        }
    }
}
