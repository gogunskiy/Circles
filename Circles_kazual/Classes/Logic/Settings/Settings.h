//
//  Settings.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/22/13.
//
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

+ (void) setObject:(id<NSCoding>)object forKey:(NSString *)key;
+ (id <NSCoding>) objectForKey:(NSString *)key;

@end
