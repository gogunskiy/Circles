//
//  Settings.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/22/13.
//
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

+ (void) setObject:(NSString *)object forKey:(NSString *)key;
+ (NSString *) objectForKey:(NSString *)key;

@end
