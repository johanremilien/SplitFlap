import QtQuick 2.15

Item {
    id: root
    enum Position { Top, Bottom }
    required property int position
    required property size size
    readonly property real deltaY: tile.height - size.height
    property alias tile: shader.sourceItem
    width: size.width
    height: size.height
    clip: true
    ShaderEffectSource {
        id: shader
        y: (position === SplitTile.Position.Top) ? 0 : -deltaY
        width: sourceItem.width
        height: sourceItem.height
        hideSource: true
    }
}
