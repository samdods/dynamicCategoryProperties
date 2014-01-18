# Dynamic Accessors for Category Properties

This is the source code to complement the [blog post I wrote][1].

Using the methods defined in this `NSObject` category, you can simplify implementation of properties in your own categories.

Simply add the `NSObject+DZLCategoryProperties` to your project and in any category that you have declared properties.

If you have a category interface as in the following example:

```
@interface Person (XYZAdditions)
@property (strong, nonatomic) NSString *xyz_nickname;
@property (strong, nonatomic) Company *xyz_employer;
@end
```

The simply declare the properties as dynamic and call from `+load` one of the methods in this `NSObject+DZLCategoryProperties` category to implement the getters and setters for your properties at runtime.
```objc
@implementation Person (XYZAdditions)
@dynamic nickname;
@dynamic employer;

+ (void)load
{
  // implement for all properties (where methods are not already defined)
  [self DZL_implementDynamicPropertyAccessors];
  
  // or implement only for specific property specified by name
  [self DZL_implementDynamicPropertyAccessorsForPropertyName:@"xyz_nickname"];
  
  // or implement only for specific properties matching regular expression
  [self DZL_implementDynamicPropertyAccessorsForPropertyMatching:@"^xyz_"];
}

@end
```

## Shorthand

Define `DZL_CP_SHORTHAND` in your project's precompiled header in order to take advantage of the shorthand versions of the method described above, for example:

In **MyAwesomeApp-Prefix.pch**
```objc 
#define DZL_CP_SHORTHAND
```

This allows you to use the following shorthand methods:
* `+[NSObject implementDynamicPropertyAccessors]`
* `+[NSObject implementDynamicPropertyAccessorsForPropertyName:]`
* `+[NSObject implementDynamicPropertyAccessorsForPropertyMatching:]`

## The problem that this solves

Usually, you might define a simple object-type property in a category as follows:

```objc
@interface UIView (DZLAdditions)
@property (strong, nonatomic) NSString *name;
@end

static const void *nameKey = &nameKey;

@implementation UIView (DZLAdditions)

- (NSString *)name
{
  return objc_getAssociatedObject(self, nameKey);
}

- (void)setName:(NSString *)name
{
  objc_setAssociatedObject(self, nameKey, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
```

If you add multiple properties, you have to define the getter and setter for each property. And the worst bit is that all these getters and setters will look almost identical.

#Installing

Add the `NSObject+DZLCategoryProperties` directory to your project, and optionally define `DZL_CP_SHORTHAND` in your project's precompiled header file.

# Finally...

If you like this project, why not [follow me on twitter][2]?

[1]: http://samdods.github.io/blog/2014/01/04/dynamic-accessors-for-category-properties/
[2]: http://twitter.com/dodsios
