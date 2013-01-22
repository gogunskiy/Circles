//
//  ChooseLevelPageLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/21/13.
//
//

#import "ChooseLevelPageLayer.h"

static NSString * const PAGE_BACKGROUND     = @"Background";
static NSString * const LEVELS_INFO         = @"Levels";
static NSString * const PAGE_COLS          = @"Cols";

static CGFloat const INITIAL_OFFSET_X         = 290.0;
static CGFloat const INITIAL_OFFSET_Y         = 730.0;

static CGFloat const DELTA_X                  = 200.0;
static CGFloat const DELTA_Y                  = 200.0;

@implementation ChooseLevelPageLayer

@synthesize delegate;
@synthesize info;

- (void)dealloc {
    
    [info release];
    [super dealloc];
}

- (void) initialize {
    [self setBackgroundImage:[info objectForKey:PAGE_BACKGROUND]];
    
    NSMutableArray * levels = [[NSMutableArray alloc] init];
    
    NSInteger cols = [[[self info] objectForKey:PAGE_COLS] intValue];
    NSInteger collsCounter = 0;
    
    CGFloat offsetX = INITIAL_OFFSET_X;
    CGFloat offsetY = INITIAL_OFFSET_Y;
    
    for (NSDictionary * levelInfo in [[self info] objectForKey:LEVELS_INFO]) {
        CCMenuItemLabel *levelButton = [CCMenuItemImage itemWithNormalImage:@"level.png" selectedImage:@"level.png" target:self selector:@selector(chooseLevelWithSender:)];
        
        if (collsCounter % cols == 0) {
            offsetX = INITIAL_OFFSET_X;
            offsetY -= DELTA_Y;
        } else {
            offsetX += DELTA_X;
        }
        [levelButton setTag:collsCounter ++];
        [levelButton setPosition:ccp(offsetX,offsetY)];
        
        [levels addObject:levelButton];
    }
    
    CCMenu *menu = [CCMenu menuWithArray:levels];
	[menu setPosition:ccp(0,0)];
	[self addChild: menu z:-1];

    [levels release];
}

- (void) chooseLevelWithSender:(id)sender {
    NSDictionary * levelInfo = [[[self info] objectForKey:LEVELS_INFO] objectAtIndex:[sender tag]];
    [GAME startGameWithInfo:levelInfo];

}

@end
