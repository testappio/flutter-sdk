![TestApp.io Sessions](https://cdn.testapp.io/image/seo/sessions_dark.svg)

# TestApp.io SDK for Flutter

Seamlessly integrate TestApp.io's comprehensive feedback and performance monitoring tools into your Flutter applications. Capture insightful feedback and crucial events with minimal effort to enhance your app's quality.

## Table of Contents
1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Features](#features)
4. [Setup & Installation](#setup-install)
   - [Android](#android)
   - [iOS](#ios)
      - [Podfile](#podfile)
      - [pubspec.yaml](#pubspec)
      - [Permissions](#permissions)
      - [Initialization](#initialization)
      - [Update SDK](#update-sdk)
5. [Features](#features)
6. [Usage](#usage#screenshots-from-a-sample-app)
   - [User Identification](#user-identification)
      - [Traits](#traits)
      - [User Reset](#user-reset)
   - [UI Interactions](#ui-interactions)
   - [Logging & Events](#4-initialization)
   - [Continuous Sessions](#continuous-sessions)
   - [Application & Session Lifecycle](#app-lifecycle-sessions-events)
      - [Session Events](#session-events)
      - [Lifecycle Events](#lifecycle-events)
      - [Offline Mode](#offline-mode)
7. [Screenshots](#screenshots)
7. [FAQ](#faq)
8. [Privacy](#privacy)
9. [Feedback & Support](#feedback-support)

## Overview <a name="overview"></a>

TestApp.io SDK bridges your application with the TestApp.io platform, enabling a deeper understanding of user interactions and app behavior. Through the TestApp.io Portal, you can easily monitor sessions, gather feedback, and track activities.

## Requirements <a name="requirements"></a>

- Flutter: **2.5.0** or higher
- Dart: **2.12.0** or higher
- iOS: Minimum iOS deployment target is iOS **13.0** or higher

## Setup & Installation <a name="setup-install"></a>

### Android <a name="android"></a>
> Coming soon!

### iOS <a name="ios"></a>

To ensure proper functionality of the TestApp.io SDK on iOS, your project's minimum iOS deployment target should be set to iOS **13.0** or higher. This is due to specific features and capabilities used by the SDK that are available from iOS 13 onwards.

To set the iOS deployment target, follow these steps:

1. Open your Flutter project in Xcode.
2. Navigate to the project's target settings.
3. Under `General`, find the or `Minimum Deployments` or `Deployment Info`section.
4. Set the `Target` field to iOS 13.0 or higher.

### 1. **Podfile** <a name="podfile"></a>
Add the TestApp.io SDK to your iOS project's `Podfile`:
```ruby
pod 'TestAppIOSDK', :git => 'https://github.com/testappio/ios-sdk.git'
```
Then run `pod install`

### 2. pubspec.yaml <a name="pubspec"></a>
Add testappio to your project pubspec.yaml

```yaml
dependencies:
  #other dependencies
  testappio:
    git:
      url: https://github.com/testappio/flutter-sdk
      ref: main
      path: package/core
```

### 3. Permissions: <a name="pubspec"></a>
Add necessary permissions to your app's `Info.plist`:
   - **Photo Library Access**: For screen recordings and images.
      - `NSPhotoLibraryUsageDescription`
	  > Provide access to save photos and videos in your gallery
      - `NSPhotoLibraryAddUsageDescription`
	  > Provide access to get photos and videos from your gallery

### 4. Initialization: <a name="initialization"></a>
In your app's launch sequence, add:

```dart
import 'package:testappio/testappio.dart';

// create an instance of the plugin
  final testappio = TestAppio();

// We support iOS for now
if (Platform.isIOS) {
	await testappio.setup('<APP_TOKEN>', TestAppioEnvironment.dev); //[TestAppioEnvironment.dev, TestAppioEnvironment.staging, TestAppioEnvironment.production]
}
```

Collect your App Token from [App -> Integrations -> Sessions (SDK)](https://portal.testapp.io/apps?to=app-integrations&tab=sessions)

## Updating the SDK <a name="update-sdk"></a>
To ensure you're benefiting from the latest features and optimizations, regularly update the TestApp.io SDK:

   - **Swift Package Manager**: Refresh your packages in Xcode.
   - **CocoaPods**: Run `pod update TestAppIOSDK` in your terminal.

---

## Features <a name="features"></a>

- **🚀 Real-time Analytics**: Gain immediate insights with real-time event tracking.
- **💬 Feedback Collection**: Directly gather user feedback, enhancing product iterations.
- **📺 Screen Recording**: Visualize user interactions for deeper insights.
- **🛠 Rich Debugging**: Monitor significant events, errors, and screen transitions.
- **📱 Device Monitoring**:  Stay informed about device metrics to optimize performance.

---

## Usage <a name="usage"></a>

### User Identification <a name="user-identification"></a>
Personalize user experience and accurately track interactions by identifying users with unique attributes.

#### Parameters
| Parameter   | Description                              | Type      | Example Value                   | Constraints                                     |
|-------------|------------------------------------------|-----------|---------------------------------|-------------------------------------------------|
| `userId`    | Unique identifier for the user in your database (required)        | `String`  | `U123456`                       | Length: 0-120 characters                         |
| `name`      | Name of a user (optional)                   | `String`  | `Jane Doe`                      | Length: 0-120 characters                         |
| `email`     | Email address of a user (optional)                  | `String`  | `jane.doe@example.com`          | Length: 0-255 characters                         |
| `imageUrl`  | URL to an avatar image for the user (optional)       | `String`  | `https://url/to/sample-image.png` | Length: max 255 characters                      |
| `traits`  | Additional traits of the user (optional)       | `Map<String, dynamic>`  | `{"vip": true, "level": 13, "theme": "dark"}` | Max 10 key-value pairs. Key: 40 chars, Value: 120 chars                      |

```dart
testappio.user.identify("U123456",
  name: "Jane Doe",   // optional
  email: "jane.doe@example.com",  // optional
  imageUrl: "https://url/to/sample-image.png",  // optional
  traits: {  // optional
    "vip": true,
    "level": 13,
    "theme": "dark"
  }
);
```

## Traits <a name="traits"></a>

Traits are pieces of information about a user that you can include in an `identify` call. These traits can be diverse, ranging from demographics like age or gender, account-specific details like the user's subscription plan, or even data related to A/B test variations the user has encountered. The purpose of traits is to provide additional context and information about your users.

Including traits in your `identify` calls can be essential for personalization, analytics, and targeting. They help you understand your users better, segment them effectively, and tailor their experience based on their characteristics.

## User Reset <a name="user-reset"></a>

```dart
// To reset the user
testappio.user.reset()
```

The reset method allows you to reset the user's identity, effectively clearing their identification data.

> Use this when user changes like Signout / Logout

---

### UI Interactions <a name="ui-interactions"></a>
Make it effortless for users to provide feedback by showcasing the TestApp.io bar.

#### Use Cases
- **Feedback Collection**: Use `testappio.bar.show()` when you want to prompt users for feedback or when a particular app event or interaction occurs that you want insights on.

- **Custom User Experiences**: Use `testappio.bar.hide()` to hide the feedback bar during specific app interactions or when you don't want to distract users, for instance, during a payment process.

```dart
// To display the feedback bar
testappio.bar.show() //by default enabled

// To hide the feedback bar
testappio.bar.hide()
```

---

### Logging & Events <a name="logging-events"></a>
Monitor user activities, track errors, and understand screen transitions to optimize the app experience.

#### Parameters
| Parameter   | Description                              | Type      | Example Value                   | Constraints                                     |
|-------------|------------------------------------------|-----------|---------------------------------|-------------------------------------------------|
| `name`      | Name of the event/error/screen           | `String`  | `Item Purchased`              | Length: 1-120 characters                                               |
| `parameters`| Additional event details  (optional)               | `Map<String, dynamic>` | `{"item": "Laptop"}`       | Max 10 key-value pairs. Key: 40 chars, Value: 120 chars |

```dart
// Logging a custom event
testappio.log.event("Item Purchased", {
  //optional params
  "id": 1,
  "item": "Laptop",
  "opt_for_sms": true
});

// Logging an error
testappio.log.error("Checkout Error", {
  //optional params
  "code": 500,
  "error": "Payment gateway timeout"
});

// Logging a screen transition
testappio.log.screen("User Profile", {
  //optional params
  "from": "Dashboard"
});
```

---


### Continuous Sessions <a name="continuous-sessions"></a>

The TestApp.io SDK employs a "continuous sessions" approach. This means that if a session becomes full or meets specific criteria, a new session is automatically initiated for the device, ensuring uninterrupted data capture.

### Application & Session Lifecycle <a name="app-lifecycle-sessions-events"></a>
The TestApp.io SDK seamlessly integrates with your app's lifecycle, automatically capturing key application events.


#### Session Events <a name="session-events"></a>

| Event                  | Description                                                           |
|------------------------|-----------------------------------------------------------------------|
| Session start          | Marks the beginning of a new user session.                             |
| Session end            | Indicates the end of the current session.                              |
| Session expired        | Triggered when a session is deemed too old and is automatically ended. |
| Session resumed        | Indicates that a previously paused or backgrounded session is resumed. |



#### Lifecycle Events <a name="lifecycle-events"></a>

| Event                  | Description                                                           |
|------------------------|-----------------------------------------------------------------------|
| Application opened     | Triggered when the app is launched.                                   |
| Application active     | Indicates that the app is in the foreground and receiving events.     |
| Application foreground | Triggered when the app transitions from the background to the foreground. |
| Application backgrounded | Triggered when the app goes into the background.                     |
| Application terminated | Indicates that the app has been terminated, either by the user or the system. |

In addition to application events, the SDK diligently manages session lifecycle events, ensuring insights into user session behaviors.



#### Offline Mode <a name="offline-mode"></a>
Network unavailable? No worries. The SDK is built for resilience. In scenarios where the user's device is offline, the SDK will continue to capture all events, errors, and feedback. Once the network is restored, the SDK will automatically send the accumulated data in batches, ensuring no data loss.

#### Efficient Networking
The SDK employs batching and compression to ensure optimal network usage. This means fewer requests, reduced data usage, and faster event delivery.

---

### Screenshots from a sample app <a name="screenshots"></a>

![TestApp.io SDK Screenshots from Sample App](https://f000.backblazeb2.com/file/help-testappio/2023/11/sdk_screenshots_o.png)


### FAQ <a name="faq"></a>

**Q: Is the SDK intended for production apps?**
A: No, the SDK is not intended for apps on the store. The SDK will not work in production environments.

**Q: How do I ensure accurate event tracking?**
A: Initialize the TestApp.io SDK before any other invocation using the `TestAppio.setup(...)` method as the first step in your app's launch process.

**Q: What happens if I exceed the maximum allowed properties for events?**
A: Events that exceed the allowed number of properties or character limits for keys and values might be truncated or ignored.

**Q: How does the SDK handle user identities?**
A: While the `TestAppio.user.identify(...)` method is optional, it's highly recommended. Identifying users aids in faster tester recognition, provides better context for feedback, and enhances overall data quality.

**Q: Does the SDK produce any console outputs?**
A: Yes, the SDK prints specific information to the console for debugging purposes. This helps developers understand the SDK's internal workings and quickly diagnose potential issues.

**Q: Are there any dependencies I should be aware of?**
A: No, the TestApp.io SDK does not have any external dependencies.

**Q: Where can I find a sample app or demo?**
A: You can explore a practical implementation of the SDK in our [sample application](https://testapp.io/sessions).

**Q: Are there any known issues with the SDK?**
A: Currently, there are no known issues. However, we recommend regularly checking this section or our GitHub repository for updates.

**Q: What is the status of the SDK?**
A: The SDK is currently in beta and available for all teams. Please note that this availability is subject to change. We are continually refining and improving, so we appreciate your feedback during this phase.

**Q: Are there any limitations on the number of events, users, or devices?**
A: As of now, there are no set limitations on the number of events, users, or devices. We aim to provide a seamless experience, and we're continuously monitoring usage to ensure optimal performance.

**Q: What should I do if I encounter issues with the SDK?**
A: If you face any issues or have suggestions, please create an issue on our GitHub repository or contact our support team at support@testapp.io.

---

## Privacy <a name="privacy"></a>

At TestApp.io, we deeply respect the privacy of our users and their end-users. Here are some of our commitments to ensure data privacy:

- **No Data Reselling**: We commit that we do not, and will not, sell any data that is collected via the TestApp.io SDK.

- **No Data Sharing**: We do not share any of the data collected through the SDK with third parties. Your data stays exclusively within the TestApp.io environment.

- **Minimal Data Collection**: We only collect the data necessary to offer our services. This includes data required for feedback, monitoring, logging, and other functionalities of the SDK. We do not collect personal data unless explicitly provided by the developer or user.

- **Secure Data Storage**: All data collected is securely stored in compliance with industry standards. We employ robust encryption practices to ensure the data's integrity and confidentiality.

- **Data Retention**: We only retain the data for as long as it is necessary to provide our services. Older data is periodically purged to ensure privacy.

- **Compliance**: We strive to ensure that our data collection and storage practices comply with international privacy regulations, including GDPR, CCPA, and others.

If you have any concerns or questions about privacy, please reach out to our team at [support@testapp.io](mailto:support@testapp.io).

---

### Feedback & Support <a name="feedback-support"></a>

Developers built [TestApp.io](https://testapp.io) to solve the pain of app distribution & feedback for mobile app development teams.

Join our [community](https://help.testapp.io/faq/join-our-community/) for feedback and support.

Check out our [Help Center](https://help.testapp.io/) for more info and other integrations.

Happy Testing 🎉