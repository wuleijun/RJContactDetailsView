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



#import "RJContactDetailsView.h"
#import "RJContact.h"

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

@property (nonatomic,strong) RJContact *contact;
@end

@implementation RJContactDetailsView

- (id)initWithContact:(RJContact *)contact
{
    self = [super initWithFrame:screenBounds];
    if (self) {
        _contact = contact;
        self.opaque = YES;
        self.alpha = 1;
        [self _setUpViews];
    }
    return self;
}

- (void)_setUpViews
{
    /*Background View*/
    self.backgroundView = [[UIView alloc] initWithFrame:screenBounds];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.0;
    
    UITapGestureRecognizer *tapBackgroundGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tapBackgroundGesture.numberOfTapsRequired = 1;
    [self.backgroundView addGestureRecognizer:tapBackgroundGesture];
    
    [self addSubview:self.backgroundView];
    
    /*Alert View*/
    self.alertView = [self _alertView];
    [self addSubview:self.alertView];
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
    UIImageView *topBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(alertView.frame), RJContactDetailsViewDefaultTopBarHeight)];
    topBarView.backgroundColor = [UIColor blueColor];
    [alertView addSubview:topBarView];
    
    /*Contact head imageview*/
    self.contactHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, RJHeadImageViewSizeLenth, RJHeadImageViewSizeLenth)];
    self.contactHeadImageView.image = [self.contact.headImage cornerImageWithCornerRadius:self.contact.headImage.size.width/2];
    self.contactHeadImageView.center = CGPointMake(CGRectGetWidth(alertView.frame)/2, RJContactDetailsViewDefaultTopBarHeight);
    [alertView addSubview:self.contactHeadImageView];
    
    /*Contact Name Label*/
    self.contactNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contactHeadImageView.frame), CGRectGetWidth(alertView.frame),RJContactNameLabelHeight)];
    self.contactNameLabel.textAlignment = NSTextAlignmentCenter;
    self.contactNameLabel.font = [UIFont boldSystemFontOfSize:RJContactNameLabelFontSize];
    self.contactNameLabel.textColor = [UIColor blackColor];
    self.contactNameLabel.text = self.contact.name;
    [alertView addSubview:self.contactNameLabel];
    
    /*table view*/
    if ([self.contact.phones count]>0) {
        int cellCount = MIN([self.contact.phones count], 3);
        self.contactTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contactNameLabel.frame), RJContactDetailsViewDefaultWidth, RJTableViewCellHeight*cellCount)];
        self.contactTableView.rowHeight = RJTableViewCellHeight;
        self.contactTableView.delegate = self;
        self.contactTableView.dataSource = self;
        [alertView addSubview:self.contactTableView];
        
        //alert AlertView height
        alertViewHeight = alertViewHeight + RJTableViewCellHeight * cellCount;
        alertView.bounds = CGRectMake(0, 0, RJContactDetailsViewDefaultWidth, alertViewHeight);
    }

    /*Into detail button*/
    UIButton *intoDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    intoDetail.frame = CGRectMake(0, alertViewHeight-RJTableViewCellHeight, RJContactDetailsViewDefaultWidth, RJTableViewCellHeight);
    intoDetail.backgroundColor = [UIColor lightGrayColor];
    [intoDetail addTarget:self action:@selector(intoDetaisTouched:) forControlEvents:UIControlEventTouchUpInside];
    intoDetail.titleLabel.font = [UIFont systemFontOfSize:RJContactNameLabelFontSize];
    [intoDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [intoDetail setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    [intoDetail setTitle:NSLocalizedString(@"More details", @"详情") forState:UIControlStateNormal];
    [alertView addSubview:intoDetail];
    
    return alertView;
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contact.phones count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(contactTableView:cellForRowAtIndexPath:phones:)]) {
        return [self.dataSource contactTableView:tableView cellForRowAtIndexPath:indexPath phones:self.contact.phones];
    }else{
        return nil;
    }
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(contactDetailsViewDidSelectPhone:)]) {
        NSString *phone = self.contact.phones[indexPath.row];
        [self.delegate contactDetailsViewDidSelectPhone:phone];
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
