/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Mobility Components.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0

Rectangle {
    id: root
    width: 640
    height: 480
    color: "black"

    Component.onCompleted: {
        init();
    }

    Content {
        id: content
        anchors.fill: root

        onContentSizeChanged: {
            viewer.suggestResize(contentSize);
        }
    }

    MouseArea {
        id: mouseActivityMonitor
        anchors.fill: root

        hoverEnabled: true
        onPositionChanged: {
            controlBar.show();
            controlBarTimer.restart();
        }

        onPressed: {
            hideToolBars();
        }

        onDoubleClicked: {
            root.openVideo();
        }
    }

    Timer {
        id: controlBarTimer
        interval: 1000
        running: false

        onTriggered: {
            hideToolBars();
        }
    }

    ControlBar {
        id: controlBar
        anchors.horizontalCenter: root.horizontalCenter
        anchors.bottom: root.bottom
        anchors.bottomMargin: 50
        mediaPlayer: content.videoPlayer.mediaPlayer

        onOpenFile: {
            root.openVideo();
        }

        onOpenURL: {
            root.openURL();
        }

        onOpenFX: {
            root.openFX();
        }

        onToggleFullScreen: {
            viewer.toggleFullscreen();
        }
    }

    ParameterPanel {
        id: parameterPanel
        opacity: controlBar.opacity
        visible: effectSelectionPanel.visible && model.count !== 0
        height: effectSelectionPanel.height
        anchors {
            left: controlBar.left
            bottom: controlBar.top
            right: effectSelectionPanel.left
            margins: 5
        }
    }

    EffectSelectionPanel {
        id: effectSelectionPanel
        visible: false
        opacity: controlBar.opacity
        anchors {
            bottom: controlBar.top
            right: controlBar.right
            margins: 5
        }
        width: 150
        height: 150
        itemHeight: 40
        onEffectSourceChanged: {
            content.effectSource = effectSource
            parameterPanel.model = content.effect.parameters
        }
    }

    UrlBar {
        id: urlBar
        opacity: 0
        visible: opacity != 0
        anchors.fill: parent
        onUrlAccepted: {
            urlBar.opacity = 0;
            if (text != "")
                content.openVideo(text)
        }
    }


    function init() {
        content.init()
        if (fileName != "")
            content.openVideo(fileName)
    }

    function openVideo() {
        //videoFileBrowser.show()
        var videoFile = viewer.openFileDialog();
        if (videoFile != "")
            content.openVideo(videoFile);
    }

    function openCamera() {
        content.openCamera()
    }

    function openURL() {
        urlBar.opacity = urlBar.opacity === 0 ? 1 : 0
    }

    function openFX() {
        effectSelectionPanel.visible = !effectSelectionPanel.visible;
    }

    function close() {
    }

    function hideToolBars() {
        if (!controlBar.isMouseAbove && !parameterPanel.isMouseAbove && !effectSelectionPanel.isMouseAbove && content.videoPlayer.isPlaying)
            controlBar.hide();
    }
}
