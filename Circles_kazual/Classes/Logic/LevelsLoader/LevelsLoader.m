//
//  LevelsLoader.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/22/13.
//
//

#import "LevelsLoader.h"
#import "FileManager.h"


static NSString * const LEVELS_INFO_FILE        = @"Levels_List.plist";
static NSString * const HIGH_SCORES_INFO_FILE   = @"HighScores.plist";

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

- (void) setScores:(NSInteger)scores levelPage:(NSInteger)levelPage levelIndex:(NSInteger)levelIndex {
    
    NSMutableDictionary * scores_dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[FileManager checkAndCreateFile:HIGH_SCORES_INFO_FILE]];
    [scores_dictionary setObject:[NSString stringWithFormat:@"%d", scores] forKey:[NSString stringWithFormat:@"%d,%d", levelPage, levelIndex]];
    [scores_dictionary writeToFile:[FileManager checkAndCreateFile:HIGH_SCORES_INFO_FILE] atomically:TRUE];
}

- (NSInteger) scoreForLevelPage:(NSInteger)levelPage levelIndex:(NSInteger)levelIndex {
    
    NSMutableDictionary * scores_dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[FileManager checkAndCreateFile:HIGH_SCORES_INFO_FILE]];
 
    return [[scores_dictionary objectForKey:[NSString stringWithFormat:@"%d,%d", levelPage, levelIndex]] intValue];
}


@end
