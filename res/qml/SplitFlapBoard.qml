import QtMultimedia 5.15
import QtQuick 2.15
import QtQuick.Layouts 1.15

import "../js/Easy.js" as Easy

Item {
    id: root

    required property size cellSize
    required property int columns
    required property int rows
    required property string title
    GridLayout {
        id: board
        columns: 22
        columnSpacing: 11.65
        rowSpacing: 34
        Repeater {
            model: columns*rows
            SplitFlap { size: cellSize; onPlaySoundEffect: soundEffect.play() }
        }
    }
    // https://www.epidemicsound.com/music/search/?term=clap
    SoundEffect { id: soundEffect; source: "qrc:/sounds/hand_clap.wav" }
    Text {
        anchors { top: board.bottom; topMargin: 28; horizontalCenter: board.horizontalCenter }
        text: Easy.toSpaceUpperCase(title)
        font.pointSize: 18
        color: "white"
    }
}
