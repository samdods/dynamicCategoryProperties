//
//  NSObject+DZLCategoryProperties.h
//  DynamicCategoryProperties
//
//  Created by Sam Dods on 30/12/2013.
//  Copyright (c) 2013 Sam Dods. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DZLCategoryProperties)
+ (void)DZL_implementDynamicPropertyAccessors;
+ (void)DZL_implementDynamicPropertyAccessorsForPropertyName:(NSString *)propertyName;
+ (void)DZL_implementDynamicPropertyAccessorsForPropertyMatching:(NSString *)regexString;
@end


#ifdef DZL_CP_SHORTHAND
@interface NSObject (DZLCategoryPropertiesShorthand)
+ (void)implementDynamicPropertyAccessors;
+ (void)implementDynamicPropertyAccessorsForPropertyName:(NSString *)propertyName;
+ (void)implementDynamicPropertyAccessorsForPropertyMatching:(NSString *)regexString;
@end
#endif
