//
//  RootViewController.m
//  delayed-ui-segmented-controler
//
//  Created by Gavin Miller on 11-03-01.
//  Copyright 2011 RANDOMTYPE. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "RootViewController.h"
#import "DelayedUISegmentedControl.h"


@implementation RootViewController

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *DelayedCellIdentifier = @"DelayedCell";
	static NSString *RegularCellIdentifier = @"RegularCell";
	
    UITableViewCell *cell;
	
	if (indexPath.row == 0) {
		cell = [tableView dequeueReusableCellWithIdentifier:DelayedCellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DelayedCellIdentifier] autorelease];
		}
		
		// The DelayedUISegmentedControl follows all normal initialization patterns of UISegmentedControl
		UISegmentedControl *delayed = [[[DelayedUISegmentedControl alloc] 
										initWithItems:[NSArray arrayWithObjects: @"First", @"Second", nil]] autorelease];
		
		// Method call looks like a regular call, but comes with a TIME_INTERVAL delay; default is 0.25
		[delayed addTarget:self 
					action:@selector(segmentAction:)
		  forControlEvents:UIControlEventValueChanged];
		
		[delayed setFrame:CGRectMake(125.0f, 10.0f, 165.0f, 40.0f)];
		
		// Create Label
		UILabel *label = [[[UILabel alloc] init] autorelease];
		label.text = @"Delayed";
		[label setFrame:CGRectMake(15.0f, 10.0f, 70.0f, 40.0f)];
		
		// Add to cell
		[cell.contentView addSubview:delayed];
		[cell.contentView addSubview:label];
	}
	
	if (indexPath.row == 1) {
		cell = [tableView dequeueReusableCellWithIdentifier:RegularCellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RegularCellIdentifier] autorelease];
		}
		
		// The DelayedUISegmentedControl follows all normal initialization patterns of UISegmentedControl
		UISegmentedControl *regular = [[[UISegmentedControl alloc] 
										initWithItems:[NSArray arrayWithObjects: @"First", @"Second", nil]] autorelease];
		
		// Same method call as DelayedUISegmentedControl
		[regular addTarget:self 
					action:@selector(segmentAction:) 
		  forControlEvents:UIControlEventValueChanged];
		
		[regular setFrame:CGRectMake(125.0f, 10.0f, 165.0f, 40.0f)];
		
		// Create Label
		UILabel *label = [[[UILabel alloc] init] autorelease];
		label.text = @"Regular";
		[label setFrame:CGRectMake(15.0f, 10.0f, 70.0f, 40.0f)];
		
		// Add to cell
		[cell.contentView addSubview:regular];
		[cell.contentView addSubview:label];
	}

    return cell;
}

-(void) segmentAction:(UISegmentedControl *) sender {
	UIAlertView *alertView;
	int index = [sender selectedSegmentIndex];
	if (index == -1) {
		return;
	}
	
	if ([sender isMemberOfClass:[DelayedUISegmentedControl class]]) {
		NSLog(@"delayed segment action: %d", index);
		alertView = [[UIAlertView alloc] initWithTitle:@"Delayed Segment" message:@"This segment has been delayed. Notice the brief highlighting." delegate:nil cancelButtonTitle:@"Hide" otherButtonTitles:nil];
	} else {
		NSLog(@"regular segment action: %d", index);
		alertView = [[UIAlertView alloc] initWithTitle:@"Regular Segment" message:@"This segment was not delayed. No highlighting of touched segment." delegate:nil cancelButtonTitle:@"Hide" otherButtonTitles:nil];
	}
	
	[alertView show];
	sender.selectedSegmentIndex = -1;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}


@end

