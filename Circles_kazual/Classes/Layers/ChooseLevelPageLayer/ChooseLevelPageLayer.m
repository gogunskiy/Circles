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
static NSString * const PAGE_COLS           = @"Cols";

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

- (void) addArrows;

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
  
        [self addArrows];
      }
    
    return self;
}

- (void) addArrows {
    
    leftArrow_= [CCMenuItemImage itemWithNormalImage:@"arrow-left.png" selectedImage:@"arrow-left.png" block:^(id sender) {
        [delegate showPreviousPage];
    }];
    
    
    rightArrow_ = [CCMenuItemImage itemWithNormalImage:@"arrow-right.png" selectedImage:@"arrow-right.png" block:^(id sender) {
        [delegate showNextPage];
    }];
    
    [leftArrow_ setPosition:ccp(100,384)];
    [rightArrow_ setPosition:ccp(900,384)];
    
    [leftArrow_  setVisible:FALSE];
    [rightArrow_ setVisible:FALSE];
    
    CCMenu *menu = [CCMenu menuWithItems:leftArrow_, rightArrow_, nil];
	[menu setPosition:ccp(0,0)];
    [menu setAnchorPoint:ccp(0,0)];
	[self addChild: menu z:100];

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
    
    [delegate setLayerEnabled:FALSE];
    [self setPosition:ccp(-TRANSITION_DELTA,0)];
    [self setOpacity:255];
    [self runAction:[CCSequence actions:[CCMoveBy actionWithDuration:TRANSITION_SPEED position:ccp(TRANSITION_DELTA,0)],[CCCallFunc actionWithTarget:self selector:@selector(show)], nil]];
}

- (void) leftOut {
    
    [leftArrow_  setVisible:FALSE];
    [rightArrow_ setVisible:FALSE];
    [delegate setLayerEnabled:FALSE];
    [self runAction:[CCSequence actions:[CCMoveBy actionWithDuration:TRANSITION_SPEED position:ccp(-TRANSITION_DELTA,0)], [CCCallFunc actionWithTarget:self selector:@selector(remove)], nil]];
}

- (void) rightIn {
    
    [delegate setLayerEnabled:FALSE];
    [self setPosition:ccp(TRANSITION_DELTA,0)];
    [self setOpacity:255];
    [self runAction:[CCSequence actions:[CCMoveBy actionWithDuration:TRANSITION_SPEED position:ccp(-TRANSITION_DELTA,0)],[CCCallFunc actionWithTarget:self selector:@selector(show)], nil]];
}

- (void) rightOut {
   
    [leftArrow_  setVisible:FALSE];
    [rightArrow_ setVisible:FALSE];
    [delegate setLayerEnabled:FALSE];
    [self runAction:[CCSequence actions:[CCMoveBy actionWithDuration:TRANSITION_SPEED position:ccp(TRANSITION_DELTA,0)], [CCCallFunc actionWithTarget:self selector:@selector(remove)], nil]];
}


- (void) remove {
    [self setOpacity:0];
    [delegate setLayerEnabled:TRUE];
    [self removeFromParentAndCleanup:FALSE];
}
        

- (void) show {
    [self setOpacity:255];
    [delegate setLayerEnabled:TRUE];
    
    [leftArrow_  setVisible:[delegate needLeftArrowForPage:self]];
    [rightArrow_ setVisible:[delegate needRightArrowForPage:self]];
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
