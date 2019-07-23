//
//  FavoriteViewModel.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/18.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import RxSwift
import RealmSwift

class FavoriteViewModel{
    func isFavorite(_ data:NewsItem)->Observable<Bool>{
        return Observable<Bool>.create{observer ->Disposable in
            let realm = try!Realm()
            let predicate = NSPredicate(format: "dataId == %@",data.dataId)
            let favorites = realm.objects(Favorite.self).filter(predicate)
            observer.onNext(!favorites.isEmpty)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    func favorite(_ data:NewsItem)->Observable<Bool>{
        return Observable<Bool>.create{observer ->Disposable in
            let realm = try!Realm()
            try!realm.write {
                realm.add(data.to(),update: .modified)
            }
            observer.onNext(true)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func getFavorites()->Observable<Array<NewsItem>>{
        return Observable<Array<NewsItem>>.create{observer ->Disposable in
            let realm = try!Realm()
            let favorites = realm.objects(Favorite.self)
            var arr:Array<NewsItem> = []
            favorites.forEach{a in
                arr.append(a.to())
            }
            arr.reverse()
            observer.onNext(arr)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    func deleteFavorite(_ data:NewsItem)->Observable<Bool>{
        return Observable<Bool>.create{observer ->Disposable in
            let realm = try!Realm()
            realm.beginWrite()
            let predicate = NSPredicate(format: "dataId == %@",data.dataId)
            let favorites = realm.objects(Favorite.self).filter(predicate)
            if !favorites.isEmpty{
                realm.delete(favorites)
            }
            try!realm.commitWrite()
            observer.onNext(true)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}


