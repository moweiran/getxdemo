import UIKit
import Flutter
import workmanager

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
//    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
//    let
      
    
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "myApp",
                                                    binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
        // This method is invoked on the UI thread.
        guard call.method == "getBatteryLevel" else {
          result(FlutterMethodNotImplemented)
          return
        }
        self?.receiveBatteryLevel(result: result)
    })

    GeneratedPluginRegistrant.register(with: self)
    UNUserNotificationCenter.current().delegate = self

    WorkmanagerPlugin.setPluginRegistrantCallback { registry in
      // Registry in this case is the FlutterEngine that is created in Workmanager's
      // performFetchWithCompletionHandler or BGAppRefreshTask.
      // This will make other plugins available during a background operation.
      GeneratedPluginRegistrant.register(with: registry)
    }

    WorkmanagerPlugin.registerTask(withIdentifier: "be.tramckrijte.workmanagerExample.taskId")
    WorkmanagerPlugin.registerTask(withIdentifier: "be.tramckrijte.workmanagerExample.simpleTask")
    WorkmanagerPlugin.registerTask(withIdentifier: "be.tramckrijte.workmanagerExample.rescheduledTask")
    WorkmanagerPlugin.registerTask(withIdentifier: "be.tramckrijte.workmanagerExample.failedTask")
    WorkmanagerPlugin.registerTask(withIdentifier: "be.tramckrijte.workmanagerExample.simpleDelayedTask")
    WorkmanagerPlugin.registerTask(withIdentifier: "be.tramckrijte.workmanagerExample.simplePeriodicTask")
    WorkmanagerPlugin.registerTask(withIdentifier: "be.tramckrijte.workmanagerExample.simplePeriodic1HourTask")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler(.alert) // shows banner even if app is in foreground
  }

  private func receiveBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    if device.batteryState == UIDevice.BatteryState.unknown {
      result(FlutterError(code: "UNAVAILABLE",
                          message: "Battery level not available.",
                          details: nil))
    } else {
        let level = String(device.batteryLevel*100)
        result(level)
//      result(Int(device.batteryLevel * 100))
    }
  }
}
