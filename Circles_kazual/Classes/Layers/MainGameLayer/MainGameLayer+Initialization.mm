//
//  MainGameLayer+Initialization.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/10/13.
//
//

#import "MainGameLayer+Initialization.h"
#import "LevelContainer.h"
#import "Character.h"


@implementation MainGameLayer (Initialization)


- (void) initPhysics
{

	b2Vec2 gravity;
	gravity.Set(0.0f, 0.0f);
	world_ = new b2World(gravity);
	
    world_->SetAllowSleeping(true);
	world_->SetContinuousPhysics(true);
	
	mdebugDraw_ = new GLESDebugDraw( PTM_RATIO );
	world_->SetDebugDraw(mdebugDraw_);
	
	uint32 flags = 0;
    flags += b2Draw::e_shapeBit;
	//		flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
	//		flags += b2Draw::e_centerOfMassBit;
	mdebugDraw_->SetFlags(flags);
}


- (void) initLevel {
    [self initBackground];
    [self initCharacters];
    [self initBonuses];
}

- (void) initBackground {
    
}

- (void) initCharacters {
    
    characters_ = [[NSMutableArray alloc] init];
    
    for (NSDictionary * characterInfo in [currentLevel_ characters]) {
        NSMutableDictionary * characterData = [Character characterDataByType:[characterInfo objectForKey:CHARACTER_FILE]];
        
        CGPoint characterPosition = CGPointFromString([characterInfo objectForKey:CHARACTER_POSITION]);
        
        [characterData setObject:[characterInfo objectForKey:CHARACTER_GRAVITYSCALE] forKey:CHARACTER_GRAVITYSCALE];
        [characterData setObject:[characterInfo objectForKey:CHARACTER_POSITION]     forKey:CHARACTER_POSITION];
        [characterData setObject:[characterInfo objectForKey:CHARACTER_ROLE]         forKey:CHARACTER_ROLE];
        
        Character * character = [[Character alloc] initWithPosition:characterPosition indefiener:1 data:characterData];
        [character setWorld:world_];
        [self addChild:character];
        
        [characters_ addObject:character];
        
        [character release];
    }
}

- (void) initBonuses {
    
}

- (void) initDrawingLayer {
    drawingLayer_ = [[DrawingLayer alloc] init];
    [drawingLayer_ setDelegate:self];
    [drawingLayer_ reset];
    [self addChild:drawingLayer_ z:1];
}



- (void) initEntertainmentLayer {
    entertainmentLayer_ = [[EntertainmentLayer alloc] init];
    [self addChild:entertainmentLayer_ z:3];
}


- (void) initInfoLayer {
    infoLayer_ = [[GameInfoLayer alloc] init];
    [infoLayer_ setDelegate:self];
    [self addChild:infoLayer_ z:2];
}


@end
