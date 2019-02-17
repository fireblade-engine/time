//
//  Base.swift
//  FirebladeTimeTests
//
//  Created by Christian Treffs on 17.02.19.
//

import Foundation

public func ensureIdleMainThread() {
    // https://stackoverflow.com/a/15125418
    precondition(Thread.current.isMainThread)
    sleep(2)
    
}
