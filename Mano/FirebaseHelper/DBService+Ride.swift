//
//  DBService+Ride.swift
//  Mano
//
//  Created by Leandro Wauters on 9/3/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import Foundation
import FirebaseFirestore
extension DBService {
    
    public func createARide(date: String, passangerId: String, passangerName: String, pickupAddress: String, dropoffAddress: String, dropoffName: String?, pickupLat: Double, pickupLon: Double, dropoffLat: Double, dropoffLon: Double, dateRequested: String, passangerCell: String, completion: @escaping(Error?)-> Void) {
        let ref =  DBService.firestoreDB.collection(RideCollectionKeys.collectionKey).document()
        DBService.firestoreDB.collection(RideCollectionKeys.collectionKey).document(ref.documentID).setData([RideCollectionKeys.appoinmentDateKey : date,
                                                                                                   RideCollectionKeys.passangerId : passangerId,
                                                                                                   RideCollectionKeys.rideIdKey : ref.documentID,
                                                                                                   RideCollectionKeys.passangerName : passangerName,
                                                                                                   RideCollectionKeys.pickupAddressKey : pickupAddress, RideCollectionKeys.dropoffAddressKey : dropoffAddress, RideCollectionKeys.pickupLatKey : pickupLat, RideCollectionKeys.pickupLonKey : pickupLon, RideCollectionKeys.dropoffLonKey :dropoffLon, RideCollectionKeys.dropoffLatKey : dropoffLat, RideCollectionKeys.dateRequestedKey : dateRequested, RideCollectionKeys.passangerCellKey : passangerCell,
                                                                                                   RideCollectionKeys.dropoffNameKey : dropoffName ?? "Drop-off name unavailable",
                                                                                                   RideCollectionKeys.rideStatusKey : RideStatus.rideRequested.rawValue
            
        ]) { (error) in
            if let error = error {
                completion(error)
            }
        }
    }
    
    public func fetchCurrentRides(){
        DBService.firestoreDB.collection(RideCollectionKeys.collectionKey).whereField(RideCollectionKeys.passangerId, isEqualTo: AuthService.currentManoUser.userId).addSnapshotListener { (snapshot, error) in
            if let error = error {
                self.rideFetchingDelegate?.errorFetchingRides(error: error)
            }
            
            if let snapshot = snapshot {
                let rides = snapshot.documents.map{Ride.init(dict: $0.data())}
                let filteredRides = rides.filter { (ride) -> Bool in
                    !ride.appointmentDate.stringToDate().dateExpired() &&
                        (ride.rideStatus == RideStatus.rideRequested.rawValue || ride.rideStatus == RideStatus.pickupAccepted.rawValue)
                }
                self.rideFetchingDelegate?.didFetchRides(rides: filteredRides)
            }
        }
    }
}
