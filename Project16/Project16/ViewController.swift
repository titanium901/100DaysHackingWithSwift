//
//  ViewController.swift
//  Project16
//
//  Created by Yury Popov on 05/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import MapKit
import UIKit


class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "MapType", style: .done, target: self, action: #selector(changeMapType))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
       
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        guard annotation is Capital else { return nil }
        
        // 2
        let identifier = "Capital"
        
        // 3
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            //4
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = UIColor.black
            
            // 5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        print(mapView.mapType)
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        let webBtn = UIAlertAction(title: "Wikipedia", style: .default) { (_) in
            self.showWebView(title: placeName!)
        }
        ac.addAction(webBtn)
        present(ac, animated: true)
    }
    
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Pick Map Type", message: nil, preferredStyle: .actionSheet)
        let standard = UIAlertAction(title: "Standard", style: .default) { (_) in
            self.mapView.mapType = .standard
        }
        let satellite = UIAlertAction(title: "Satellite", style: .default) { (_) in
            self.mapView.mapType = .satellite
        }
        let hybrid = UIAlertAction(title: "Hybrid", style: .default) { (_) in
            self.mapView.mapType = .hybrid
        }
        let satelliteFlyover = UIAlertAction(title: "SatelliteFlyover", style: .default) { (_) in
            self.mapView.mapType = .satelliteFlyover
        }
        let hybridFlyover = UIAlertAction(title: "HybridFlyover", style: .default) { (_) in
            self.mapView.mapType = .hybridFlyover
        }
        let mutedStandard = UIAlertAction(title: "MutedStandard", style: .default) { (_) in
            self.mapView.mapType = .mutedStandard
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(standard)
        ac.addAction(satellite)
        ac.addAction(hybrid)
        ac.addAction(satelliteFlyover)
        ac.addAction(hybridFlyover)
        ac.addAction(mutedStandard)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    func showWebView(title: String) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? DetailWebView else { return }
        vc.url = title
        navigationController?.pushViewController(vc, animated: true)
    
    }
}

