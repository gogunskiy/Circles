//
//  GameResultLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/20/13.
//
//

#import "GameResultLayer.h"
#import "CCAnimatedLabel.h"

static NSInteger const MOVE_BY = 150;

@implementation GameResultLayer

@synthesize result;
@synthesize score;
@synthesize highScore;
@synthesize delegate;

- (id)init {
    
    self = [super init];
    
    [self setPosition:ccp(0, -150)];
    [self addElements];
    
    return self;
}
- (void)dealloc
{
    [super dealloc];
}

- (void) show {
    [resulLabel_ setString:[self result]        animated:FALSE];
    [scoreLabel_ setString:[self score]         animated:TRUE];
    [highScoreLabel_ setString:[self highScore] animated:FALSE];
    
    [nextLevel_ setIsEnabled:[[self result] isEqualToString:WIN_RESULT]];
    
    [self runAction:[CCMoveBy actionWithDuration:0.3 position:ccp(0,MOVE_BY)]];
}

- (void) hide {
    [self runAction:[CCMoveBy actionWithDuration:0.3 position:ccp(0,-MOVE_BY)]];
}

- (void) addElements {
	
    
	resulLabel_ = [CCAnimatedLabel	labelWithString :[self result]
                                   fontName		:@"Helvetica"
                                   fontSize		:50
                                shadowOffset    :CGSizeMake(-4, -4)
                                 shadowBlur		:0.0f
                                shadowColor		:ccc4(0, 0, 0, 255)
                                  fillColor		:ccc4(255, 255, 255, 255)];
	resulLabel_.position = ccp(512, 160);
	[resulLabel_ setAnchorPoint:ccp(0.5, 0.5)];
    
	[self addChild:resulLabel_];

    
	scoreLabel_ = [CCAnimatedLabel	labelWithString :[self score]
                                   fontName		:@"Helvetica"
                                   fontSize		:50
                             shadowOffset    :CGSizeMake(-4, -4)
                                 shadowBlur		:0.0f
                                shadowColor		:ccc4(0, 0, 0, 255)
                                  fillColor		:ccc4(255, 255, 255, 255)];
    
	scoreLabel_.position = ccp(412, 100);
    [scoreLabel_ setDelay:0.02];
    [scoreLabel_ setDelta:10];
	[scoreLabel_ setAnchorPoint:ccp(0.5, 0.5)];
    
	[self addChild:scoreLabel_];
    
    highScoreLabel_ = [CCAnimatedLabel	labelWithString :[self highScore]
                              fontName		:@"Helvetica"
                              fontSize		:50
                        shadowOffset    :CGSizeMake(-4, -4)
                            shadowBlur		:0.0f
                           shadowColor		:ccc4(0, 0, 0, 255)
                             fillColor		:ccc4(255, 255, 255, 255)];
    
	highScoreLabel_.position = ccp(612, 100);
	[highScoreLabel_ setAnchorPoint:ccp(0.5, 0.5)];
    
	[self addChild:highScoreLabel_];
    
    CCMenuItemImage *reset = [CCMenuItemImage itemWithNormalImage:@"restart-button.png" selectedImage:@"restart-button.png" block:^(id sender) {
        [[self delegate] restartButtonWasClicked];
    }];
    
    
    CCMenuItemImage *chooseLevel = [CCMenuItemImage itemWithNormalImage:@"chooselevel-button.png" selectedImage:@"chooselevel-button.png" block:^(id sender) {
        [[self delegate] chooseLevelButtonWasClicked];
    }];

  
    CCMenu *menu = [CCMenu menuWithItems:reset, chooseLevel, nil];
	[menu alignItemsHorizontallyWithPadding:30];
	[menu setPosition:ccp(140,100)];

	[self addChild:menu z:1];
    
    nextLevel_ = [CCMenuItemImage itemWithNormalImage:@"nextlevel-button.png" selectedImage:@"nextlevel-button.png" block:^(id sender) {
        [[self delegate] nextLevelButtonWasClicked];
    }];
    
    CCMenu *menu2 = [CCMenu menuWithItems:nextLevel_, nil];
    [menu2 alignItemsHorizontallyWithPadding:250];
    [menu2 setPosition:ccp(960,100)];
    
    [self addChild:menu2 z:1];

    
    [super addElements];
}



@end
