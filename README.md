# PWSegmentedControl

[![CI Status](http://img.shields.io/travis/Paul Wang/PWSegmentedControl.svg?style=flat)](https://travis-ci.org/Paul Wang/PWSegmentedControl)
[![Version](https://img.shields.io/cocoapods/v/PWSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/PWSegmentedControl)
[![License](https://img.shields.io/cocoapods/l/PWSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/PWSegmentedControl)
[![Platform](https://img.shields.io/cocoapods/p/PWSegmentedControl.svg?style=flat)](http://cocoapods.org/pods/PWSegmentedControl)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

For using.

```
	PWSegmentedControl *seg = [[PWSegmentedControl alloc] initWithItems:@[@"最好玩",@"个性化",@"最好玩",@"个性化"]];
    seg.layer.cornerRadius = 13;
    seg.layer.masksToBounds = YES;
    seg.tintView.layer.cornerRadius = 13;
    seg.tintColor = [UIColor purpleColor];
    seg.selectedSegmentIndex = 3;
    [seg itemDidSelected:^(NSUInteger index) {
        NSLog(@"%ld",index);
    }];
    self.navigationItem.titleView = seg;
```

## Requirements

## Installation

PWSegmentedControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PWSegmentedControl"
```

## Author

Paul Wang, 809405366@qq.com

## License

PWSegmentedControl is available under the MIT license. See the LICENSE file for more info.
