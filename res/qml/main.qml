import QtQuick 2.15
import QtQuick.Window 2.15

import "../js/Easy.js" as Easy

Window {
    id: main
    //1440 900
    width: 1004
    height: 537
    visible: true
    title: "SplitFlapBoard"
    color: "black"

    SplitFlapBoard {
        cellSize: Qt.size(28, 36)
        columns: 22
        rows: 6
        title: main.title
        anchors { fill: parent; margins: 74 }
    }
}
