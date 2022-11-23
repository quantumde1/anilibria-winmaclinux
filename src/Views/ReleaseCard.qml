import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import Anilibria.ListModels 1.0
import "../Controls"


ColumnLayout {
    id: cardContainer
    visible: releasesViewModel.isOpenedCard
    anchors.fill: parent
    spacing: 0
    Rectangle {
        color: applicationThemeViewModel.pageBackground
        Layout.fillWidth: true
        Layout.fillHeight: true
        Column {
            Grid {
                id: releaseInfo
                columnSpacing: 3
                columns: 3
                bottomPadding: 4
                leftPadding: 4
                topPadding: 4
                rightPadding: 4
                Image {
                    id: cardPoster
                    source: localStorage.getReleasePosterPath(releasesViewModel.openedReleaseId, releasesViewModel.openedReleasePoster)
                    fillMode: Image.PreserveAspectCrop
                    width: 280
                    height: 390
                    sourceSize.width: 280
                    sourceSize.height: 390
                    mipmap: true
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: cardMask
                    }

                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            releasePosterPreview.isVisible = true;
                        }
                    }
                }
                Column {
                    id: descriptionColumn
                    width: page.width - cardButtons.width - cardPoster.width
                    AccentText {
                        textFormat: Text.RichText
                        fontPointSize: 14
                        width: parent.width
                        leftPadding: 8
                        topPadding: 6
                        wrapMode: Text.WordWrap
                        maximumLineCount: 3
                        text: releasesViewModel.openedReleaseTitle
                    }
                    PlainText {
                        textFormat: Text.RichText
                        fontPointSize: 10
                        leftPadding: 8
                        topPadding: 4
                        wrapMode: Text.WordWrap
                        width: parent.width
                        maximumLineCount: 2
                        text: releasesViewModel.openedReleaseOriginalName
                    }
                    AccentText {
                        leftPadding: 8
                        topPadding: 4
                        height: releasesViewModel.openedReleaseAnnounce ? 20 : 0
                        fontPointSize: 10
                        wrapMode: Text.NoWrap
                        elide: Text.ElideRight
                        maximumLineCount: 1
                        text: releasesViewModel.openedReleaseAnnounce
                    }
                    PlainText {
                        fontPointSize: 10
                        leftPadding: 8
                        topPadding: 4
                        text: releasesViewModel.openedReleaseStatusDisplay
                        onLinkActivated: {
                            statusesSearchField.text = releasesViewModel.openedReleaseStatus;
                            releasesViewModel.closeReleaseCard();
                            releasesViewModel.items.refresh();
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.NoButton
                            cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }
                    }
                    PlainText {
                        fontPointSize: 10
                        leftPadding: 8
                        topPadding: 4
                        text: releasesViewModel.openedReleaseYearDisplay
                        onLinkActivated: {
                            yearsSearchField.text = releasesViewModel.openedReleaseYear;
                            releasesViewModel.closeReleaseCard();
                            releasesViewModel.items.refresh();
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.NoButton
                            cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }
                    }
                    PlainText {
                        visible: releasesViewModel.openedReleaseInSchedule
                        fontPointSize: 10
                        leftPadding: 8
                        topPadding: 4
                        text: releasesViewModel.openedReleaseInScheduleDisplay
                    }
                    PlainText {
                        fontPointSize: 10
                        leftPadding: 8
                        topPadding: 4
                        text: releasesViewModel.openedReleaseSeasonDisplay
                        onLinkActivated: {
                            seasonesSearchField.text = releasesViewModel.openedReleaseSeason;
                            releasesViewModel.closeReleaseCard();
                            releasesViewModel.items.refresh();
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.NoButton
                            cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }
                    }
                    PlainText {
                        textFormat: Text.RichText
                        fontPointSize: 10
                        leftPadding: 8
                        topPadding: 4
                        width: parent.width
                        wrapMode: Text.WordWrap
                        maximumLineCount: 2
                        text: releasesViewModel.openedReleaseTypeDisplay
                    }
                    PlainText {
                        fontPointSize: 10
                        leftPadding: 8
                        topPadding: 4
                        width: parent.width
                        wrapMode: Text.WordWrap
                        maximumLineCount: 2
                        text: releasesViewModel.openedReleaseGenresDisplay
                        onLinkActivated: {
                            if (genresSearchField.text.length) {
                                genresSearchField.text += ", " + link;
                            } else {
                                genresSearchField.text = link;
                            }
                            releasesViewModel.closeReleaseCard();
                            releasesViewModel.items.refresh();
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.NoButton
                            cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }
                    }
                    PlainText {
                        fontPointSize: 10
                        leftPadding: 8
                        topPadding: 4
                        width: parent.width
                        wrapMode: Text.WordWrap
                        maximumLineCount: 2
                        text: releasesViewModel.openedReleaseVoicesDisplay
                        onLinkActivated: {
                            if (voicesSearchField.text.length) {
                                voicesSearchField.text += ", " + link;
                            } else {
                                voicesSearchField.text = link;
                            }
                            releasesViewModel.closeReleaseCard();
                            releasesViewModel.items.refresh();
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.NoButton
                            cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }
                    }
                    PlainText {
                        fontPointSize: 10
                        leftPadding: 8
                        topPadding: 4
                        visible: releasesViewModel.openedReleaseIsAllSeen
                        width: parent.width
                        text: qsTr("<b>Все серии просмотрены</b>")
                    }
                    Flickable {
                        id: descriptionContainer
                        width: descriptionColumn.width
                        clip: true
                        height: 170
                        boundsBehavior: Flickable.StopAtBounds
                        boundsMovement: Flickable.StopAtBounds
                        contentWidth: width
                        contentHeight: descriptionText.height
                        ScrollBar.vertical: ScrollBar {
                            active: true
                        }

                        PlainText {
                            id: descriptionText
                            width: descriptionContainer.width - 10
                            fontPointSize: 10
                            leftPadding: 8
                            topPadding: 4
                            wrapMode: Text.WordWrap
                            text: "<b>Описание:</b> " + releasesViewModel.openedReleaseDescription
                            onLinkActivated: {
                                releasesViewModel.openDescriptionLink(link);
                            }

                            MouseArea {
                                anchors.fill: parent
                                acceptedButtons: Qt.NoButton
                                cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                            }
                        }
                    }
                }
                Column {
                    id: cardButtons
                    width: 62
                    IconButton {
                        height: 40
                        width: 40
                        iconColor: applicationThemeViewModel.filterIconButtonColor
                        hoverColor: applicationThemeViewModel.filterIconButtonHoverColor
                        overlayVisible: false
                        iconPath: assetsLocation.iconsPath + "coloredclosewindow.svg"
                        iconWidth: 28
                        iconHeight: 28
                        tooltipMessage: "Закрыть карточку релиза"
                        onButtonPressed: {
                            releasesViewModel.closeReleaseCard();
                        }
                    }
                    IconButton {
                        height: 40
                        width: 40
                        hoverColor: applicationThemeViewModel.filterIconButtonHoverColor
                        overlayVisible: false
                        iconPath: assetsLocation.iconsPath + "copy.svg"
                        iconWidth: 26
                        iconHeight: 26
                        tooltipMessage: "Копировать названия или постер"
                        onButtonPressed: {
                            cardCopyMenu.open();
                        }

                        TextEdit {
                            id: hiddenTextField
                            visible: false
                        }

                        CommonMenu {
                            id: cardCopyMenu
                            width: 350

                            CommonMenuItem {
                                text: "Копировать название"
                                onPressed: {
                                    releasesViewModel.copyToClipboard(releasesViewModel.openedReleaseTitle);
                                }
                            }
                            CommonMenuItem {
                                text: "Копировать оригинальное название"
                                onPressed: {
                                    releasesViewModel.copyToClipboard(releasesViewModel.openedReleaseOriginalName);
                                }
                            }
                            CommonMenuItem {
                                text: "Копировать оба названия"
                                onPressed: {
                                    releasesViewModel.copyToClipboard(releasesViewModel.openedReleaseTitle + ", " + releasesViewModel.openedReleaseOriginalName);
                                }
                            }
                            CommonMenuItem {
                                text: "Копировать описание"
                                onPressed: {
                                    releasesViewModel.copyToClipboard(releasesViewModel.openedReleaseDescription);
                                }
                            }
                            CommonMenuItem {
                                text: "Копировать постер"
                                onPressed: {
                                    releasesViewModel.copyImageToClipboard(localStorage.getReleasePosterPath(releasesViewModel.openedReleaseId, releasesViewModel.openedReleasePoster));
                                }
                            }

                        }
                    }
                    IconButton {
                        height: 40
                        width: 40
                        iconColor: applicationThemeViewModel.filterIconButtonColor
                        hoverColor: applicationThemeViewModel.filterIconButtonHoverColor
                        iconPath: assetsLocation.iconsPath + "coloredeye.svg"
                        overlayVisible: false
                        iconWidth: 26
                        iconHeight: 26
                        tooltipMessage: "Управление просмотренным и видимостью релиза"
                        onButtonPressed: {
                            seenMarkMenu.open();
                        }

                        CommonMenu {
                            id: seenMarkMenu
                            width: 350

                            CommonMenuItem {
                                text: "Отметить как просмотренное"
                                onPressed: {
                                    setSeenStateForOpenedRelease(true);
                                }
                            }
                            CommonMenuItem {
                                text: "Отметить как не просмотренное"
                                onPressed: {
                                    setSeenStateForOpenedRelease(false);
                                }
                            }
                            CommonMenuItem {
                                id: hideReleaseCardMenu
                                enabled: releasesViewModel.isOpenedCard && !releasesViewModel.openedReleaseInHided
                                text: "Скрыть релиз"
                                onPressed: {
                                    releasesViewModel.addToHidedReleases([releasesViewModel.openedReleaseId]);
                                    hideReleaseCardMenu.enabled = false;
                                    removeFromHideReleaseCardMenu.enabled = true;
                                    seenMarkMenu.close();
                                }
                            }
                            CommonMenuItem {
                                id: removeFromHideReleaseCardMenu
                                enabled: releasesViewModel.isOpenedCard && releasesViewModel.openedReleaseInHided
                                text: "Убрать релиз из скрытых"
                                onPressed: {
                                    releasesViewModel.removeFromHidedReleases([releasesViewModel.openedReleaseId]);
                                    hideReleaseCardMenu.enabled = true;
                                    removeFromHideReleaseCardMenu.enabled = false;
                                    seenMarkMenu.close();
                                }
                            }
                        }
                    }
                    IconButton {
                        height: 40
                        width: 40
                        overlayVisible: false
                        hoverColor: applicationThemeViewModel.filterIconButtonHoverColor
                        iconPath: assetsLocation.iconsPath + "ratingcolor.svg"
                        iconWidth: 26
                        iconHeight: 26
                        tooltipMessage: "Добавить или удалить из избранного"
                        onButtonPressed: {
                            cardFavoritesMenu.open();
                        }

                        CommonMenu {
                            id: cardFavoritesMenu
                            width: 350

                            CommonMenuItem {
                                enabled: !releasesViewModel.openedReleaseInFavorites
                                text: "Добавить в избранное"
                                onPressed: {
                                    releasesViewModel.addReleaseToFavorites(releasesViewModel.openedReleaseId);
                                    cardFavoritesMenu.close();
                                }
                            }
                            CommonMenuItem {
                                enabled: releasesViewModel.openedReleaseInFavorites
                                text: "Удалить из избранного"
                                onPressed: {
                                    releasesViewModel.removeReleaseFromFavorites(releasesViewModel.openedReleaseId);
                                    cardFavoritesMenu.close();
                                }
                            }
                        }
                    }
                    IconButton {
                        height: 40
                        width: 40
                        overlayVisible: false
                        hoverColor: applicationThemeViewModel.filterIconButtonHoverColor
                        iconPath: assetsLocation.iconsPath + "external.svg"
                        iconWidth: 26
                        iconHeight: 26
                        tooltipMessage: "Открыть онлайн видео в стороннем плеере"
                        onButtonPressed: {
                            externalPlayerMenu.open();
                        }

                        CommonMenu {
                            id: externalPlayerMenu
                            width: 380

                            CommonMenuItem {
                                text: "Открыть во внешнем плеере в HD качестве"
                                onPressed: {
                                    releasesViewModel.openInExternalPlayer(localStorage.packAsM3UAndOpen(releasesViewModel.openedReleaseId, "hd"));
                                    externalPlayerMenu.close();
                                }
                            }
                            CommonMenuItem {
                                text: "Открыть во внешнем плеере в SD качестве"
                                onPressed: {
                                    releasesViewModel.openInExternalPlayer(localStorage.packAsM3UAndOpen(releasesViewModel.openedReleaseId, "sd"));
                                    externalPlayerMenu.close();
                                }
                            }
                            CommonMenuItem {
                                text: "Открыть во внешнем плеере в FullHD качестве"
                                onPressed: {
                                    releasesViewModel.openInExternalPlayer(localStorage.packAsM3UAndOpen(releasesViewModel.openedReleaseId, "fullhd"));
                                    externalPlayerMenu.close();
                                }
                            }

                            CommonMenuItem {
                                notVisible: Qt.platform.os !== "windows"
                                text: "Открыть в плеере MPC в HD качестве"
                                onPressed: {
                                    releasesViewModel.openInExternalPlayer(localStorage.packAsMPCPLAndOpen(releasesViewModel.openedReleaseId, "hd"));
                                    externalPlayerMenu.close();
                                }
                            }
                            CommonMenuItem {
                                notVisible: Qt.platform.os !== "windows"
                                text: "Открыть в плеере MPC в SD качестве"
                                onPressed: {
                                    releasesViewModel.openInExternalPlayer(localStorage.packAsMPCPLAndOpen(releasesViewModel.openedReleaseId, "sd"));
                                    externalPlayerMenu.close();
                                }
                            }
                            CommonMenuItem {
                                notVisible: Qt.platform.os !== "windows"
                                text: "Открыть в плеере MPC в FullHD качестве"
                                onPressed: {
                                    releasesViewModel.openInExternalPlayer(localStorage.packAsMPCPLAndOpen(releasesViewModel.openedReleaseId, "fullhd"));
                                    externalPlayerMenu.close();
                                }
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: releaseCardControlsContainer
                color: "transparent"
                width: cardContainer.width
                height: 60

                RoundedActionButton {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 10
                    anchors.left: parent.left
                    text: qsTr("Скачать")
                    onClicked: {
                        dowloadTorrent.open();
                    }

                    CommonMenu {
                        id: dowloadTorrent
                        y: parent.height - parent.height
                        width: 380

                        Repeater {
                            model: releasesViewModel.openedCardTorrents
                            CommonMenuItem {
                                text: "Скачать " + quality + " [" + series + "] " + size
                                onPressed: {
                                    const torrentUri = synchronizationService.combineWithWebSiteUrl(url);
                                    synchronizationService.downloadTorrent(torrentUri);
                                    userActivityViewModel.addDownloadedTorrentToCounter();

                                    if (userConfigurationViewModel.markAsReadAfterDownload) setSeenStateForOpenedRelease(true);
                                }
                            }
                        }
                    }
                }

                PlainText {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 100
                    fontPointSize: 11
                    text: "Доступно "+ releasesViewModel.openedReleaseCountTorrents + " торрентов"
                }

                PlainText {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: watchButton.left
                    anchors.rightMargin: 10
                    fontPointSize: 11
                    text: "Доступно "+ releasesViewModel.openedReleaseCountVideos + " серий онлайн"
                }

                RoundedActionButton {
                    id: watchButton
                    text: qsTr("Смотреть")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    onClicked: {
                        watchSingleRelease(releasesViewModel.openedReleaseId, releasesViewModel.openedReleaseVideos, -1, releasesViewModel.openedReleasePoster)

                        releasesViewModel.hideAfterWatchReleaseCard();
                        releasePosterPreview.isVisible = false;
                    }
                }

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                }

                RoundedActionButton {
                    id: openCommentsButton
                    text: qsTr("Открыть комментарии")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.centerIn: parent
                    onClicked: {
                        const url = releasesViewModel.getVkontakteCommentPage(releasesViewModel.openedReleaseCode);
                        Qt.openUrlExternally(url);
                    }
                }
            }

            Item {
                width: cardContainer.width
                height: 30

                PlainText {
                    anchors.centerIn: parent
                    fontPointSize: 11
                    text: releaseCardMenuListModel.selectedTitle
                }

                IconButton {
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    height: 26
                    width: 26
                    overlayVisible: false
                    hoverColor: applicationThemeViewModel.filterIconButtonHoverColor
                    iconWidth: 22
                    iconHeight: 22
                    iconPath: assetsLocation.iconsPath + "allreleases.svg"
                    onButtonPressed: {
                        releaseCardSubMenu.open();
                    }

                    CommonMenu {
                        id: releaseCardSubMenu
                        width: 330

                        ReleaseCardMenuListModel {
                            id: releaseCardMenuListModel
                            isEmptyReleaseSeries: releaseSeriesList.isEmpty
                        }

                        Repeater {
                            model: releaseCardMenuListModel

                            CommonMenuItem {
                                text: title
                                onPressed: {
                                    releaseCardSubMenu.close();
                                    releaseCardMenuListModel.select(id);
                                }
                            }
                        }
                    }
                }
            }

            Item {
                width: cardContainer.width
                height: 330
                ReleaseSeriesList {
                    id: releaseSeriesList
                    visible: releaseCardMenuListModel.isReleaseSeries
                    width: cardContainer.width
                    releaseId: releasesViewModel.openedReleaseId
                    onOpenRelease: {
                        releasesViewModel.showReleaseCard(releaseId);
                    }
                }

                ReleaseOnlineVideosList {
                    visible: releaseCardMenuListModel.isOnlineVideos
                    width: cardContainer.width
                    releaseId: releasesViewModel.openedReleaseId
                    onOpenVideo: {
                        watchSingleRelease(releasesViewModel.openedReleaseId, releasesViewModel.openedReleaseVideos, videoId, releasesViewModel.openedReleasePoster);

                        releasesViewModel.hideAfterWatchReleaseCard();
                    }
                }
            }
        }
    }

}