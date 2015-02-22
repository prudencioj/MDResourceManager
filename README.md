# MDResourceManager

[![Build Status](https://travis-ci.org/prudencioj/MDResourceManager.svg?branch=master)](https://travis-ci.org/prudencioj/MDResourceManager)
[![Version](https://img.shields.io/cocoapods/v/MDResourceManager.svg?style=flat)](http://cocoadocs.org/docsets/MDResourceManager)
[![License](https://img.shields.io/cocoapods/l/MDResourceManager.svg?style=flat)](http://cocoadocs.org/docsets/MDResourceManager)
[![Platform](https://img.shields.io/cocoapods/p/MDResourceManager.svg?style=flat)](http://cocoadocs.org/docsets/MDResourceManager)


## iOS Resource Management, the Android way.
Provide resources independently of your code. Manage different sizes, strings depending on the device type or orientation.
Inspired in the Resource management of Android.

Easily extended, you can provide your own criterias. e.g. handle different values depending on your product jurisdictions.


## How it works

It is inspired by the resource management in [Android](http://developer.android.com/guide/topics/resources/providing-resources.html#BestMatch) . It is a simpler version, with less rules, and adapted to the iOS ecosystem. 

You can create resource files that apply only when some criterias are meet. 
You can create a resource file name "resources-ipad-land.plist". and another "resources-ipad-port.plist".
If you are using an ipad in landscape the values returned will be from the first file.

The rules are defined in the following table, each configuration has its own qualifier values that you can use in your resource filename.

| Configuration | Qualifier values | Description  |
| :--------------------| :---------------------------| :----------------------------|
|  Device model |  e.g. ipad iphone iphone6 iphon6plus  |  Specify the device model. You can be specific to apply the rule to more cases, or have a criteria more generic | 
|  Orientation |  e.g. port land  | Device orientation |                                                     


## Usage

### Create resource files

The first step is to create your resource files with .plist extension, with your criterias.

![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)

### Create the MDResourceManager

Create a MDResourceManager and give it your criterias. Bear in mind that the order is important, the best match algoritm considers the order you give your criterias.

You can also create your own criterias.

```objective-c

NSArray *criterias = @[[[MDDeviceResourceCriteria alloc] init],
                       [[MDOrientationResourceCriteria alloc] init]];
    
MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"dimensions"
                                                                             criterias:criterias];
    
```

### Ask the manager for values 

```objective-c

CGFloat labelFontSize1 = [resourceManager floatForKey:@"labelFontSize1"];
CGFloat labelFontSize2 = [resourceManager floatForKey:@"labelFontSize2"];

```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

MDResourceManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "MDResourceManager"

## Author

Joao Prudencio, joao.prudencio@mindera.com

## License

MDResourceManager is available under the MIT license. See the LICENSE file for more info.