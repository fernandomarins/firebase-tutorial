//
//  GCDBlackBox.swift
//  FireBaseTutorial
//
//  Created by Fernando Augusto de Marins on 10/08/16.
//  Copyright © 2016 Fernando, Inc. All rights reserved.
//

import Foundation

func performUpdatesOnMain(updates: () -> Void) {
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}