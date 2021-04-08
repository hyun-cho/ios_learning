//
//  MapViewController.swift
//  WorldTrotterCode
//
//  Created by NHN on 2021/04/08.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    override func loadView() {
        //지도 뷰 생성
        mapView = createMapView()
        // 지도 뷰를 이 뷰 컨트롤러의 뷰로 지정
        view = mapView
        
        let segmentedControl: UISegmentedControl! = createSegmentedControl()
        view.addSubview(segmentedControl)
        
        // top constraint를, safeArea에 맞춘다.
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        topConstraint.isActive = true
        
        // 좌 우 마진 anchor와 등록 margins??
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        leadingConstraint.isActive = true
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        trailingConstraint.isActive = true
    }
    
    private func createMapView() -> MKMapView {
        mapView = MKMapView()
        return mapView
    }
    private func createSegmentedControl() -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view")
    }
    
}
