[![npm](https://img.shields.io/npm/v/@rn-org/react-native-shortcuts.svg)](https://npmjs.com/@rn-org/react-native-shortcuts) [![React Native](https://img.shields.io/badge/React_Native-21232a?style=flat&logo=react&logoColor=0a7ea4&logoSize=small.svg)]() [![Android](https://img.shields.io/badge/Android-green?style=flat&logo=android&logoColor=white)]() [![iOS](https://img.shields.io/badge/iOS-21232a?style=flat&logo=ios&logoColor=white)]() ![RN 0.81.4](https://img.shields.io/badge/RN-0.81.4-brightgreen)

# @rn-org/react-native-shortcuts

React native library for android shortcuts and iOS quick actions which allow users to quickly access specific app functionalities directly from the home screen or app icon, enhancing user experience by providing fast access to common tasks.

Fully compatible with TypeScript & Turbomodules.

Required React Native Version >=0.72.0

## Example

| Android                                                                                                | iOS                                                                                                    |
|--------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| <img src="https://drive.google.com/uc?export=view&id=1yvxaIiDdz3vKxhNE5o0XDLuwwgH1trzw" width="320" /> | <img src="https://drive.google.com/uc?export=view&id=1F3IOUuC1-WRKxOuKcfzSUdjkAr2J-nQT" width="320" /> |

## Supported platforms

| Platform | Support |
|----------|---------|
| iOS      | ✅       |
| Android  | ✅       |
| Web      | ❌       |
| Windows  | ❌       |
| macOS    | ❌       |

## Installation

```sh
npm install @rn-org/react-native-shortcuts
```

or

```sh
yarn add @rn-org/react-native-shortcuts
```

## Setup

### iOS
#### If you are using `Objective-C`

Add the following code to your `AppDelegate.m`

```objective-c
#import "RNShortcuts.h"
```

```objective-c
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
  [RNShortcuts handleShortcutItem:shortcutItem];
  completionHandler(YES);
}
```
#### If you are using `Swift`

Add the following line to your App's `Bridging-Header.h`

> [!IMPORTANT]
> A Bridging Header is required in iOS development when you want to use Objective-C code in a Swift project.
> Add your bridging header to Objective-C Bridging Header under Swift Compiler-General (Target -> Build Settings -> Swift Compiler-General -> Objective-C Bridging Header)
<img width="809" alt="Screenshot 2025-05-20 at 10 28 01 PM" src="https://github.com/user-attachments/assets/6817709a-7623-4bc7-8c50-79ff26ba8069" />

```objective-c
#import "RNShortcuts.h"
```

Add the following code to your `AppDelegate.swift`
```swift
  override func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
      RNShortcuts.handle(shortcutItem)
      completionHandler(true)
  }
```

### Android

No setup needed

## Summary

### Methods

| Name                                                            | Description                                                                                                                                                                                                                                                           |
|-----------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [`addShortcut`](#addShortcut)                                   | Adds the shortcut(android), quick action(ios) for the given details.                                                                                                                                                                                                  |
| [`updateShortcut`](#updateShortcut)                             | Updates the shortcut or quick action details.                                                                                                                                                                                                                         |
| [`removeShortcut`](#removeShortcut)                             | Removes the specific shortcut. For android in case if the user changes your app shortcut to pinned shortcut, app shortcut will be removed but pinned shortcut will be still visible but in disabled state. This shortcut is no longer valid and is not clickable.     |
| [`removeAllShortcuts`](#removeAllShortcuts)                     | Removes all the shortcuts. For android in case if the user changes your app shortcuts to pinned shortcuts, app shortcuts will be removed but pinned shortcuts will be still visible but in disabled state. These shortcuts are no longer valid and are not clickable. |
| [`getShortcutById`](#getShortcutById)                           | Returns the shortcut details such as id, title, longLabel, subtitle.                                                                                                                                                                                                  |
| [`isShortcutExists`](#isShortcutExists)                         | Returns whether the shortcut is registered with given id.                                                                                                                                                                                                             | 
| [`isShortcutSupported`](#isShortcutSupported)                   | Returns whether your device supports shortcuts(android), quick actions(ios).                                                                                                                                                                                          |
| [`getInitialShortcutId`](#getInitialShortcutId)                 | If the initial app launch was triggered by a shortcut, it will give the id of that shortcut, otherwise it will give null.                                                                                                                                             |
| [`addOnShortcutUsedListener`](#addOnShortcutUsedListener)       | If the app is in background and the app is launchced by a shortcut, it will give the id of that shortcut.                                                                                                                                                             |
## Usage

Import

```javascript
import Shortcuts from '@rn-org/react-native-shortcuts';
```

### isShortcutSupported

```javascript
const response = await Shortcuts.isShortcutSupported() // true or false
```

| Platform | Supported Version    |
|----------|----------------------|
| iOS      | >=9.0                |
| Android  | >=7.1 (API Level 25) |

### addShortcut

```javascript
const response = await Shortcuts.addShortcut({
  id: "a426a46b-7389-431c-9ea8-8b370e0c65fc",
  title: "Open App",
  symbolName: "house.fill",
  iconName: "app_shortcut"
})
```

Response:

```json
{
  "id": "a426a46b-7389-431c-9ea8-8b370e0c65fc",
  "title": "Open App"
}
```

Supported options:
| Key | Platform | Required | Description |
| --- | --- | --- | --- |
| `id`               | Both | Yes | A required, app-specific string that you employ to identify the shortcut. |
| `title`            | Both | Yes | The required, user-visible title for the Home Screen shortcut. |
| `longLabel`        | Android | No | An extended phrase that describes the shortcut's purpose. If there's enough space, the launcher displays this value instead of title. When possible, limit this long description to 25 characters. |
| `subTitle`         | iOS | No | The user-visible subtitle for the Home Screen dynamic quick action. |
| `symbolName`       | iOS | No | The SF Symbol for the Home Screen shortcut. Symbol name must correspond to an existing SF Symbol. Refer [iOS](https://developer.apple.com/sf-symbols/) resource addition. |
| `iconName`         | Both | No | The icon for the Home Screen shortcut. Icon name should be the name of your iOS asset or Android drawable. Refer [iOS](https://developer.apple.com/documentation/xcode/managing-assets-with-asset-catalogs) & [Android](https://developer.android.com/studio/write/resource-manager) resource addition. |

### updateShortcut

```javascript
const response = await Shortcuts.updateShortcut({
  id: "a426a46b-7389-431c-9ea8-8b370e0c65fc",
  title: "Open App",
  symbolName: "house.fill",
  iconName: "app_shortcut"
})
```

Response:

```json
{
  "id": "a426a46b-7389-431c-9ea8-8b370e0c65fc",
  "title": "Open App"
}
```

Supported options:
| Key | Platform | Required | Description |
| --- | --- | --- | --- |
| `id`               | Both | Yes | The shortcut id which you want to update. |
| `title`            | Both | Yes | The required, user-visible title for the Home Screen shortcut. |
| `longLabel`        | Android | No | An extended phrase that describes the shortcut's purpose. If there's enough space, the launcher displays this value instead of title. When possible, limit this long description to 25 characters. |
| `subTitle`         | iOS | No | The user-visible subtitle for the Home Screen dynamic quick action. |
| `symbolName`       | iOS | No | The SF Symbol for the Home Screen shortcut. Symbol name must correspond to an existing SF Symbol. Refer [iOS](https://developer.apple.com/sf-symbols/) resource addition. |
| `iconName`         | Both | No | The icon for the Home Screen shortcut. Icon name should be the name of your iOS asset or Android drawable. Refer [iOS](https://developer.apple.com/documentation/xcode/managing-assets-with-asset-catalogs) & [Android](https://developer.android.com/studio/write/resource-manager) resource addition. |

### removeShortcut

```javascript
const response = await Shortcuts.removeShortcut("a426a46b-7389-431c-9ea8-8b370e0c65fc") // true or false
```

Supported options:
| Key | Platform | Required | Description |
| --- | --- | --- | --- |
| `id`               | Both | Yes | The shortcut id which you want to remove. |

### removeAllShortcuts

```javascript
const response = await Shortcuts.removeAllShortcuts() // true or false
```

### isShortcutExists

```javascript
const response = await Shortcuts.isShortcutExists("a426a46b-7389-431c-9ea8-8b370e0c65fc") // true or false
```

Supported options:
| Key | Platform | Required | Description |
| --- | --- | --- | --- |
| `id`               | Both | Yes | The shortcut id which you want to check. |

### getShortcutById

```javascript
const response = await Shortcuts.getShortcutById("a426a46b-7389-431c-9ea8-8b370e0c65fc") // true or false
```

Response:

```json
{
  "id": "a426a46b-7389-431c-9ea8-8b370e0c65fc",
  "title": "Open App",
  "longLable": "...",
  "subTitle": "..."
}
```

Supported options:
| Key | Platform | Required | Description |
| --- | --- | --- | --- |
| `id`               | Both | Yes | The shortcut id which you want to get. |

### getInitialShortcutId

If the initial app launch was triggered by a shortcut, it will give the id of that shortcut,
otherwise it will give null.

```javascript
const id = await Shortcuts.getInitialShortcutId();

or

const callback = (id) => {
  console.log('Shortcut Id:', id);
};

Shortcuts.getInitialShortcutId().then(callback)
```

### addOnShortcutUsedListener

If the app is in background and the app is launchced by a shortcut, it will give the id of that
shortcut.

```javascript
const listenerSubscription = React.useRef<null | EventSubscription>(null);

React.useEffect(() => {
  const callback = (id: string) => {
    console.log('Shortcut Id:', id);
    if (id) {
      Alert.alert('Shortcut Detected', `App opened with shortcut id: ${id}`);
    }
  };

  listenerSubscription.current = Shortcuts.addOnShortcutUsedListener(callback);

  return () => {
    listenerSubscription.current?.remove();
    listenerSubscription.current = null;
  }
}, [])
```

## How To Run Example App ?

To run example app, follow the below steps

1. Clone the repository
2. Do `yarn install`
3. For android`yarn example android`
5. For iOS `cd ios` and do `bundle exec pod install` and run the iOS app from XCode
