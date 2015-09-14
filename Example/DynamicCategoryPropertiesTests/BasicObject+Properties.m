//
//  BasicObject+Properties.m
//  DynamicCategoryProperties
//
//  Created by John McKerrell on 14/09/2015.
//  Copyright © 2015 Sam Dods. All rights reserved.
//

#import "BasicObject+Properties.h"

#import "NSObject+DZLCategoryProperties.h"

@implementation BasicObject (Properties)

@dynamic propertyA;
@dynamic propertyB;

+ (void)load
{
    [self DZL_implementDynamicPropertyAccessors];
}

@end
