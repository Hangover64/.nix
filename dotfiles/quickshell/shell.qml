import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

ShellRoot {
    // Top Bar
    PanelWindow {
        id: bar
        
        anchors {
            top: true
            left: true
            right: true
        }
        
        height: 40
        
        Rectangle {
            anchors.fill: parent
            color: "#282a36"  // Dracula Background
            
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

			property int workspaceId: index + 1
			property bool isActive: Hyprland.focusedMonitor.activeWorkspace.id === workspaceId

                        color: isActive ? "#bd93f9" : "#44475a"  // Dracula Purple / Current Line
                        
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
                            color: "#f8f8f2"  // Dracula Foreground
                            font.bold: true
                        }
                        
                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            
			    onClicked: {
				var ws = index +1;
                                Quickshell.Process.run("hyprctl", ["dispatch", "workspace", workspace.toString()]);
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
                width: 100
                height: 30
                radius: 8
                color: "#44475a"  // Dracula Current Line
                
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
                    color: "#f8f8f2"  // Dracula Foreground
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
    
    // Dock - Links und transparent
    PanelWindow {
        id: dock
        
        anchors {
            bottom: true
            left: true
        }
        
        width: 90
        height: dockLayout.height + 20
        
        color: "transparent"  // Panel transparent
        
        Rectangle {
            id: dockContainer
            anchors.centerIn: parent
            width: 70
            height: dockLayout.height + 20
            color: "transparent"  // Hintergrund transparent
            radius: 16
            
            ColumnLayout {  // Vertikal statt horizontal
                id: dockLayout
                anchors.centerIn: parent
                spacing: 10
                
                Repeater {
                    model: [
                        {name: "Firefox", app: "firefox", color: "#ff5555"},      // Dracula Red
                        {name: "Terminal", app: "kitty", color: "#50fa7b"},       // Dracula Green
                        {name: "Code", app: "code", color: "#8be9fd"},            // Dracula Cyan
                        {name: "Spotify", app: "spotify", color: "#f1fa8c"}       // Dracula Yellow
                    ]
                    
                    Rectangle {
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50
                        radius: 10
                        color: dockMouse.containsMouse ? modelData.color : "#44475a"  // Dracula Current Line
                        
                        scale: dockMouse.containsMouse ? 1.5 : 1.0
                        x: dockMouse.containsMouse ? 10 : 0  // Nach rechts beim Hover
                        
                        Behavior on scale {
                            NumberAnimation {
                                duration: 300
                                easing.type: Easing.OutBack
                            }
                        }
                        
                        Behavior on x {
                            NumberAnimation {
                                duration: 300
                                easing.type: Easing.OutBack
                            }
                        }
                        
                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }
                        }
                        
                        Text {
                            anchors.centerIn: parent
                            text: modelData.name.substring(0, 1)
                            color: "#f8f8f2"  // Dracula Foreground
                            font.pixelSize: 20
                            font.bold: true
                        }
                        
                        MouseArea {
                            id: dockMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            
                            onClicked: {
                                Quickshell.Process.run(modelData.app, []);
                            }
                        }
                    }
                }
            }
        }
    }
}
