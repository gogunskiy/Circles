//
//  HelloWorldLayer.mm
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 11/3/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "MainGameLayer.h"
#import "PhysicsObject.h"
#import "MainGameLayer+Initialization.h"
#import "Character.h"
#import "LevelContainer.h"

@interface MainGameLayer()


-(void) createMenu;
-(void) drawPathLineWithPoints:(NSArray *) points;

- (void) enablePhysics ;
- (void) disablePhysics ;

- (void) finishLevel ;

- (void) calculateLevelResult;

@end

@implementation MainGameLayer

-(id) init
{
	if( (self=[super init])) {
		
		self.isTouchEnabled = YES;
		self.isAccelerometerEnabled = YES;
		
        gameRunning_ = FALSE;
        
		[self initPhysics];
		
		[self createMenu];
        
        [self initDrawingLayer];
        
        [self initEntertainmentLayer];
		
        currentLevel_ = [GAME currentLevel];
        
        [self initLevel];
        
        
        [self scheduleUpdate];
        
        [self schedule:@selector(update) interval:0.1];
	}
    
	return self;
}

-(void) dealloc
{
	delete world_;
	world_ = NULL;
	
	delete mdebugDraw_;
	mdebugDraw_ = NULL;
	
    [characters_ release];
    
    [entertainmentLayer_ release];
    [drawingLayer_ release];
    
	[super dealloc];
}	

-(void) createMenu
{
	[CCMenuItemFont setFontSize:22];
	
    CCMenuItemLabel *start = [CCMenuItemFont itemWithString:@"Start" block:^(id sender){
        
        [self enablePhysics];
        
        [self drawPathLineWithPoints:[drawingLayer_ points]];
        
	}];
	
	CCMenuItemLabel *reset = [CCMenuItemFont itemWithString:@"Reset" block:^(id sender){
		[[CCDirector sharedDirector] replaceScene: [MainGameLayer scene]];
        
      	}];
	
	CCMenu *menu = [CCMenu menuWithItems:start, reset, nil];
	
	[menu alignItemsVerticallyWithPadding:30];

	[menu setPosition:ccp(960,700)];
	
	
	[self addChild: menu z:-1];	
}

- (void) enablePhysics {
    
    for (Character * character in characters_) {
        [character enablePhysics];
    }
    
    gameRunning_ = TRUE;
}

- (void) disablePhysics  {
    
    gameRunning_ = FALSE;
    
    for (Character * character in characters_) {
        [character disablePhysics];
    }
}

- (void) updateObjects {

    for (Character * character in characters_) {
        
        if ([character body] != NULL) {
            b2Vec2 customGravity = b2Vec2(character.gravityScale.x, character.gravityScale.y);
            [character body]->ApplyForce(customGravity , [character body]->GetPosition());
        }
    }
      
}

- (void) update {
    
    int notInGameObjects = 0;
    
    for (Character * character in characters_) {
        if (([character state] == SLEEPING ) || ([character state] ==  OUT)) {
            notInGameObjects ++;
        }
    }
    
    if (notInGameObjects == [characters_ count] && gameRunning_) {
        [self finishLevel];
        [self unscheduleUpdate];
        [self unschedule:@selector(update)];
    }
}

- (void) finishLevel {

    [self calculateLevelResult];
}

- (void) calculateLevelResult {
    
    NSInteger countOfMatch = 0;
    
    for (Character * character in characters_) {
        
        if ((([[character role] isEqualToString:CHARACTER_ROLE_POSITIVE]) && ([character state] == SLEEPING))) {
            countOfMatch ++;
            
            continue;
        }
        
        if (([[character role] isEqualToString:CHARACTER_ROLE_NEGATIVE]) && ([character state] == OUT)) {
            countOfMatch ++;
            
            continue;
        }

        if ([[character role] isEqualToString:CHARACTER_ROLE_LONELY]) {
            for (Character * lonelyCharacter in characters_) {
                if ([[lonelyCharacter role] isEqualToString:CHARACTER_ROLE_LONELY]) {
                    if ([character intersectWithCharacter:lonelyCharacter] && [character state] == SLEEPING) {
                        countOfMatch ++;
                        break;
                    }
                }
            }
        }
    }
        
    [GAME finishGameWithResult:@{@"charactersCount" : [NSString stringWithFormat:@"%d",[characters_ count]], @"countOfMatches" : [NSString stringWithFormat:@"%d", countOfMatch]}];
}

-(void) draw
{
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	world_->DrawDebugData();
	
	kmGLPopMatrix();
}

-(void) update: (ccTime) dt
{
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
    
    [self updateObjects];

	world_->Step(dt, velocityIterations, positionIterations);
}


-(void) drawPathLineWithPoints:(NSArray *) points {
    
    b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0);
    
    b2Body* groundBody = world_->CreateBody(&groundBodyDef);
	
	b2EdgeShape groundBox;
    
    for (int i = 1; i < [points count]; i++) {
        
        CGPoint point1 = CGPointFromString([points objectAtIndex:i-1]);
        CGPoint point2 = CGPointFromString([points objectAtIndex:i]);
        
        groundBox.Set(b2Vec2(point1.x/PTM_RATIO,point1.y/PTM_RATIO), b2Vec2(point2.x/PTM_RATIO,point2.y/PTM_RATIO));
        groundBody->CreateFixture(&groundBox,0);
        
    }
}

#pragma mark ====  DRAWING LAYER DELEGATE  ====

-(void)drawingLayer:(DrawingLayer *)DrawingLayer endDrawingWithPoints:(NSArray *)points {

    
}

- (void)drawingLayer:(DrawingLayer *)DrawingLayer drawingCanceledWithResoution:(NSString *)resolution {
    [[SimpleAudioEngine sharedEngine] playEffect:@"ErrorSound.wav"];
}


@end
