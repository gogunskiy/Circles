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
-(void) initDrawingLayer;
    
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
		
        ball = [[Character alloc] initWithPosition:ccp(300, 550)
                                              filename:@"hero.png"
                                            indefiener:12];
        [ball setWorld:world_];
        
        [self addChild:ball z:12];
        
        
        
         ball2 = [[Character alloc] initWithPosition:ccp(700, 550)
                                                               filename:@"hero2.png"
                                                             indefiener:13];
        [ball2 setWorld:world_];
         
        [self addChild:ball2 z:12];

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
	// Default font size will be 22 points.
	[CCMenuItemFont setFontSize:22];
	
	// Reset Button]
    
    CCMenuItemLabel *start = [CCMenuItemFont itemWithString:@"Start" block:^(id sender){
        
        [ball disablePhysics];
        [ball generateSquareBodyWithWidth:50 height:50];
        

        [ball2 disablePhysics];
        [ball2 generateSquareBodyWithWidth:50 height:50];
        
       [ball body]->ApplyForce( [ball body]->GetMass() * -world_->GetGravity(), [ball body]->GetWorldCenter() );
       
        [ball body]->SetGravityScale(-10);
        
        [ball2 body]->SetGravityScale(10);
        
	}];
	
	CCMenuItemLabel *reset = [CCMenuItemFont itemWithString:@"Reset" block:^(id sender){
		[[CCDirector sharedDirector] replaceScene: [MainGameLayer scene]];
        
      	}];
	
	CCMenu *menu = [CCMenu menuWithItems:start, reset, nil];
	
	[menu alignItemsVerticallyWithPadding:30];

	[menu setPosition:ccp(960,700)];
	
	
	[self addChild: menu z:-1];	
}

-(void) initDrawingLayer {
    drawingLayer_ = [[DrawingLayer alloc] init];
    [drawingLayer_ setDelegate:self];
    [self addChild:drawingLayer_];
}




#pragma mark ====  DRAWING LAYER DELEGATE  ====

- (void)drawingLayer:(DrawingLayer *)DrawingLayer endDrawingWithPoints:(NSArray *)points {
    
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




@end
