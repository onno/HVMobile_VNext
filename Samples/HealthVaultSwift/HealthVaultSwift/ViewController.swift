//
//  ViewController.swift
//  HealthVaultSwift
//
//  Created by Onno van Zinderen Bakker on 26-11-15.
//  Copyright © 2015 Onno van Zinderen Bakker. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        startApp()
    }


    // MARK: - HealthVault Startup

    func startApp() {
        HVClient.current().startWithParentController(self) {
            sender in
            if HVClient.current().provisionStatus == HVAppProvisionSuccess {
                self.startUpSuccess()
            } else {
                self.startUpFailed()
            }
        }
    }


    func startUpSuccess() {
        print("HealthVault startup succeeded.")
        let record = HVClient.current().currentRecord
        print("Current record owner: \(record.displayName)")
        getWeightsFromHealthVault()
    }


    func startUpFailed() {
        print("HealhtVault startup failed!")
        HVUIAlert.showWithMessage("Provisioning not completed. Retry?") {
            sender in
            let alert = sender as! HVUIAlert
            if (alert.result == HVUIAlertOK) {
                self.startApp()
            }
        }
    }


    // MARK: - Getting & Putting things from/to HealthVault

    func getWeightsFromHealthVault() {
        let record = HVClient.current().currentRecord
        record.getItemsForClass(HVWeight.self) {
            task in

            let items = (task as! HVGetItemsTask).itemsRetrieved
            for item in items {
                let weight = item.weight()
                print("\(weight.when): \(weight.inKg) Kg.")
            }

        }
    }

}

