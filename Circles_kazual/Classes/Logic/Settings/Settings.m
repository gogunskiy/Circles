//
//  Settings.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/22/13.
//
//

#import "Settings.h"

@implementation Settings


+ (void) setObject:(id<NSCoding>)object forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
}

+ (id <NSCoding>) objectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
