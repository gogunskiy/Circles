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
#import "Bonus.h"
#import "LevelContainer.h"
#import "FileManager.h"



@interface MainGameLayer()

-(void) drawPathLineWithPoints:(NSArray *) points;

- (void) enablePhysics ;
- (void) disablePhysics ;

- (void) finishLevel ;

- (void) calculateLevelResult;

- (void) startCheckingLevelConditions;
- (void) checkBonuses;

- (void) startObjectsAnimation;
- (void) stopObjectsAnimation;
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
    [levelWorldLayer_ release];
    
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



- (void) startCheckingLevelConditions {
    
    [self startObjectsAnimation];
    [self unscheduleUpdate];
    
    [self performSelector:@selector(finishLevel) withObject:nil afterDelay:1.5];
 }


- (void) startObjectsAnimation {
    for (Character * character in characters_) {
        [character startAnimation];
    }
}

- (void) stopObjectsAnimation {
    for (Character * character in characters_) {
        [character stopAnimation];
    }
}

- (void) checkBonuses {
    
    for (Bonus * bonus in bonuses_) {
        if ([bonus active]) {
            for (Character * character in characters_) {
                
                if (![[character role] isEqualToString:CHARACTER_ROLE_NEGATIVE] && [bonus intersectWithPosition:[character previousPos] size:CGSizeMake(100,100)]) {
                    
                    [bonus setActive:FALSE];
                    
                    [self removeChild:bonus cleanup:TRUE];
                    
                    [GAME addLevelScores:[bonus value]];
                    [GAME playEffect:SOUND_GET_BONUS];
                    
                    break;
                }
            }
        }
    }
}

- (void) finishLevel {
    
    [levelWorldLayer_ removeAllActions];
    [self stopObjectsAnimation];
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
    
    [GAME finishGameWithResult:@{GAME_RESULT : result}];
    
    [resultLayer_ setResult:result];
    [resultLayer_ setScore:[NSString stringWithFormat:@"%d", [currentLevel_ scores]]];
    [resultLayer_ setHighScore:[NSString stringWithFormat:@"%d", [GAME highScoreForLevelPage:[currentLevel_ pageIndex] levelIndex:[currentLevel_ levelIndex]]]];
    
    if ([result isEqualToString:WIN_RESULT]) {
        [GAME setHighScores:[currentLevel_ scores] levelPage:[currentLevel_ pageIndex] levelIndex:[currentLevel_ levelIndex]];
    }
    
    [self showResultLayer];
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
    [self checkBonuses];

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

}


#pragma mark ====  GAME INFO & PAUSE LAYER DELEGATE  ====

- (void) startButtonWasClicked; {
    
    [pauseLayer_ setStartButtonhEnabled:FALSE];
    
    [self enablePhysics];
    [self drawPathLineWithPoints:[drawingLayer_ points]];
    
    [self performSelector:@selector(startCheckingLevelConditions) withObject:nil afterDelay:3.5];

    [self stopDrawHelpLayer];
    
    // TO DO : uncomment to save paths
   // [[drawingLayer_ points] writeToFile:[FileManager checkAndCreateFile:[[currentLevel_ title] stringByAppendingString:@".plist"]] atomically:TRUE];
}

- (void) restartButtonWasClicked {
    [GAME restartLevel];
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
   // [drawingLayer_ reset];
}


@end
