//
//  LevelsLoader.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/22/13.
//
//

#import <Foundation/Foundation.h>

static NSString * const LEVEL_FILE_INFO = @"File";

@interface LevelsLoader : NSObject

- (NSDictionary *) levelDataForLevel:(NSString *)level;
- (NSArray *) levelsInformation;

@end
