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

#ifndef MYANILIBRIAVIEWMODEL_H
#define MYANILIBRIAVIEWMODEL_H

#include <QObject>
#include "./releasesviewmodel.h"
#include "../ListModels/myanilibrialistmodel.h"

class MyAnilibriaViewModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(ReleasesViewModel* releasesViewModel READ releasesViewModel WRITE setReleasesViewModel NOTIFY releasesViewModelChanged)
    Q_PROPERTY(MyAnilibriaListModel* myList READ myList NOTIFY myListChanged)
    Q_PROPERTY(QString genres READ genres NOTIFY genresChanged)
    Q_PROPERTY(QString voices READ voices NOTIFY voicesChanged)

private:
    QString m_cacheFileName { "myanilibrialist.cache" };
    QString m_pathToCacheFile { "" };
    ReleasesViewModel* m_releasesViewModel { nullptr };
    QScopedPointer<MyAnilibriaListModel> m_myList { new MyAnilibriaListModel() };

public:
    explicit MyAnilibriaViewModel(QObject *parent = nullptr);

    ReleasesViewModel* releasesViewModel() const noexcept { return m_releasesViewModel; }
    void setReleasesViewModel(const ReleasesViewModel* viewModel) noexcept;

    MyAnilibriaListModel* myList() const noexcept { return m_myList.get(); }

    QString genres() const noexcept;
    QString voices() const noexcept;

private:
    void readFromCache() noexcept;

private slots:
    void saveSections();

signals:
    void releasesViewModelChanged();
    void genresChanged();
    void voicesChanged();
    void myListChanged();

};

#endif // MYANILIBRIAVIEWMODEL_H
