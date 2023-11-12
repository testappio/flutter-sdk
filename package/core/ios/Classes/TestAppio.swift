//TestAppio.swift

import Flutter
import UIKit
import TestAppIOSDK

public class TestAppioPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "testappio", binaryMessenger: registrar.messenger())
        let instance = TestAppioPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        switch call.method {
        case "setup":
            handleSetup(call: call, result: result)
        case "user.identify":
            handleIdentify(call: call, result: result)
        case "user.reset":
            TestAppio.user.reset()
        case "bar.show":
            TestAppio.bar.show()
        case "bar.hide":
            TestAppio.bar.hide()
        case "log.event":
            handleLogEvent(call: call, result: result)
        case "log.error":
            handleLogError(call: call, result: result)
        case "log.screen":
            handleLogScreen(call: call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func handleSetup(call: FlutterMethodCall, result: FlutterResult) {
        if let args = call.arguments as? [String: String],
        let appToken = args["appToken"],
        let environmentString = args["environment"],
        let environment = TestAppio.Environmnent(rawValue: environmentString) {
            TestAppio.setup(configuration: .init(appToken: appToken, environment: environment))
            result(nil)
        } else {
            result(FlutterError(code: "InvalidArguments", message: "Invalid arguments for 'setup'", details: nil))
        }
    }

    private func handleIdentify(call: FlutterMethodCall, result: FlutterResult) {
        if let args = call.arguments as? [String: Any],
           let userId = args["userId"] as? String {
            let name = args["name"] as? String
            let email = args["email"] as? String
            let imageUrl = args["imageUrl"] as? String
            let traits = args["traits"] as? [String: String]
            TestAppio.user.identify(userId: userId, name: name, email: email, imageUrl: imageUrl, traits: traits ?? [:])
            result(nil)
        } else {
            result(FlutterError(code: "InvalidArguments", message: "Invalid arguments for 'identify'", details: nil))
        }
    }

    private func handleLogEvent(call: FlutterMethodCall, result: FlutterResult) {
        if let args = call.arguments as? [String: Any?],
           let name = args["name"] as? String {
            let properties = args["properties"] as? [String: String]
            TestAppio.log.event(.init(name: name, properties: properties ?? [:]))
            result(nil)
        } else {
            result(FlutterError(code: "InvalidArguments", message: "Invalid arguments for 'event'", details: nil))
        }
    }

    private func handleLogError(call: FlutterMethodCall, result: FlutterResult) {
        if let args = call.arguments as? [String: Any?],
           let name = args["name"] as? String {
            let properties = args["properties"] as? [String: String]
            TestAppio.log.error(.init(name: name, properties: properties ?? [:]))
            result(nil)
        } else {
            result(FlutterError(code: "InvalidArguments", message: "Invalid arguments for 'error'", details: nil))
        }
    }

    private func handleLogScreen(call: FlutterMethodCall, result: FlutterResult) {
        if let args = call.arguments as? [String: Any?],
           let name = args["name"] as? String {
            let properties = args["properties"] as? [String: String]
            TestAppio.log.screen(.init(name: name, properties: properties ?? [:]))
            result(nil)
        } else {
            result(FlutterError(code: "InvalidArguments", message: "Invalid arguments for 'screen'", details: nil))
        }
    }
}
