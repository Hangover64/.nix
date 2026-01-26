import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

ShellRoot {
    // Top Bar
    PanelWindow {
	    id: bar
        
        anchors {
            top: true
            left: true
            right: true
        }
        
        height: 80
        
        Rectangle {
            anchors.fill: parent
            color: "#1e1e2e"
            
            // Workspaces
            RowLayout {
                id: workspaces
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
                spacing: 5
                
                Repeater {
                    model: 10
                    
                    Rectangle {
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 30
                        radius: 8
                        color: index === 0 ? "#cba6f7" : "#313244"
                        
                        scale: mouseArea.containsMouse ? 1.2 : 1.0
                        
                        Behavior on scale {
                            NumberAnimation {
                                duration: 200
                                easing.type: Easing.OutBack
                            }
                        }
                        
                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                        
                        Text {
                            anchors.centerIn: parent
                            text: index + 1
                            color: "#cdd6f4"
                            font.bold: true
                        }
                        
                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            
                            onClicked: {
                                Quickshell.Process.run("hyprctl", 
                                    ["dispatch", "workspace", (index + 1).toString()])
                            }
                        }
                    }
                }
            }
            
            // Clock
            Rectangle {
                id: clock
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10
                width: 200
                height: 60
                radius: 8
                color: "#313244"
                
                scale: clockMouse.containsMouse ? 1.1 : 1.0
                
                Behavior on scale {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutElastic
                    }
                }
                
                Text {
                    id: clockText
                    anchors.centerIn: parent
                    text: Qt.formatTime(new Date(), "HH:mm")
                    color: "#cdd6f4"
                    font.pixelSize: 14
                }
                
                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: clockText.text = Qt.formatTime(new Date(), "HH:mm")
                }
                
                MouseArea {
                    id: clockMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
    
    // Dock - zentriert mit x-Berechnung
    PanelWindow {
	    id: dock
        
        anchors {
            bottom: true
            left: true
            right: true
        }
        
        height: 180
        
        Rectangle {
            id: dockContainer
            anchors.centerIn: parent
            width: dockLayout.width + 40
            height: 140
            color: "#1e1e2e"
            radius: 32
            
            RowLayout {
                id: dockLayout
                anchors.centerIn: parent
                spacing: 10
                
                Repeater {
                    model: ["🦊", "💻", "📝", "🎵"]
                    
                    Rectangle {
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50
                        radius: 10
                        color: "#313244"
                        
                        scale: dockMouse.containsMouse ? 1.5 : 1.0
                        y: dockMouse.containsMouse ? -10 : 0
                        
                        Behavior on scale {
                            NumberAnimation {
                                duration: 300
                                easing.type: Easing.OutBack
                            }
                        }
                        
                        Behavior on y {
                            NumberAnimation {
                                duration: 300
                                easing.type: Easing.OutBack
                            }
                        }
                        
                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            font.pixelSize: 24
                        }
                        
                        MouseArea {
                            id: dockMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            
                            onClicked: {
                                var apps = ["firefox", "alacritty", "code", "spotify"]
                                Quickshell.Process.run(apps[index], [])
                            }
                        }
                    }
                }
            }
        }
    }
}
