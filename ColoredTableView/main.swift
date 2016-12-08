import UIKit

CommandLine.unsafeArgv.withMemoryRebound(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)) {
    UIApplicationMain(CommandLine.argc, $0, nil, NSStringFromClass(AppDelegate.self))
    return
}
