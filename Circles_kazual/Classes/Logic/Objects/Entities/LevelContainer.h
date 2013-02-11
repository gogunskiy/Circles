//
//  LevelContainer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/17/13.
//
//

#import <Foundation/Foundation.h>

static NSString * const TITLE               = @"Title";
static NSString * const CHARACTERS          = @"Characters";
static NSString * const BONUSES             = @"Bonuses";
static NSString * const PAGE_INDEX          = @"PageIndex";
static NSString * const LEVEL_INDEX         = @"LevelIndex";
static NSString * const LEVEL_WORLD         = @"World";

@interface LevelContainer : NSObject

@property (nonatomic, assign) NSInteger levelIndex;
@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSDictionary * worldInfo;
@property (nonatomic, retain) NSArray * characters;
@property (nonatomic, retain) NSArray * bonuses;

- (void) setWithInfo:(NSDictionary *)info ;



@end
