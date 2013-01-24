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

static CGFloat const TRANSITION_SPEED               = 0.5;
static CGFloat const CHARACTER_TRANSITION_SPEED     = 1.5;


static CGFloat const TRANSITION_DELTA         = 1050;


@interface ChooseLevelPageLayer ()

- (CCSprite *) addCharacterWithImage:(NSString *)imageName position:(CGPoint)position;
- (void) moveCharacter:(CCSprite *)character fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)point;

@end

@implementation ChooseLevelPageLayer

@synthesize delegate;
@synthesize info;

- (void)dealloc {
    
    [info release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        /*
        leftPusher_  = [self addCharacterWithImage:@"Angry.png"    position:ccp(-150,384)];
        rightPusher_ = [self addCharacterWithImage:@"BlackMan.png" position:ccp(1100,384)];
    */
      }
    
    return self;
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
    
    [self setOpacity:0];
}

- (void) chooseLevelWithSender:(id)sender {
    
    NSDictionary * levelInfo = [[[self info] objectForKey:LEVELS_INFO] objectAtIndex:[sender tag]];
    [GAME startGameWithInfo:levelInfo];

}

- (void) leftIn {
    [self setPosition:ccp(-TRANSITION_DELTA,0)];
    [self setOpacity:255];
    [self runAction:[CCMoveBy actionWithDuration:TRANSITION_SPEED position:ccp(TRANSITION_DELTA,0)]];
}

- (void) leftOut {
     [self runAction:[CCSequence actions:[CCMoveBy actionWithDuration:TRANSITION_SPEED position:ccp(-TRANSITION_DELTA,0)], [CCCallFunc actionWithTarget:self selector:@selector(remove)], nil]];
    
}

- (void) rightIn {
    [self setPosition:ccp(TRANSITION_DELTA,0)];
    [self setOpacity:255];
    [self runAction:[CCMoveBy actionWithDuration:TRANSITION_SPEED position:ccp(-TRANSITION_DELTA,0)]];
}

- (void) rightOut {
    [self runAction:[CCSequence actions:[CCMoveBy actionWithDuration:TRANSITION_SPEED position:ccp(TRANSITION_DELTA,0)], [CCCallFunc actionWithTarget:self selector:@selector(remove)], nil]];
}


- (void) remove {
    [self setOpacity:0];
    [self removeFromParentAndCleanup:FALSE];
}

- (void) show {
    [self setOpacity:255];
}

- (CCSprite *) addCharacterWithImage:(NSString *)imageName position:(CGPoint)position {
    
    CCSprite * sprite = [CCSprite spriteWithFile:imageName];
    [sprite setPosition:position];
    [self addChild:sprite z:1];
    
    return sprite;
}

- (void) moveCharacter:(CCSprite *)character fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    [character setPosition:fromPoint];
    [character runAction:[CCMoveTo actionWithDuration:CHARACTER_TRANSITION_SPEED position:toPoint]];
}

@end
