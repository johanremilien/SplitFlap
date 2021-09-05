import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

import "../js/Easy.js" as Easy

Rectangle {
    id: root
    property color borderColor: Easy.randomColor()
    property real borderWidth: 1/Screen.devicePixelRatio
    property int handleSizeFactor: 11
    property var object: null
    width: object ? object.width : 50
    height: object ? object.height : 50
    color: "transparent"
    border { color: borderColor; width: borderWidth }
    MouseArea { id: dragArea;  hoverEnabled: true; anchors.fill: parent; drag.target: parent }
    Component {
        id: handle
        Rectangle {
            property alias axis: handleMouseArea.drag.axis
            signal dragActiveChanged(bool dragActive)
            color: borderColor
            MouseArea { id: handleMouseArea; anchors.fill: parent; drag.target: parent }
        }
    }
    ToolTip {
        visible: dragArea.containsMouse && !dragArea.drag.active
        text: "x: %1  y: %2 width: %3 height: %4".arg(root.x).arg(root.y).arg(root.width).arg(root.height)
    }

    Loader {
        id: right
        width: borderWidth*handleSizeFactor
        height: width
        x: root.width-width/2
        y: (root.height-height)/2
        sourceComponent: handle
        onLoaded: { item.axis=Drag.XAxis; item.xChanged.connect(()=>root.width+=item.x) }
    }
    Loader {
        id: bottom
        width: borderWidth*handleSizeFactor
        height: width
        x: (root.width-width)/2
        y: root.height-height/2
        sourceComponent: handle
        onLoaded: { item.axis=Drag.YAxis; item.yChanged.connect(()=>root.height+=item.y) }
    }
    Loader {
        id: left
        width: borderWidth*handleSizeFactor
        height: width
        x: -width/2
        y: (root.height-height)/2
        sourceComponent: handle
        onLoaded: { item.axis=Drag.XAxis; item.xChanged.connect(()=>{root.x+=item.x
                                                                    root.width-=item.x})
        }
    }
    Loader {
        id: top
        width: borderWidth*handleSizeFactor
        height: width
        x: (root.width-width)/2
        y: -height/2
        sourceComponent: handle
        onLoaded: { item.axis=Drag.YAxis; item.yChanged.connect(()=>{root.y+=item.y
                                                                    root.height-=item.y})
        }
    }
}
