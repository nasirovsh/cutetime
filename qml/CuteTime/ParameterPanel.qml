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

Item {
    id: root
    height: view.model.count * sliderHeight
    property color lineColor: "black"
    property real spacing: 10
    property real sliderHeight: 40
    property bool isMouseAbove: mouseAboveMonitor.containsMouse

    property ListModel model: ListModel { }

    MouseArea {
        id: mouseAboveMonitor
        anchors.fill: parent
        hoverEnabled: true;
    }

    BorderImage {
        source: "images/ControlBar.png"
        anchors.fill: parent
        border.top: 12
        border.bottom: 12
        border.left: 12
        border.right: 12
    }

    Component {
        id: editDelegate

        Rectangle {
            id: delegate
            width: parent.width
            height: root.sliderHeight
            color: "transparent"

            Text {
                id: text
                text: name
                color: "white"
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                }
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                width: 110
            }

            Slider {
                anchors {
                    verticalCenter: text.verticalCenter
                    verticalCenterOffset: 3
                    left: text.right
                    leftMargin: 20
                    right: parent.right
                    rightMargin: 20
                }
                value: model.value
                onValueChanged: view.model.setProperty(index, "value", value)
            }
        }
    }

    ListView {
        id: view
        anchors.fill: parent
        anchors.margins: 8
        model: root.model
        delegate: editDelegate
        interactive: false
    }
}
