//
//  PWSegmentedControl.m
//  PWNavigationTitleViewTest
//
//  Created by Paul Wang on 16/1/14.
//  Copyright © 2016年 Paul Wang. All rights reserved.
//

#import "PWSegmentedControl.h"

#define kDefaultItemWidth     60.0f
#define kDefaultTag           21210

@interface PWSegmentedControl (){
    NSMutableArray      *_titleMutArray;
    CGFloat             _itemWidth;
    CGFloat             _itemHeight;
    NSMutableArray      *_bgLabelArray;     // 背景标签数组
    NSMutableArray      *_labelArray;       // 主标签数组
    PWSegmentSelectBlock    _segmentSelectBlock;
}
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;
@end

@implementation PWSegmentedControl
@synthesize normalColor = _normalColor;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithItems:(NSArray<NSString *> *)items {
    self = [super initWithFrame:CGRectMake(0, 0, (kDefaultItemWidth)*items.count , 26)];
    if (self) {
        _titleMutArray = [NSMutableArray arrayWithArray:items];
        _bgLabelArray  = [NSMutableArray array];
        _labelArray    = [NSMutableArray array];
        _itemWidth     = self.frame.size.width/items.count;
        _itemHeight    = self.frame.size.height;
        _numberOfSegments = items.count;
    
        self.layer.borderWidth = 0.5f;
        [self initData];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _itemWidth = frame.size.width/_titleMutArray.count;
}



#pragma mark - getters
- (UIView *)tintView {
    if (!_tintView) {
        _tintView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/self.numberOfSegments, self.frame.size.height)];
        _tintView.backgroundColor = self.tintColor;
        _tintView.layer.masksToBounds = YES;
    }
    return _tintView;
}

- (UIColor *)tintColor {
    
    return super.tintColor?super.tintColor:[UIColor blueColor];
}

- (UIColor *)normalColor {
    if (!_normalColor) {
        _normalColor = [UIColor whiteColor];
    }
    return _normalColor;
}

#pragma mark - setters
- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    _selectedSegmentIndex = selectedSegmentIndex;
    [self itemDidSelectedAtIndex:selectedSegmentIndex];
}

- (void)setTintColor:(UIColor *)tintColor {
    super.tintColor = tintColor;
    [self resetUI];
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    [self resetUI];
}

- (void)initData {
    for (NSUInteger i = 0; i < _titleMutArray.count; i ++) {
        UILabel *bgLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * _itemWidth, 0, _itemWidth, _itemHeight)];
        bgLabel.backgroundColor = [UIColor whiteColor];
        bgLabel.textAlignment = NSTextAlignmentCenter;
        bgLabel.font = [UIFont systemFontOfSize:14];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemDidTapped:)];
        bgLabel.userInteractionEnabled = YES;
        [bgLabel addGestureRecognizer:tap];
        [_bgLabelArray addObject:bgLabel];
        [self addSubview:bgLabel];
        // 添加高亮Label
        UILabel *label = [[UILabel alloc] initWithFrame:bgLabel.frame];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [_labelArray addObject:label];
        [self.tintView addSubview:label];
    }
    [self addSubview:self.tintView];
    [self resetUI];
}

- (void)resetUI {
    NSUInteger i = 0;
    for (NSString *title in _titleMutArray) {
        UILabel *bgLabel = (UILabel *)[_bgLabelArray objectAtIndex:i];
        bgLabel.backgroundColor = self.normalColor;
        bgLabel.frame = CGRectMake(i * _itemWidth, 0, _itemWidth, _itemHeight);
        bgLabel.textColor = self.tintColor;
        bgLabel.text = title;
        bgLabel.tag = kDefaultTag + i;
        // 添加高亮Label
        UILabel *label = (UILabel *)[_labelArray objectAtIndex:i];
        label.backgroundColor = self.tintColor;
        label.textColor = self.normalColor;
        label.frame = bgLabel.frame;
        label.text = title;
        i ++;
    }
    //分割线
//    self.backgroundColor = self.tintColor;
    self.layer.borderColor = self.tintColor.CGColor;
    self.tintView.backgroundColor = self.tintColor;
}

- (void)itemDidTapped:(UITapGestureRecognizer *)tap {
    UILabel *label = (UILabel *)tap.view;
    NSUInteger index = label.tag - kDefaultTag;
    [self didSelectItemAtIndex:index];
    if ([label isKindOfClass:[UILabel class]]) {
        [self itemDidSelectedAtIndex:index];
    }
}

- (void)itemDidSelectedAtIndex:(NSUInteger)index {
    CGRect frame = self.tintView.frame;
    frame.origin.x = index * kDefaultItemWidth;
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(_labelArray) weakLabelArray = _labelArray;
    [UIView animateWithDuration:0.8
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         NSInteger i = 0;
                         for (UILabel *label in weakLabelArray) {
                             CGRect frame = label.frame;
                             frame.origin.x = (i-weakSelf.selectedSegmentIndex)*kDefaultItemWidth;
                             label.frame = frame;
                             i ++;
                         }
                         weakSelf.tintView.frame = frame;
                     } completion:^(BOOL finished) {
                         
                     }];
    if ([self.target respondsToSelector:self.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:@(index)];
#pragma clang diagnostic pop
    }
    
    if (_segmentSelectBlock) {
        _segmentSelectBlock(index);
    }
}

- (void)setTitles:(NSString *)title forIndex:(NSUInteger)index {
    [_titleMutArray replaceObjectAtIndex:index withObject:title];
}

- (void)didSelectItemAtIndex:(NSUInteger)index {
    self.selectedSegmentIndex = index;
}

- (void)setWidth:(CGFloat)width forSegmentAtIndex:(NSUInteger)segment {
    NSUInteger i = 0;
    CGFloat preItemWidth = 0.0;
    for (UILabel *label in _bgLabelArray) {
        if (i == segment) {
            label.frame = CGRectMake(preItemWidth, 0, width, _itemHeight);
        }else{
            label.frame = CGRectMake(preItemWidth, 0, _itemWidth, _itemHeight);
        }
        preItemWidth = label.frame.size.width;
    }
}

- (void)setTitleTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state {

}

- (void)addTarget:(id)target action:(SEL)action {
    self.target = target;
    self.selector = action;
}

- (void)itemDidSelected:(PWSegmentSelectBlock)segmentBlock {
    if (segmentBlock) {
        _segmentSelectBlock = segmentBlock;
    }
}

@end
