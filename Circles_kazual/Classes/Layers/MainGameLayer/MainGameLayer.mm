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
#import "FileManager.h"



@interface MainGameLayer()

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
		
		[self initPauseLayer];
        [self initInfoLayer];
        [self initDrawingLayer];
        [self initDrawHelpLayer];
        [self initEntertainmentLayer];
		[self initResultLayer];
        
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
    [infoLayer_ release];
    [pauseLayer_ release];
    [resultLayer_ release];
    
	[super dealloc];
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
    
    NSString * result = ([characters_ count] == countOfMatch) ? WIN_RESULT : LOSE_RESULT;
    
    [resultLayer_ setResult:result];
    [self showResultLayer];
    
    [GAME finishGameWithResult:@{GAME_RESULT : result}];
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

- (void)drawingLayer:(DrawingLayer *)DrawingLayer startDrawingWithResoution:(NSString *)resolution {
    [self hidePauseMenuButtonClicked];
    [self stopDrawHelpLayer];
}

-(void)drawingLayer:(DrawingLayer *)DrawingLayer endDrawingWithPoints:(NSArray *)points {

    
}

- (void)drawingLayer:(DrawingLayer *)DrawingLayer drawingCanceledWithResoution:(NSString *)resolution {
    [[SimpleAudioEngine sharedEngine] playEffect:@"ErrorSound.wav"];
}


#pragma mark ====  GAME INFO & PAUSE LAYER DELEGATE  ====

- (void) startButtonWasClicked; {
    [pauseLayer_ setIsTouchEnabled:FALSE];
    
    [self enablePhysics];
    [self drawPathLineWithPoints:[drawingLayer_ points]];
    
    [self stopDrawHelpLayer];
    
    // TO DO : uncomment to save paths
   // [[drawingLayer_ points] writeToFile:[FileManager checkAndCreateFile:[[currentLevel_ title] stringByAppendingString:@".plist"]] atomically:TRUE];
}

- (void) restartButtonWasClicked {
    [GAME loadMainGameLayer];
}

- (void) chooseLevelButtonWasClicked {
    [GAME loadMainMenuScene];
}

- (void) nextLevelButtonWasClicked {
    [GAME startGameFromPrevoiusLevel];
}

- (void) showPauseMenuButtonClicked {
    [infoLayer_ show];
}

- (void) hidePauseMenuButtonClicked {
    [infoLayer_ hide];
}

- (void) clearLineButtonClicked {
    [drawingLayer_ reset];
}


@end
