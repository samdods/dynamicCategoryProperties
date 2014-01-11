//
//  ViewController.m
//  DynamicCategoryProperties
//
//  Created by Sam Dods on 30/12/2013.
//  Copyright (c) 2013 Sam Dods. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Additions.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.name = @"Donald Duck";
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"The view is named '%@'", self.view.name);
}

@end
