import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

ShellRoot {
    Scope {
        // Animated Bar
        WaylandPanel {
            anchors {
                left: true
                right: true
                top: true
            }
            
            height: 40
            color: "#1e1e2e"
            
            // Smooth animations
            Behavior on height {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
            
            Rectangle {
                id: workspaces
                anchors.left: parent.left
                anchors.margins: 10
                width: childrenRect.width
                height: parent.height
                color: "transparent"
                
                RowLayout {
                    spacing: 5
                    
                    Repeater {
                        model: 10
                        
                        Rectangle {
                            width: 40
                            height: 30
                            radius: 8
                            color: index === 0 ? "#cba6f7" : "#313244"
                            
                            // Hover animation
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
                            
                            MouseArea {
                                id: mouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                
                                onClicked: {
                                    // Hyprland workspace switch
                                    Quickshell.Process.run("hyprctl", 
                                        ["dispatch", "workspace", (index + 1).toString()])
                                }
                            }
                            
                            Text {
                                anchors.centerIn: parent
                                text: index + 1
                                color: "#cdd6f4"
                                font.bold: true
                            }
                        }
                    }
                }
            }
            
            // Clock with sliding animation
            Rectangle {
                id: clock
                anchors.right: parent.right
                anchors.margins: 10
                width: 100
                height: 30
                radius: 8
                color: "#313244"
                
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
                
                // Bounce on hover
                scale: clockMouse.containsMouse ? 1.1 : 1.0
                
                Behavior on scale {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutElastic
                    }
                }
                
                MouseArea {
                    id: clockMouse
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }
        }
        
        // Dock with spring animation
        WaylandPanel {
            anchors {
                bottom: true
                horizontalCenter: true
            }
            
            width: dock.width + 20
            height: 70
            color: "#1e1e2e"
            
            RowLayout {
                id: dock
                anchors.centerIn: parent
                spacing: 10
                
                Repeater {
                    model: ["firefox", "kitty", "code", "spotify"]
                    
                    Rectangle {
                        width: 50
                        height: 50
                        radius: 10
                        color: "#313244"
                        
                        // Spring animation on hover
                        scale: dockMouse.containsMouse ? 1.5 : 1.0
                        
                        property real targetY: dockMouse.containsMouse ? -10 : 0
                        
                        transform: Translate {
                            y: parent.targetY
                            Behavior on y {
                                SpringAnimation {
                                    spring: 3
                                    damping: 0.3
                                }
                            }
                        }
                        
                        Behavior on scale {
                            SpringAnimation {
                                spring: 3
                                damping: 0.3
                            }
                        }
                        
                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            color: "#cdd6f4"
                            font.pixelSize: 12
                        }
                        
                        MouseArea {
                            id: dockMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            
                            onClicked: {
                                Quickshell.Process.run(modelData, [])
                            }
                        }
                    }
                }
            }
        }
    }
}
