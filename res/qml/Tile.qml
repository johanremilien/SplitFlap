import QtQuick 2.15

Rectangle {
    id: root
    required property var unicode
    property alias font: text.font
    property alias charColor: text.color
    Text {
        id: text
        text: unicode
        font.pointSize: 25
        anchors.centerIn: parent
    }
}
