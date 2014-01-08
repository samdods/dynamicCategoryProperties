//
//  NSObject+DZLCategoryProperties.h
//  DynamicCategoryProperties
//
//  Created by Sam Dods on 30/12/2013.
//  Copyright (c) 2013 Sam Dods. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DZLCategoryProperties)
+ (void)implementDynamicPropertyAccessors;
+ (void)implementDynamicPropertyAccessorsForPropertyName:(NSString *)propertyName;
+ (void)implementDynamicPropertyAccessorsForPropertyMatching:(NSString *)regexString;
@end
