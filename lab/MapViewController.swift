//
//  ViewController.swift
//  lab
//
//  Created by Ilya Androsav on 2/2/21.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {
    var mapView : GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 53.9006, longitude: 27.5590, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        self.view.addSubview(mapView)
    }

    override func viewDidAppear(_ animated: Bool) {
        for student in StudentTableViewController.students {
            let marker = GMSMarker()
//            marker.position = CLLocationCoordinate2D(latitude: 53.9006, longitude: 27.5590)
            marker.position = CLLocationCoordinate2D(latitude: Double(student.latitude) ?? 0, longitude: Double(student.longitude) ?? 0)
            marker.title = student.firstName + " " + student.lastName + "'s home"
            let dateFromatter =  DateFormatter();
            dateFromatter.dateFormat = "dd MMM YYY"
            marker.snippet = "Birthday: " + dateFromatter.string(from: student.birthday)
            marker.id = student.id
            marker.map = mapView
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailsViewController") as! StudentViewController
        vc.student = StudentTableViewController.students.first(where: {$0.id == marker.id})
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension GMSMarker {
    var id: String {
        set(id) {
            self.userData = id
        }

        get {
           return self.userData as! String
       }
   }
}
