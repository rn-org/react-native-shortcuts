import Foundation
import React

public class RNShortcutsImpl: NSObject {
    @objc public static var shortcutItemType: String?
    
    @objc public static let shared = RNShortcutsImpl()
    
    @objc(getInitialShortcutId: withReject:)
    public func getInitialShortcutId(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        resolve(RNShortcutsImpl.shortcutItemType)
    }
    
    @objc(isShortcutSupported: withReject:)
    public func isShortcutSupported(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        resolve(isSupported())
    }
    
    @objc(addShortcut:withResolve:withReject:)
    public func addShortcut(params: NSDictionary, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        handleShortcutOperation(params: params, resolve: resolve, reject: reject) { shortcutItem in
            UIApplication.shared.shortcutItems?.append(shortcutItem)
            resolve(shortcutItem.toDictionary())
        }
    }
    
    @objc(updateShortcut:withResolve:withReject:)
    public func updateShortcut(params: NSDictionary, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        handleShortcutOperation(params: params, resolve: resolve, reject: reject) { shortcutItem in
            self.updateShortcutItem(shortcutItem, resolve: resolve, reject: reject)
        }
    }
    
    @objc(removeShortcut:withResolve:withReject:)
    public func removeShortcut(id: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        
        DispatchQueue.main.async {
            UIApplication.shared.shortcutItems = UIApplication.shared.shortcutItems?.filter { $0.type != id }
            resolve(true)
        }
        
    }
    
    @objc(removeAllShortcuts:withReject:)
    public func removeAllShortcuts(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        
        DispatchQueue.main.async {
            UIApplication.shared.shortcutItems = []
            resolve(true)
        }
        
    }
    
    @objc(getShortcutById:withResolve:withReject:)
    public func getShortcutById(id: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        
        DispatchQueue.main.async {
            if let shortcut = UIApplication.shared.shortcutItems?.first(where: { $0.type == id }) {
                resolve(shortcut.toDictionary())
            } else {
                resolve(nil)
            }
        }
    }
    
    @objc(isShortcutExists:withResolve:withReject:)
    public func isShortcutExists(id: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        
        DispatchQueue.main.async {
            resolve(UIApplication.shared.shortcutItems?.contains(where: { $0.type == id }) ?? false)
        }
    }
    
    private func handleShortcutOperation(params: NSDictionary, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock, operation: @escaping (UIApplicationShortcutItem) -> Void) {
        guard let id = params["id"] as? String,
              let title = params["title"] as? String else {
            reject("Invalid", "Invalid parameters", NSError(domain: "RNShortcuts", code: 200))
            return
        }
        
        let shortcutItem = createShortcutItem(id: id, title: title, subtitle: params["subTitle"] as? String, symbolName: params["symbolName"] as? String, iconName: params["iconName"] as? String)
        
        DispatchQueue.main.async {
            operation(shortcutItem)
        }
    }
    
    private func createShortcutItem(id: String, title: String, subtitle: String?, symbolName: String?, iconName: String?) -> UIApplicationShortcutItem {
        return UIApplicationShortcutItem(
            type: id,
            localizedTitle: title,
            localizedSubtitle: subtitle,
            icon: getUIApplicationShortcutIcon(symbolName: symbolName, iconName: iconName),
            userInfo: nil
        )
    }
    
    private func updateShortcutItem(_ shortcutItem: UIApplicationShortcutItem, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        if let index = UIApplication.shared.shortcutItems?.firstIndex(where: { $0.type == shortcutItem.type }) {
            UIApplication.shared.shortcutItems?[index] = shortcutItem
            resolve(shortcutItem.toDictionary())
        } else {
            reject("Error", "No shortcut with the id: \(shortcutItem.type)", NSError(domain: "RNShortcuts", code: 200))
        }
    }
    
    private func isSupported() -> Bool {
        if #available(iOS 9.0, *) {
            return true
        } else {
            return false
        }
    }
    
    private func getUIApplicationShortcutIcon(symbolName: String?, iconName: String?) -> UIApplicationShortcutIcon? {
        if let symbolName = symbolName, !symbolName.isEmpty {
            return UIApplicationShortcutIcon(systemImageName: symbolName)
        } else if let iconName = iconName, !iconName.isEmpty {
            return UIApplicationShortcutIcon(templateImageName: iconName)
        } else {
            return nil
        }
    }
}

private extension UIApplicationShortcutItem {
    func toDictionary() -> [String: String?] {
        return [
            "id": type,
            "title": localizedTitle,
            "subtitle": localizedSubtitle
        ]
    }
}
