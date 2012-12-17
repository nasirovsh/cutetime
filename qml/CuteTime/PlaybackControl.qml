
import QtQuick 2.0

Item {
    id: root
    width: 120
    height: playButton.height

    property bool isPlaybackEnabled: false
    property bool isPlaying: false

    signal forwardButtonPressed()
    signal reverseButtonPressed()
    signal playButtonPressed()

    //Playback Controls
    ImageButton {
        id: rateReverseButton
        imageSource: "images/RateButtonReverse.png"
        anchors.verticalCenter: root.verticalCenter
        anchors.left: root.left
        onClicked: {
            reverseButtonPressed();
        }
    }
    ImageButton {
        id: playButton
        imageSource: !isPlaying ? "images/PlayButton.png" : "images/PauseButton.png"
        anchors.centerIn: root
        anchors.horizontalCenterOffset: 2
        onClicked: {
            playButtonPressed();
        }
    }
    ImageButton {
        id: rateForwardButton
        imageSource: "images/RateButtonForward.png"
        anchors.verticalCenter: root.verticalCenter
        anchors.right: root.right
        onClicked: {
            forwardButtonPressed();
        }
    }
}
