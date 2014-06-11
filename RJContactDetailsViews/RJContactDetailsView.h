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

- (id)initWithContact:(RJContact *)contact;
- (void)show;
- (void)dismiss;
@end

@protocol RJContactDetailsViewDelegate <NSObject>

- (void)contactDetailsViewDidSelectPhone:(NSString *)phone;
- (void)contactDetailsViewDidTouchedIntoDetails:(RJContactDetailsView *)contactDetailsView;
@end

@protocol RJContactDetailsViewDataSource <NSObject>
@required
- (UITableViewCell *)contactTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath phones:(NSArray *)phones;
@end