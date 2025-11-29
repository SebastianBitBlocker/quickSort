import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    width: 700
    height: 500
    visible: true
    title: "QuickSort Visualization"

    property var values: []
    property var steps: []   // store array states for each step
    property int currentStep: 0

    Column {
        anchors.centerIn: parent
        spacing: 20

        // Title text
                Text {
                    text: "Welcome to QuickSortApp by Sebastian Gomez, have fun !!"
                    font.pixelSize: 24
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                }

        Row {
            spacing: 10
            TextField {
                id: sizeInput
                width: 100
                placeholderText: "Number of elements"
                inputMethodHints: Qt.ImhDigitsOnly
            }

            Button {
                text: "Generate Array"
                onClicked: {
                    var n = parseInt(sizeInput.text)
                    if (!isNaN(n) && n > 0) {
                        values = []
                        for (var i = 0; i < n; i++) {
                            values.push(Math.floor(Math.random() * 100) + 1)
                        }
                        steps = []
                        steps.push(values.slice()) // initial state
                        currentStep = 0
                        chartCanvas.requestPaint()
                    }
                }
            }

            Button {
                text: "Sort (Animate)"
                onClicked: {
                    steps = []
                    currentStep = 0
                    generateQuickSortSteps(values.slice(), 0, values.length - 1)
                    animationTimer.start()
                }
            }
        }

        Canvas {
            id: chartCanvas
            width: 600
            height: 300
            Component.onCompleted: requestPaint()

            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = "white"
                ctx.fillRect(0, 0, width, height)

                if (steps.length === 0) return

                var arr = steps[currentStep]
                var barWidth = width / arr.length
                ctx.fillStyle = "steelblue"

                for (var i = 0; i < arr.length; i++) {
                    var barHeight = arr[i] * 2.5
                    ctx.fillRect(i * barWidth, height - barHeight, barWidth - 2, barHeight)
                }
            }
        }
    }

    Timer {
        id: animationTimer
        interval: 1   // milliseconds between steps
        repeat: true
        running: false
        onTriggered: {
            if (currentStep < steps.length - 1) {
                currentStep++
                chartCanvas.requestPaint()
            } else {
                animationTimer.stop()
            }
        }
    }

    // QuickSort with step recording
    function generateQuickSortSteps(arr, low, high) {
        if (low < high) {
            var pi = partition(arr, low, high)
            generateQuickSortSteps(arr, low, pi - 1)
            generateQuickSortSteps(arr, pi + 1, high)
        }
    }

    function partition(arr, low, high) {
        var pivot = arr[high]
        var i = low - 1
        for (var j = low; j < high; j++) {
            if (arr[j] <= pivot) {
                i++
                swap(arr, i, j)
                steps.push(arr.slice())  // record step
            }
        }
        swap(arr, i + 1, high)
        steps.push(arr.slice()) // record step
        return i + 1
    }

    function swap(arr, i, j) {
        var tmp = arr[i]
        arr[i] = arr[j]
        arr[j] = tmp
    }
}
