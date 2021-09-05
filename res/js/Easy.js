.pragma library

//add unit test
function get(object, getter, defaultValue) {
    return (object ? object[getter] : defaultValue)
}

function toCamelCase(string) {
    return string.replace(/[^(\w|\s))]/g,('')).toLowerCase().replace(/[\s_]./g, function (match) {
        return match[1].toUpperCase()
    }).trim()
}

function toSpaceUpperCase(string) {
    return string.replace(/[A-Z]/g, (match)=>match?' '+match:'').trim().toUpperCase()
}

function clamp(num, min, max) {
    return Math.min(Math.max(num,min),max);
}

function rotate(num, min, max) {
    return (num < min)?max:(num>max)?min:num
}

function inRange(num,min,max) {
    return (num>=min&&num<=max)
}

//! https://en.wikipedia.org/wiki/List_of_Unicode_characters#Basic_Latin
function nextUnicode(text) {
    var charUnicode = text.charCodeAt()
    return inRange(charUnicode,32,126)?String.fromCharCode(rotate(++charUnicode,32,126)):text
}

function extractRGB(color) {
     console.log('extractRGB',color)
    var red=0
    var green=0
    var blue=0
    if (color[0]==='#') {
        red=parseInt('0x'+color.substr(1,2))
        green=parseInt('0x'+color.substr(3,2))
        blue=parseInt('0x'+color.substr(5,2))
    }
    return {red,green,blue}
}

function convertToHex(number) {
    return Math.round(number).toString(16).padStart(2,'0')
}

function getNextColor(currentColor, requestedColor, step) {
    if (step) {
        var currentRGB=extractRGB(currentColor)
        var requestedRGB=extractRGB(requestedColor)
        var nextRed=convertToHex(currentRGB.red+(requestedRGB.red-currentRGB.red)/step)
        var nextGreen=convertToHex(currentRGB.green+(requestedRGB.green-currentRGB.green)/step)
        var nextBlue=convertToHex(currentRGB.blue+(requestedRGB.blue-currentRGB.blue)/step)
        console.log('#'+nextRed+nextGreen+nextBlue)
        return ('#'+nextRed+nextGreen+nextBlue)
    } else {
        return requestedColor
    }
}

function getRemainingStep(currentChar, requestedChar) {
    var currentUnicode=currentChar.charCodeAt()
    var requestedUnicode=requestedChar.charCodeAt()
    if (requestedUnicode>=currentUnicode) {
        return requestedUnicode-currentUnicode
    } else {
       return (126-currentUnicode)+(requestedUnicode-32)
    }
}

function randomColor(){
    var red = convertToHex(Math.random()*255)
    var green = convertToHex(Math.random()*255)
    var blue = convertToHex(Math.random()*255)
    return ('#'+red+green+blue)
}

