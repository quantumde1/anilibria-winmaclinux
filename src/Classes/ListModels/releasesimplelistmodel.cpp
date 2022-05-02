/*
    AniLibria - desktop client for the website anilibria.tv
    Copyright (C) 2021 Roman Vladimirov

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "releasesimplelistmodel.h"

ReleaseSimpleListModel::ReleaseSimpleListModel(QObject *parent)
    : QAbstractListModel{parent}
{
}

int ReleaseSimpleListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;

    return m_releases->size();
}

QVariant ReleaseSimpleListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) return QVariant();

    auto release = m_releases->at(index.row());

    switch (role) {
        case IndexRole: {
            return QVariant(release->id());
        }
        case TitleRole: {
            return QVariant(release->title());
        }
        case PosterRole: {
            return QVariant(release->poster());
        }
    }

    return QVariant();
}

QHash<int, QByteArray> ReleaseSimpleListModel::roleNames() const
{
    return {
        {
            IndexRole,
            "id"
        },
        {
            TitleRole,
            "title"
        },
        {
            PosterRole,
            "poster"
        }
    };
}

void ReleaseSimpleListModel::setReleases(const ReleasesViewModel *viewModel) noexcept
{
    if (m_releasesViewModel == viewModel) return;

    m_releasesViewModel = const_cast<ReleasesViewModel*>(viewModel);
    emit releasesChanged();
    refresh();
}

void ReleaseSimpleListModel::setFilterMode(const QString &filterMode) noexcept
{
    if (m_filterMode == filterMode) return;

    m_filterMode = filterMode;
    emit filterModeChanged();
    refresh();
}

static bool compareTimeStampDescending(const FullReleaseModel* first, const FullReleaseModel* second)
{
    return first->timestamp() > second->timestamp();
}

void ReleaseSimpleListModel::refresh()
{
    if (m_releasesViewModel == nullptr) return;

    beginResetModel();

    m_releases->clear();

    if (m_filterMode == "newinfavorites") {
        m_releasesViewModel->fillNewInFavorites(m_releases.get());

        std::sort(m_releases->begin(), m_releases->end(), compareTimeStampDescending);
    }

    if (m_filterMode == "newfromstart") {
        m_releasesViewModel->fillNewFromStart(m_releases.get());

        std::sort(m_releases->begin(), m_releases->end(), compareTimeStampDescending);
    }

    if (m_filterMode == "lasttwodays") {
        m_releasesViewModel->fillNewFromLastTwoDays(m_releases.get());

        std::sort(m_releases->begin(), m_releases->end(), compareTimeStampDescending);
    }

    if (m_filterMode == "abondonedseens") {
        m_releasesViewModel->fillAbandonedSeens(m_releases.get());

        std::sort(m_releases->begin(), m_releases->end(), compareTimeStampDescending);
    }

    endResetModel();

    emit hasItemsChanged();
}
