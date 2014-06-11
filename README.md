RJContactDetailsView
====================

RJContactDetailsView is a beautiful view for displaying contact information including head image,name and phone numbers.

#Screenshot

![Resize icon](https://raw.githubusercontent.com/wuleijun/RJContactDetailsView/master/screenshot.png)

# Install

## Manually
Download the zip of the project and put the classes `RJContactDetailsView.h` and `RJContactDetailsView.m` in your project. There a simple model:`RJContact.h` and `RJContact.m` in the demo.It is a model to show the view.

## CocoaPods
1.Add this to your Podfile: ```pod 'RJContactDetailsView', '>= 0.0.1'```

2.Install the pod(s) by running `pod install`.

3.`#import "RJContactDetailsView.h"` and `#import "RJContact.h"`

To learn more about CocoaPods, please visit their [website](http://cocoapods.org).

How to use
=========
	#import "RJContactDetailsView.h"
	#import "RJContact.h"

	//init contact model,you can custom it.
	RJContact *contact = [[RJContact alloc] init];
    contact.name = @"rayjune";
    contact.headImage = [UIImage imageNamed:@"head"];
    contact.phones = @[@"15011111111",@"15022222222",@"15033333333",@"057188888888",@"123456"];
    
    RJContactDetailsView *contactDetailsView = [[RJContactDetailsView alloc] initWithContact:contact];
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
	- (void)contactDetailsViewDidSelectPhone:(NSString *)phone
	{
	    NSLog(@"You touched %@!",phone);
	}
	- (void)contactDetailsViewDidTouchedIntoDetails:(RJContactDetailsView *)contactDetailsView
	{
        NSLog(@"You touched into more details button!");
	}
	
	
#License
In fact,you can use these codes in any ways.I will be glad if you fork or star it.