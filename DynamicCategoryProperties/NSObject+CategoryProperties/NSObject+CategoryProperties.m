//
//  NSObject+CategoryProperties.m
//  DynamicCategoryProperties
//
//  Created by Sam Dods on 30/12/2013.
//  Copyright (c) 2013 Sam Dods. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+CategoryProperties.h"


@implementation NSObject (CategoryProperties)

+ (void)implementDynamicPropertyAccessors
{
    [self implementDynamicPropertyAccessorsForPropertyMatching:nil];
}


+ (void)implementDynamicPropertyAccessorsForPropertyName:(NSString *)propertyName
{
    [self implementDynamicPropertyAccessorsForPropertyMatching:[NSString stringWithFormat:@"^%@$", propertyName]];
}


+ (void)implementDynamicPropertyAccessorsForPropertyMatching:(NSString *)regexString
{
    [self enumeratePropertiesMatching:regexString withBlock:^(objc_property_t property) {
        [self implementAccessorsIfNecessaryForProperty:property];
    }];
}


+ (void)enumeratePropertiesMatching:(NSString *)regexString withBlock:(void(^)(objc_property_t property))block
{
    NSParameterAssert(block);
    uint count = 0;
    objc_property_t *properties = class_copyPropertyList(self, &count);
    for (uint i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        BOOL isMatch = !regexString || ({
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:0 error:NULL];
            [regex numberOfMatchesInString:propertyName options:0 range:NSMakeRange(0, propertyName.length)];
        });
        if (isMatch) {
            block(property);
        }
    }
    free(properties);
}


+ (void)implementAccessorsIfNecessaryForProperty:(objc_property_t)property
{
    NSArray *attributes = [self attributesOfProperty:property];
    BOOL isDynamic = [attributes containsObject:@"D"];
    if (!isDynamic) {
        return;
    }
    
    BOOL isObjectType = YES;
    NSString *customGetterName;
    NSString *customSetterName;
    
    for (NSString *attribute in attributes) {
        unichar firstChar = [attribute characterAtIndex:0];
        switch (firstChar) {
            case 'T': isObjectType = [attribute characterAtIndex:1] == '@'; break;
            case 'G': customGetterName = [attribute substringFromIndex:1]; break;
            case 'S': customSetterName = [attribute substringFromIndex:1]; break;
            default: break;
        }
    }
    if (!isObjectType) {
        return;
    }
    
    const char *name = property_getName(property);
    const void *key = &key;
    key++;
    
    [self implementGetterIfNecessaryForPropertyName:name customGetterName:customGetterName key:key];
    
    BOOL isReadonly = [attributes containsObject:@"R"];
    if (!isReadonly) {
        [self implementSetterIfNecessaryForPropertyName:name customSetterName:customSetterName key:key attributes:attributes];
    }
}


+ (NSArray *)attributesOfProperty:(objc_property_t)property
{
    return [[NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding] componentsSeparatedByString:@","];
}


+ (void)implementGetterIfNecessaryForPropertyName:(char const *)propertyName customGetterName:(NSString *)customGetterName key:(const void *)key
{
    SEL getter = NSSelectorFromString(customGetterName ?: [NSString stringWithFormat:@"%s", propertyName]);
    [self implementMethodIfNecessaryForSelector:getter parameterTypes:NULL block:^id(id _self) {
        return objc_getAssociatedObject(self, key);
    }];
}


+ (void)implementSetterIfNecessaryForPropertyName:(char const *)propertyName customSetterName:(NSString *)customSetterName key:(const void *)key attributes:(NSArray *)attributes
{
    BOOL isCopy = [attributes containsObject:@"C"];
    BOOL isRetain = [attributes containsObject:@"&"];
    objc_AssociationPolicy associationPolicy = isCopy ? OBJC_ASSOCIATION_COPY : isRetain ? OBJC_ASSOCIATION_RETAIN : OBJC_ASSOCIATION_ASSIGN;
    BOOL isNonatomic = [attributes containsObject:@"N"];
    if (isNonatomic) {
        objc_AssociationPolicy nonatomic = OBJC_ASSOCIATION_COPY_NONATOMIC - OBJC_ASSOCIATION_COPY;
        associationPolicy += nonatomic;
    }
    
    SEL setter = NSSelectorFromString(customSetterName ?: [NSString stringWithFormat:@"set%c%s:", toupper(*propertyName), propertyName + 1]);
    [self implementMethodIfNecessaryForSelector:setter parameterTypes:"@" block:^(id _self, id var) {
        objc_setAssociatedObject(self, key, var, associationPolicy);
    }];
}


+ (void)implementMethodIfNecessaryForSelector:(SEL)selector parameterTypes:(const char *)types block:(id)block
{
    BOOL instancesRespondToSelector = [self instancesRespondToSelector:selector];
    if (!instancesRespondToSelector) {
        IMP implementation = imp_implementationWithBlock(block);
        class_addMethod(self, selector, implementation, types);
    }
}

@end
