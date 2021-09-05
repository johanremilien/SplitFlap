import QtQuick 2.15
import QtQuick.Layouts 1.15

import "../js/Easy.js" as Easy

Item {
    id: root
    function checkIsFlipNeeded() {
        if (currentChar !== requestedChar) {
            flap.state = "back"
        }
    }
    // flip
    property int flipDuration: 160
    readonly property int remainingStep: Easy.getRemainingStep(currentChar, requestedChar)
    // size
    required property size size
    readonly property size flapSize: Qt.size(width, (height-flapSpacing)/2) //calculate it only once
    property real flapSpacing: 2
    // char
    property string currentChar: " "
    readonly property var nextChar: Easy.nextUnicode(currentChar)
    property string requestedChar: "~"
    // tile color
    property string currentTileColor: '#FFFFFF'
    readonly property var nextTileColor: Easy.getNextColor(currentTileColor, requestedTileColor, remainingStep)
    property string requestedTileColor: '#000000'
    // char color
    property string currentCharColor: '#000000'
    readonly property var nextCharColor: Easy.getNextColor(currentCharColor, requestedCharColor, remainingStep)
    property string requestedCharColor: '#FFFFFF'
    signal playSoundEffect
    onRequestedCharChanged: checkIsFlipNeeded()
    width: size.width
    height: size.height
    Tile { id: currentTile; color: currentTileColor; charColor: currentCharColor; anchors.fill: parent; unicode: currentChar }
    Tile { id: nextTile; color: nextTileColor; charColor: nextCharColor; anchors.fill: parent; unicode: nextChar }
    SplitTile { size: flapSize; tile: nextTile; position: SplitTile.Position.Top }
    SplitTile { y: deltaY; size: flapSize; tile: currentTile; position: SplitTile.Position.Bottom }
    Flipable {
        id: flap
        width: flapSize.width
        height: flapSize.height
        front: SplitTile { size: flapSize; tile: currentTile; position: SplitTile.Position.Top }
        back:  SplitTile { size: flapSize; tile: nextTile; position: SplitTile.Position.Bottom }
        transform: Rotation {
            id: rotation
            origin { x: 0; y: flapSize.height + flapSpacing/2 }
            axis { x: 1; y: 0; z: 0 }
            angle: 0
        }
        states: State {
            name: "back"; PropertyChanges { target: rotation; angle: 180 }
        }
        transitions: Transition {
            to: "back"
            SequentialAnimation {
                loops: Animation.Infinite
                alwaysRunToEnd: true
                ParallelAnimation {
                    NumberAnimation {
                        target: rotation
                        property: "angle"
                        duration: flipDuration
                        easing.type: Easing.InQuad
                    }
                    SequentialAnimation {
                        PauseAnimation { duration: flipDuration - 80 }
                        ScriptAction {
                            script: { playSoundEffect() }
                        }
                    }
                }
                ScriptAction {
                    script: {
                        currentChar=nextChar;
                        currentCharColor=nextCharColor
                        currentTileColor=nextTileColor
                        flap.state="";
                        checkIsFlipNeeded() }
                }
            }
        }
    }
    MouseArea { anchors.fill: parent; onClicked: requestedChar = nextChar }
    Component.onCompleted: checkIsFlipNeeded()
}
