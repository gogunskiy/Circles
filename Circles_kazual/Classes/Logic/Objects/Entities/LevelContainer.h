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
static NSString * const PAGE_INDEX          = @"PageIndex";
static NSString * const LEVEL_INDEX         = @"LevelIndex";
static NSString * const LEVEL_BACKGROUND    = @"Background";

@interface LevelContainer : NSObject

@property (nonatomic, assign) NSInteger levelIndex;
@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * backgroundImage;
@property (nonatomic, retain) NSArray * characters;

- (void) setWithInfo:(NSDictionary *)info ;



@end
