//
//  RJContactDetailsView.m
//  RJContactDetailsViewDemo
//
//  Created by jun on 14-6-10.
//  Copyright (c) 2014年 rayjune Wu. All rights reserved.
//
#define screenBounds [UIScreen mainScreen].bounds

/*AlertView*/
#define RJContactDetailsViewDefaultWidth 260
#define RJContactDetailsViewDefaultHeight 300
#define RJContactDetailsViewDefaultTopBarHeight 80
#define RJHeadImageViewSizeLenth 80
#define RJTableViewCellHeight 44
#define RJContactNameLabelHeight 20
#define RJContactNameLabelFontSize 16

#define RJDefaultTopBarColor [UIColor colorWithRed:0.20392156862745098 green:0.596078431372549 blue:0.8588235294117647 alpha:1.0]

#import "RJContactDetailsView.h"

@interface UIImage (CornerImage)
- (UIImage *)cornerImageWithCornerRadius:(CGFloat)radius;
@end

@interface RJContactDetailsView ()<UITableViewDataSource,UITableViewDelegate>
/*Views*/
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UITableView *contactTableView;
@property (nonatomic,strong) UIImageView *contactHeadImageView;
@property (nonatomic,strong) UILabel *contactNameLabel;
@property (nonatomic,strong) UIImageView *topBarImageView;
@property (nonatomic,strong) UIButton *intoDetailsButton;
@property (nonatomic,strong) NSArray *contactPhones;
@end

@implementation RJContactDetailsView

- (id)initWithHeadImage:(UIImage *)image contactName:(NSString *)name phones:(NSArray *)phones
{
    self = [super initWithFrame:screenBounds];
    if (self) {
        _contactPhones = phones;
        //Default Appearance
        _headImage = image;
        _contactName = name;
        _topBarColor = [UIColor blueColor];
        _intoDetailsButtonNormalTextColor = [UIColor blackColor];
        _intoDetailsButtonHightlightedTextColor = [UIColor lightTextColor];
        self.opaque = YES;
        self.alpha = 1;
        
        [self _setUpViews];
    }
    return self;
}

- (void)_setUpViews
{
    /*Background View*/
    _backgroundView = [[UIView alloc] initWithFrame:screenBounds];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.0;
    
    UITapGestureRecognizer *tapBackgroundGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tapBackgroundGesture.numberOfTapsRequired = 1;
    [self.backgroundView addGestureRecognizer:tapBackgroundGesture];
    
    [self addSubview:_backgroundView];
    
    /*Alert View*/
    _alertView = [self _alertView];
    [self addSubview:_alertView];
}

- (UIView *)_alertView
{
    int alertViewHeight = RJContactDetailsViewDefaultTopBarHeight + RJHeadImageViewSizeLenth/2 + RJContactNameLabelHeight + RJTableViewCellHeight;
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RJContactDetailsViewDefaultWidth, alertViewHeight)];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.center = CGPointMake(CGRectGetWidth(screenBounds)/2, CGRectGetHeight(screenBounds)/2);
    alertView.layer.cornerRadius = 5.0;
    alertView.clipsToBounds = YES;
    
    /*Topbar*/
    _topBarImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(alertView.frame), RJContactDetailsViewDefaultTopBarHeight)];
    _topBarImageView.backgroundColor = _topBarColor;
    [alertView addSubview:_topBarImageView];
    
    /*Contact head imageview*/
    _contactHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, RJHeadImageViewSizeLenth, RJHeadImageViewSizeLenth)];
    _contactHeadImageView.image = [_headImage cornerImageWithCornerRadius:_headImage.size.width/2];
    _contactHeadImageView.center = CGPointMake(CGRectGetWidth(alertView.frame)/2, RJContactDetailsViewDefaultTopBarHeight);
    [alertView addSubview:_contactHeadImageView];
    
    /*Contact Name Label*/
    _contactNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contactHeadImageView.frame), CGRectGetWidth(alertView.frame),RJContactNameLabelHeight)];
    _contactNameLabel.textAlignment = NSTextAlignmentCenter;
    _contactNameLabel.font = [UIFont boldSystemFontOfSize:RJContactNameLabelFontSize];
    _contactNameLabel.textColor = [UIColor blackColor];
    _contactNameLabel.text = _contactName;
    [alertView addSubview:_contactNameLabel];
    
    /*table view*/
    if ([_contactPhones count]>0) {
        int cellCount = MIN([_contactPhones count], 3);
        _contactTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contactNameLabel.frame), RJContactDetailsViewDefaultWidth, RJTableViewCellHeight*cellCount)];
        _contactTableView.rowHeight = RJTableViewCellHeight;
        _contactTableView.delegate = self;
        _contactTableView.dataSource = self;
        [alertView addSubview:_contactTableView];
        
        //alert AlertView height
        alertViewHeight = alertViewHeight + RJTableViewCellHeight * cellCount;
        alertView.bounds = CGRectMake(0, 0, RJContactDetailsViewDefaultWidth, alertViewHeight);
    }

    /*Into detail button*/
    _intoDetailsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _intoDetailsButton.frame = CGRectMake(0, alertViewHeight-RJTableViewCellHeight, RJContactDetailsViewDefaultWidth, RJTableViewCellHeight);
    _intoDetailsButton.backgroundColor = [UIColor lightGrayColor];
    [_intoDetailsButton addTarget:self action:@selector(intoDetaisTouched:) forControlEvents:UIControlEventTouchUpInside];
    _intoDetailsButton.titleLabel.font = [UIFont systemFontOfSize:RJContactNameLabelFontSize];
    [_intoDetailsButton setTitleColor:_intoDetailsButtonNormalTextColor forState:UIControlStateNormal];
    [_intoDetailsButton setTitleColor:_intoDetailsButtonHightlightedTextColor forState:UIControlStateHighlighted];
    [_intoDetailsButton setTitle:_intoDetailsButtonTitle?_intoDetailsButtonTitle:NSLocalizedString(@"More details", @"详情") forState:UIControlStateNormal];
    [alertView addSubview:_intoDetailsButton];
    
    return alertView;
}

