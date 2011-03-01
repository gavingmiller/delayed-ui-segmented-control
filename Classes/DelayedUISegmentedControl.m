//
//  DelayedUISegmentedControl.m
//
//  Created by Gavin Miller on 10-02-18.
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

#import "DelayedUISegmentedControl.h"

#define TIME_INTERVAL 0.25

@implementation DelayedUISegmentedControl

@synthesize timer;
@synthesize target, action;


- (void)segmentAction:(UISegmentedControl *)sender {
	self.timer = [NSTimer scheduledTimerWithTimeInterval:TIME_INTERVAL target:self selector:@selector(delaySegmentAction) userInfo:nil repeats:NO];
}

- (void)addTarget:(id)targetValue action:(SEL)actionValue forControlEvents:(UIControlEvents)events {
	self.target = targetValue;
	self.action = actionValue;
	
	[super addTarget:self action:@selector(segmentAction:) forControlEvents:events];
}

- (void)delaySegmentAction {
	[self sendAction:self.action to:self.target forEvent:nil];
}

- (void)dealloc {
	[timer release];
	
	[super dealloc];
}

@end
