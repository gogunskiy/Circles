//
//  LevelsLoader.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/22/13.
//
//

#import "LevelsLoader.h"
#import "FileManager.h"

#define RESOURCE_FILE(file) [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:(file)]

static NSString * const LEVELS_INFO_FILE = @"Levels_List.plist";

@interface LevelsLoader ()

@end

@implementation LevelsLoader

- (NSDictionary *) levelDataForLevel:(NSString *)level {
    
    NSDictionary * levelData = [NSDictionary dictionaryWithContentsOfFile:RESOURCE_FILE(level)];
    
    return levelData;
}


- (NSArray *) levelsInformation {
    
    NSString * fileName = [FileManager checkAndCreateFile:LEVELS_INFO_FILE];
    
    return [NSArray arrayWithContentsOfFile:fileName];
}

@end
