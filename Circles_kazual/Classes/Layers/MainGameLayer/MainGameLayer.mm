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


@interface MainGameLayer()


-(void) createMenu;
-(void) drawPathLineWithPoints:(NSArray *) points;

    
@end

@implementation MainGameLayer

+(CCScene *) scene
{

	CCScene *scene = [CCScene node];

	MainGameLayer *layer = [MainGameLayer node];
	
	[scene addChild:layer];

	return scene;
}

-(id) init
{
	if( (self=[super init])) {
		
		self.isTouchEnabled = YES;
		self.isAccelerometerEnabled = YES;
		
		[self initPhysics];
		
		[self createMenu];
        
        [self initDrawingLayer];
        
        [self initEntertainmentLayer];
		
        
        
        NSMutableDictionary * characterData = [Character characterDataByType:CHARACTER_TYPE_BRAIN];
        [characterData setObject:@"10" forKey:CHARACTER_GRAVITYSCALE];
        
        brain = [[Character alloc] initWithPosition:ccp(400,600) indefiener:1 data:characterData];
        
        [brain setWorld:world_];
        
        [self addChild:brain z:12];
        
        


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
	
    
    [drawingLayer_ release];
    
	[super dealloc];
}	

-(void) createMenu
{
	[CCMenuItemFont setFontSize:22];
	
    CCMenuItemLabel *start = [CCMenuItemFont itemWithString:@"Start" block:^(id sender){
        
        [brain enablePhysics];
        
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
