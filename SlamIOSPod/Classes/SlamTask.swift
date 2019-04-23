//
//  SlamTask.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/18/19.
//  Copyright © 2019 Steve Sheets. All rights reserved.
//

import UIKit

// MARK: Class

/// Task structure to invoke action
struct SlamTask {
    
    // MARK: Static Variables
    
    /// Private list of available tasks.
    private static var taskList: [SlamTask] = []
    
    // MARK: Typealias
    
    /// Simpliest of Closure, used for a simple action.
    public typealias TaskActionBlock = (String) -> Void

    // MARK: Properties
    
    /// Name of task
    var name = ""
    
    /// Closure associated with task.
    var action: TaskActionBlock? = nil
    
    // MARK: Static Methods
    
    /// Add Task to list of available tasks.
    ///
    /// - Parameters:
    ///   - name: String containing name of task.
    ///   - action: Closure to associate with task.
    static func addTask(name: String,
                        action: @escaping TaskActionBlock) {
        let task = SlamTask(name: name, action: action)
        taskList.append(task)
    }
    
    /// Run Task (if it is in available task list)
    ///
    /// - Parameter name: String with name of task to execute
    /// - Parameter param: String with parameter of task to execute
    static func runTask(name: String, param: String = "") {
        for task in taskList {
            if name==task.name {
                if let action = task.action {
                    action(param)
                }
                return
            }
        }
    }
}


