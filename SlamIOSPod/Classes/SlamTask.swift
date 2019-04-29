//
//  SlamTask.swift
//  SlamIOSPod
//
//  Created by Steve Sheets on 4/18/19.
//  Copyright © 2019 Steve Sheets. All rights reserved.
//

import UIKit

// MARK: Class

/// Task structure to invoke actions.
///
/// A task is a named global action that can be invoked from almost any location within a program. Software developers can use the SlamTask class call addTask(name:action:) to register a closure with a given name. The runTask(name:param:) class call invokes the closure with the name (param contains an optional string to pass to the closure).
///
/// A common pattern is to use register a task, which will be invoked when the user clicks on a SlamButton. All SlamButton's has an optional task name & an optional task param property.  When the user clicks on a button, the SlamButton code looks at its properties. If they are not empty, the system invokes SlamTask's runTask(name:param:) function.  Multiple buttons can use the same task, using different params (or the same).
///
/// Initially there are several pre-defined tasks, common to iOS development, that are loaded into the list.  These include:
/// "pop" - Dismiss Topmost modal view controller.
/// "push" - Load the view controller from the storyboard with the name passed in param, and display it on the top
/// "url" - Given the address passed in param, open the default browser (usually Safari) and go to that page.
///
/// Thus Tasks are an excellent way to divide an action from the element that invokes it.
public struct SlamTask {
    
    // MARK: Typealias
    
    /// Simpliest of Closure, used for a simple action.
    public typealias TaskActionBlock = (String) -> Void
    
    // MARK: Static Variables
    
    /// Private list of available tasks.
    private static var taskList: [SlamTask] = []
    
    // MARK: Properties
    
    /// Name of task
    private var name = ""
    
    /// Closure associated with task.
    private var action: TaskActionBlock? = nil
    
    // MARK: Static Methods
    
    /// Fill Standard Tasks (if not already done this)
    public static func fillStandardTask() {
        if taskList.count == 0 {
            let popTask = SlamTask(name: "pop") { param in
                UIViewController.popTopViewController()
            }
            let pushTask = SlamTask(name: "push") { param in
                UIViewController.push(storyboardID: param)
            }
            let urlTask = SlamTask(name: "url") { param in
                Slam.launch(address:param)
            }
            taskList.append(popTask)
            taskList.append(pushTask)
            taskList.append(urlTask)
        }
    }
    
    /// Add Task to list of available tasks.
    ///
    /// - Parameters:
    ///   - name: String containing name of task.
    ///   - action: Closure to associate with task.
    public static func addTask(name: String,
                        action: @escaping TaskActionBlock) {
        fillStandardTask()
        
        let task = SlamTask(name: name, action: action)
        taskList.append(task)
    }
    
    /// Run Task (if it is in available task list)
    ///
    /// - Parameter name: String with name of task to execute
    /// - Parameter param: String with parameter of task to execute
    public static func runTask(name: String, param: String = "") {
        fillStandardTask()

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


