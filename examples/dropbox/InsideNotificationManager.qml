import QtQuick 2.9

Item {
    anchors.fill: parent

    Component {
        id: singleShot
        Timer {
            property var action
            running: true
            onTriggered: {
                action && action();
                this.destroy()
            }
        }
    }

    ListModel {
        id: model
    }

    Component {
        id: frame
        Rectangle {
            id: wrapper
            width: Math.max(200, contactInfo.width)
            height: contactInfo.height
            anchors.right: parent.right
            color: "#ccc"
            radius: 8
            Column {
                id: contactInfo
                padding: 4
                Text {
                    padding: 4
                    color: "#000"
                    font.bold: true
                    text: title
                    visible: !!title
                }
                Text {
                    padding: 4
                    color: "#000"
                    text: message
                }
            }

            MouseArea {
                anchors.fill: parent
                //propagateComposedEvents: false
                onClicked: {
                    // @todo クリックで通知を消す
                    console.log('#frame MouseArea onClicked');
                    //mouse.accepted = false;
                    //parent.parent.parent.clicked();
                }

            }
        }
    }

    ListView {
        anchors.fill: parent
        anchors.margins: 4
        spacing: 4
        model: model
        delegate: frame
        interactive: false
    }

    // 通知を追加する
    function append(message, title) {
        model.insert(0, {
            title: title || "",
            message: message,
            t: singleShot.createObject(this, {
                    action: function() {
                            model.remove(model.count-1);
                        },
                    interval: 1000 + 100
                })
        });
    }
}
