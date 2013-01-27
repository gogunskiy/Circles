//
//  GameResultLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/20/13.
//
//

#import "GameResultLayer.h"

@implementation GameResultLayer

@synthesize result;
@synthesize delegate;

- (id)init {
    
    self = [super init];
    
    [self setBackgroundImage:@"resultlayer_background.png"];
    [self setFadeDuration:1.];

    
    return self;
}
- (void)dealloc
{
    [super dealloc];
}

- (void) show {
    [self addElements];
    [super show];
}

- (void) addElements {
	
    
	resulLabel_ = [CCLabelFX	labelWithString :[self result]
                                   fontName		:@"Helvetica"
                                   fontSize		:50
                                shadowOffset    :CGSizeMake(-4, -4)
                                 shadowBlur		:0.0f
                                shadowColor		:ccc4(0, 0, 0, 255)
                                  fillColor		:ccc4(255, 255, 255, 255)];
  
	resulLabel_.position = ccp(512, 500);
	[resulLabel_ setAnchorPoint:ccp(0.5, 0.5)];
    
	[self addChild:resulLabel_];

    
    CCMenuItemLabel *reset = [CCMenuItemImage itemWithNormalImage:@"restart-button.png" selectedImage:@"restart-button.png" block:^(id sender) {
        [[self delegate] restartButtonWasClicked];
    }];
    
    
    CCMenuItemLabel *chooseLevel = [CCMenuItemImage itemWithNormalImage:@"chooselevel-button.png" selectedImage:@"chooselevel-button.png" block:^(id sender) {
        [[self delegate] chooseLevelButtonWasClicked];
    }];

    CCMenuItemLabel *nextLevel = nil;
    
    if ([[self result] isEqualToString:WIN_RESULT]) {
        nextLevel = [CCMenuItemImage itemWithNormalImage:@"nextlevel-button.png" selectedImage:@"nextlevel-button.png" block:^(id sender) {
            [[self delegate] nextLevelButtonWasClicked];
        }];
    }
	
    CCMenu *menu = [CCMenu menuWithItems:reset, chooseLevel, nextLevel, nil];
	[menu alignItemsHorizontallyWithPadding:50];
	[menu setPosition:ccp(512,340)];

	[self addChild: menu z:1];
    
    [super addElements];
}



@end
