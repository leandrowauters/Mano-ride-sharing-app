//
//  MainViewController.swift
//  Mano
//
//  Created by Leandro Wauters on 8/29/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit
import GooglePlaces
import Firebase

class MainViewController: UIViewController {
    

    let mainScreenView = MainScreenView()
    
    private var rides = [Ride]() {
        didSet {
            DispatchQueue.main.async {
                self.mainScreenView.ridesCollectionView.reloadData()
            }
        }
    }
    
    private var history = [Ride]() {
        didSet {
            DispatchQueue.main.async {
                self.mainScreenView.pastTripsTableView.reloadData()
            }
        }
    }
    
    private var userId = String()
    private var listener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainScreenView
        mainScreenView.ridesCollectionView.register(UINib(nibName: "RideStatusCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RideStatusCollectionViewCell")
        mainScreenView.delegate = self
        mainScreenView.ridesCollectionView.delegate = self
        mainScreenView.ridesCollectionView.dataSource = self
        mainScreenView.pastTripsTableView.delegate = self
        mainScreenView.pastTripsTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchUser()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        mainScreenView.hideScheduleRideView()
        listener.remove()
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, userId: String) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchUser() {
        DBService.fetchManoUser(userId: userId) { (error, manoUser) in
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
            if let manoUser = manoUser {
                DBService.currentManoUser = manoUser
                self.mainScreenView.activityIndicator.stopAnimating()
                self.fetchRides()
            }
        }
    }
    
    func fetchRides() {
        listener = DBService.fetchUserRides { (error, rides) in
            if let error = error {
                self.showAlert(title: "No rides fetched", message: error.localizedDescription)
            }
            if let rides = rides {
                self.mainScreenView.noPreviousTripLabel.isHidden = true
                let filterRides = rides.filter { (ride) -> Bool in
                    !ride.appointmentDate.stringToDate().dateExpired() && (ride.rideStatus != RideStatus.rideCancelled.rawValue || ride.rideStatus != RideStatus.rideIsOver.rawValue)
                }
                self.rides = filterRides
                self.history = rides
                self.mainScreenView.manoLogo.isHidden = true
                self.mainScreenView.rideStatusView.isHidden = false
            }
        }
    }
}
extension MainViewController: MainScreenDelegate{
    func manuPressed() {

    }
    
    func didPressedWhereTo(_: Bool) {
        MapsHelper.shared.setupAutoCompeteVC(Vc: self)
    }
}
extension MainViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        guard let dropoffAddress = place.formattedAddress else {
            showAlert(title: "Error finding address", message: nil)
            return}
        let coordinate = place.coordinate
        let vc = ScheduleRideViewController(nibName: nil, bundle: nil, dropoffAddress: dropoffAddress, dropoffName: place.name ?? "", dropoffLat: coordinate.latitude, dropoffLon: coordinate.longitude)
        navigationController?.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

extension MainViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RideStatusCollectionViewCell", for: indexPath) as? RideStatusCollectionViewCell else {fatalError("No cell")}
        let ride = rides[indexPath.row]
        cell.configureCell(with: ride)
        cell.indexLabel.text = "\(indexPath.row + 1)" + "\\" + "\(rides.count)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellWidth : CGFloat = 340.0
        let numberOfCells = floor(self.view.frame.size.width / cellWidth)
        //        var leftInsets = (view.frame.size.width / 2) + (cellWidth / 2)
        let rightInstets = (self.view.frame.size.width / 2) - (cellWidth / 2)
        //        if homePlayers.count + 1 == 1 || homePlayers.count == 0{
        
        let leftInsets = (self.view.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
        //            return UIEdgeInsets(top: 0, left: leftInsets, bottom: 0, right: rightInstets)
        //        }
        return UIEdgeInsets(top: 0, left: leftInsets, bottom: 0, right: rightInstets)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ride = rides[indexPath.row]
        let detailRide = RideDetailViewController(nibName: nil, bundle: nil, pickupAddress: ride.pickupAddress, appointmentAddress: ride.dropoffAddress, dropoffAddress: ride.pickupAddress, date: ride.appointmentDate)
        detailRide.modalPresentationStyle = .overCurrentContext
        present(detailRide, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RideHistoryCell", for: indexPath) as? RideHistoryCell else {fatalError()}
        let historyRide = history[indexPath.row]
        cell.setupCell(with: historyRide)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ride = history[indexPath.row]
        let vc = ScheduleRideViewController(nibName: nil, bundle: nil, dropoffAddress: ride.dropoffAddress, dropoffName: ride.dropoffName , dropoffLat: ride.dropoffLat, dropoffLon: ride.dropoffLon)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
