//
//  RJViewController.m
//  RJContactDetailsViewDemo
//
//  Created by jun on 14-6-11.
//  Copyright (c) 2014年 rayjune Wu. All rights reserved.
//

#import "RJViewController.h"
#import "RJContactDetailsView.h"

@interface RJViewController ()<RJContactDetailsViewDataSource,RJContactDetailsViewDelegate>

@end

@implementation RJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showContactView:(id)sender {
    
    RJContactDetailsView *contactDetailsView = [[RJContactDetailsView alloc] initWithHeadImage:[UIImage imageNamed:@"head"] contactName:@"rayjune" phones:@[@"15088888888",@"15067755555"]];
    {
        //set appearance
        contactDetailsView.topBarColor = [UIColor blueColor];
        contactDetailsView.intoDetailsButtonNormalTextColor = [UIColor blackColor];
        contactDetailsView.intoDetailsButtonHightlightedTextColor = [UIColor lightTextColor];
        contactDetailsView.contactNameLabelTextColor = [UIColor blackColor];
        contactDetailsView.intoDetailsButtonTitle = @"More details";
        
        contactDetailsView.headImage = [UIImage imageNamed:@"head"];
        contactDetailsView.contactName = @"rayjune";
    }
    contactDetailsView.dataSource = self;
    contactDetailsView.delegate = self;
    [contactDetailsView show];
}

#pragma mark - RJContactDetailsView DataSource
- (UITableViewCell *)contactTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath phones:(NSArray *)phones
{
    static NSString *cellID = @"CellID";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    cell.textLabel.text = phones[indexPath.row];
    return cell;
}

#pragma mark - RJContactDetailsView Delegate
- (void)contactTableViewDidSelectPhone:(NSString *)phone
{
    NSLog(@"You touched %@!",phone);
}
- (void)contactDetailsViewDidTouchedIntoDetails:(RJContactDetailsView *)contactDetailsView
{
    NSLog(@"You touched into more details button!");
}


@end
