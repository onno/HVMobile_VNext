//
//  ViewController.swift
//  HealthVaultSwift
//
//  Created by Onno van Zinderen Bakker on 26-11-15.
//  Copyright © 2015 Onno van Zinderen Bakker. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {

    // MARK: - Variables

    var items: HVItemCollection = HVItemCollection()

    lazy var massFormatter: NSMassFormatter = {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1

        let formatter = NSMassFormatter()
        formatter.forPersonMassUse = true
        formatter.unitStyle = .Medium
        formatter.numberFormatter = numberFormatter
        return formatter
    }()

    lazy var dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        return formatter
    }()


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

        self.navigationItem.title = record.displayName
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
            self.items = (task as! HVGetItemsTask).itemsRetrieved

            print("On the main thread? " + (NSThread.currentThread().isMainThread ? "Yes" : "No"))
            self.tableView.reloadData()
        }
    }


    // MARK: - Table View Data Source

    override func tableView(
        tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return items.count
    }


    override func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "WeightCell",
            forIndexPath: indexPath
        )

        let weight = items[indexPath.row].weight()
        cell.textLabel!.text = massFormatter.stringFromKilograms(weight.inKg)
        cell.detailTextLabel!.text = dateFormatter.stringFromDate(weight.when.toDate())

        return cell
    }

}

