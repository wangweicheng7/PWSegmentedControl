//
//  ViewController.m
//  PWSegmentedControl
//
//  Created by Paul Wang on 16/1/30.
//  Copyright © 2016年 Paul Wang. All rights reserved.
//

#import "ViewController.h"
#import "PWSegmentedControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
