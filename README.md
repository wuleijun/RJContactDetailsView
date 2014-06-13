RJContactDetailsView
====================

RJContactDetailsView is a beautiful view for displaying contact information including head image,name and phone numbers.

#Screenshot

![Resize icon](https://raw.githubusercontent.com/wuleijun/RJContactDetailsView/master/screenshot.png)

# Install

## Manually
Download the zip of the project and put the classes `RJContactDetailsView.h` and `RJContactDetailsView.m` in your project. There a simple model:`RJContact.h` and `RJContact.m` in the demo.It is a model to show the view.

## CocoaPods
1.Add this to your Podfile: ```pod 'RJContactDetailsView', '>= 0.0.2'```

2.Install the pod(s) by running `pod install`.

3.`#import "RJContactDetailsView.h"`

To learn more about CocoaPods, please visit their [website](http://cocoapods.org).

How to use
=========
	#import "RJContactDetailsView.h"

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

###Delegate and Datasource

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
	
	
#License
In fact,you can use these codes in any ways.I will be glad if you fork or star it.