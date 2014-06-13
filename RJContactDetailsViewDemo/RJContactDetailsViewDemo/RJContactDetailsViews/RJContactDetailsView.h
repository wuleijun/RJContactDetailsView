//
//  RJContactDetailsView.h
//  RJContactDetailsViewDemo
//
//  Created by jun on 14-6-10.
//  Copyright (c) 2014年 rayjune Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RJContact;
@protocol RJContactDetailsViewDelegate;
@protocol RJContactDetailsViewDataSource;

@interface RJContactDetailsView : UIView
@property (nonatomic,weak) id<RJContactDetailsViewDelegate> delegate;
@property (nonatomic,weak) id<RJContactDetailsViewDataSource> dataSource;

/*You can set following properties to alter appearance*/
@property (nonatomic,strong) UIColor *topBarColor;
@property (nonatomic,strong) UIImage *headImage;
@property (nonatomic,strong) NSString *contactName;
@property (nonatomic,strong) UIColor *contactNameLabelTextColor;
@property (nonatomic,strong) UIColor *intoDetailsButtonNormalTextColor;
@property (nonatomic,strong) UIColor *intoDetailsButtonHightlightedTextColor;
@property (nonatomic,strong) NSString *intoDetailsButtonTitle;

- (id)initWithHeadImage:(UIImage *)image contactName:(NSString *)name phones:(NSArray *)phones;
- (void)show;
- (void)dismiss;
@end

@protocol RJContactDetailsViewDelegate <NSObject>

- (void)contactTableViewDidSelectPhone:(NSString *)phone;
- (void)contactDetailsViewDidTouchedIntoDetails:(RJContactDetailsView *)contactDetailsView;
@end

@protocol RJContactDetailsViewDataSource <NSObject>
@required
- (UITableViewCell *)contactTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath phones:(NSArray *)phones;
@end