#pragma mark - Setters
- (void)setTopBarColor:(UIColor *)topBarColor
{
    _topBarImageView.backgroundColor = topBarColor;
}

- (void)setHeadImage:(UIImage *)headImage
{
    [self.contactHeadImageView setImage:[headImage cornerImageWithCornerRadius:headImage.size.width/2]];
}

- (void)setContactName:(NSString *)contactName
{
    self.contactNameLabel.text = contactName;
}

- (void)setContactNameLabelTextColor:(UIColor *)contactNameLabelTextColor
{
    self.contactNameLabel.textColor = contactNameLabelTextColor;
}

- (void)setIntoDetailsButtonNormalTextColor:(UIColor *)intoDetailsButtonNormalTextColor
{
    [_intoDetailsButton setTitleColor:intoDetailsButtonNormalTextColor forState:UIControlStateNormal];
}

- (void)setIntoDetailsButtonHightlightedTextColor:(UIColor *)intoDetailsButtonHightlightedTextColor
{
    [_intoDetailsButton setTitleColor:intoDetailsButtonHightlightedTextColor forState:UIControlStateHighlighted];
}

- (void)setIntoDetailsButtonTitle:(NSString *)intoDetailsButtonTitle
{
    [_intoDetailsButton setTitle:intoDetailsButtonTitle forState:UIControlStateNormal];
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contactPhones count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(contactTableView:cellForRowAtIndexPath:phones:)]) {
        return [self.dataSource contactTableView:tableView cellForRowAtIndexPath:indexPath phones:self.contactPhones];
    }
    return nil;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(contactTableViewDidSelectPhone:)]) {
        [self.delegate contactTableViewDidSelectPhone:self.contactPhones[indexPath.row]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Actions
- (void)intoDetaisTouched:(UIButton *)detailsButton
{
    if ([self.delegate respondsToSelector:@selector(contactDetailsViewDidTouchedIntoDetails:)]) {
        [self.delegate contactDetailsViewDidTouchedIntoDetails:self];
    }
    [self dismiss];
}

#pragma mark - Animations
- (void)triggerBounceAnimations
{
    self.alertView.alpha = 0;
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3f;
    //animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.alertView.layer addAnimation:animation forKey:nil];
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.backgroundView setAlpha:0.4];
                         [self.alertView setAlpha:1.0];
                     }
                     completion:^(BOOL finished){
                         //
                     }];
}

#pragma mark - Show and dismiss
- (void)show
{
    [self triggerBounceAnimations];
    
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    if (!window){
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    [window addSubview:self];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end


@implementation UIImage (CornerImage)
- (UIImage *)cornerImageWithCornerRadius:(CGFloat)radius
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    // Add a clip before drawing anything, in the shape of an rounded rect
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    
    [[UIBezierPath bezierPathWithRoundedRect:bounds
                                cornerRadius:radius] addClip];
    // Draw your image
    [self drawInRect:bounds];
    
    // Get the image,
    UIImage *result= UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return result;
}
@end
