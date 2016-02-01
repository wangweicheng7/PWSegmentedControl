//
//  PWSegmentedControl.h
//  
//
//  Created by Paul Wang on 16/1/14.
//  Copyright © 2016年 Paul Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PWSegmentSelectBlock)(NSUInteger index);

@interface PWSegmentedControl : UIView

@property (null_resettable,nonatomic, strong) UIView    *tintView;

- (nonnull instancetype)initWithItems:(nullable NSArray<NSString*> *)items; // items can be NSStrings. control is automatically sized to fit content
@property(nonatomic,readonly) NSUInteger numberOfSegments;
- (void)setTitles:( NSArray< NSString *> * _Nonnull)titles forIndex:(NSUInteger)index;
- (void)setWidth:(CGFloat)width forSegmentAtIndex:(NSUInteger)segment;

@property(nonatomic) NSInteger selectedSegmentIndex;
@property(null_resettable,nonatomic,strong) UIColor *tintColor;
@property(nullable,nonatomic,strong) UIColor *normalColor;
- (void)setTitleTextAttributes:(nullable NSDictionary *)attributes forState:(UIControlState)state;
- (void)addTarget:(nullable id)target action:(nullable SEL)action;
- (void)itemDidSelected:(nullable PWSegmentSelectBlock)segmentBlock;

@end
