import Flutter
import Photos

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.jungwuk.phototimemachine.date_changer",
                                       binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "changePhotoDate" {
        guard let args = call.arguments as? [String: Any],
              let assetId = args["assetId"] as? String,
              let newDateMillis = args["newDate"] as? Int64 else {
          result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
          return
        }

        let newDate = Date(timeIntervalSince1970: TimeInterval(newDateMillis) / 1000.0)
        self.changePhotoDate(assetId: assetId, newDate: newDate, completion: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func changePhotoDate(assetId: String, newDate: Date, completion: @escaping (Any?) -> Void) {
    let assetResult = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil)
    guard let asset = assetResult.firstObject else {
      completion(false)
      return
    }

    PHPhotoLibrary.shared().performChanges({
      let request = PHAssetChangeRequest(for: asset)
      request.creationDate = newDate
    }, completionHandler: { success, error in
      if let error = error {
        print("Error changing photo date: \(error.localizedDescription)")
      }
      completion(success)
    })
  }
}
