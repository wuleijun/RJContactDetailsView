//
//  RJContact.h
//  RJContactDetailsViewDemo
//
//  Created by jun on 14-6-11.
//  Copyright (c) 2014年 rayjune Wu. All rights reserved.
//

/*It is a example for contact model!*/

#import <Foundation/Foundation.h>

@interface RJContact : NSObject
@property (nonatomic,copy) UIImage *headImage;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSArray *phones;
@end