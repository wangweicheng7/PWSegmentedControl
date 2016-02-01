//
//  PWViewController.m
//  PWSegmentedControl
//
//  Created by Paul Wang on 02/01/2016.
//  Copyright (c) 2016 Paul Wang. All rights reserved.
//

#import "PWViewController.h"
#import "PWSegmentedControl.h"

@interface PWViewController ()

@end

@implementation PWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.translucent = NO;
    
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
}

@end
