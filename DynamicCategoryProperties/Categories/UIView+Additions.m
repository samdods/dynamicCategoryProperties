//
//  UIView+Additions.m
//  DynamicCategoryProperties
//
//  Created by Sam Dods on 30/12/2013.
//  Copyright (c) 2013 Sam Dods. All rights reserved.
//

#import "UIView+Additions.h"
#import "NSObject+CategoryProperties.h"

@implementation UIView (Additions)
@dynamic name;

+ (void)load
{
    [self implementDynamicPropertyAccessors];
}

@end
