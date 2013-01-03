//
//  HelloWorldLayer.mm
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 11/3/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

// Import the interfaces
#import "MainGameLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"



#import "PhysicsObject.h"

enum {
	kTagParentNode = 1,
};


@interface LinePoint : NSObject
@property(nonatomic, assign) CGPoint pos;
@property(nonatomic, assign) float width;
@end


@implementation LinePoint
@synthesize pos;
@synthesize width;

- (NSString *)description {
    return NSStringFromCGPoint(pos);
}
@end

#pragma mark - HelloWorldLayer

@interface MainGameLayer()
-(void) initPhysics;
-(void) addNewSpriteAtPosition:(CGPoint)p;
-(void) createMenu;
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
		
        
        points = [[NSMutableArray alloc] init];
        
		// enable events
		
        CCLayerColor * color = [[CCLayerColor alloc] initWithColor:ccc4(255,255,255,255) width:900 height:768];
        [self addChild:color z:-1];
        [color release];
        
		self.isTouchEnabled = YES;
		self.isAccelerometerEnabled = YES;
		CGSize s = [CCDirector sharedDirector].winSize;
		
		// init physics
		[self initPhysics];
		
		// create reset button
		[self createMenu];
		
        ball = [[PhysicsObject alloc] initWithPosition:ccp(260, 550)
                                              filename:@"hero.png"
                                            indefiener:12];
        [ball setWorld:world];
        [ball generateCirlceBodyWithRadius:50 bodyType:b2_staticBody];
        
        [self addChild:ball z:12];
        
        
        
         ball2 = [[PhysicsObject alloc] initWithPosition:ccp(640, 550)
                                                               filename:@"hero.png"
                                                             indefiener:13];
        [ball2 setWorld:world];
        [ball2 generateCirlceBodyWithRadius:50  bodyType:b2_staticBody];
        
        [self addChild:ball2 z:12];


		//Set up sprite
		
#if 1
		// Use batch node. Faster
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"blocks.png" capacity:100];
		spriteTexture_ = [parent texture];
#else
		// doesn't use batch node. Slower
		spriteTexture_ = [[CCTextureCache sharedTextureCache] addImage:@"blocks.png"];
		CCNode *parent = [CCNode node];
#endif
		[self addChild:parent z:0 tag:kTagParentNode];
		
		
	//	[self addNewSpriteAtPosition:ccp(s.width/2, s.height/2)];
		
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tap screen" fontName:@"Marker Felt" fontSize:32];
		[self addChild:label z:0];
		[label setColor:ccc3(127,127,127)];
		label.position = ccp( s.width/2, s.height-50);
		
		[self scheduleUpdate];
	}
	return self;
}

-(void) dealloc
{
	delete world;
	world = NULL;
	
	delete m_debugDraw;
	m_debugDraw = NULL;
	
    [points release];
    
	[super dealloc];
}	

-(void) createMenu
{
	// Default font size will be 22 points.
	[CCMenuItemFont setFontSize:22];
	
	// Reset Button]
    
    CCMenuItemLabel *start = [CCMenuItemFont itemWithString:@"Start" block:^(id sender){
        
        world->DestroyBody([ball body]);
        [ball release];
        ball = [[PhysicsObject alloc] initWithPosition:ccp(300, 550)
                                              filename:nil
                                            indefiener:12];
        [ball setWorld:world];
        [ball generateCirlceBodyWithRadius:40 bodyType:b2_dynamicBody];
        
        [self addChild:ball z:10];
        
        
        
        world->DestroyBody([ball2 body]);
        [ball2 release];
        ball2 = [[PhysicsObject alloc] initWithPosition:ccp(700, 550)
                                               filename:nil
                                             indefiener:13];
        [ball2 setWorld:world];
        [ball2 generateCirlceBodyWithRadius:40  bodyType:b2_dynamicBody];
        
        [self addChild:ball2 z:10];

        
        b2Vec2 force;
         force.Set([ball body]->GetLinearVelocity().x, [ball body]->GetLinearVelocity().y-20.0f);
        [ball body]->SetLinearVelocity(force);
        
        force.Set([ball2 body]->GetLinearVelocity().x, [ball2 body]->GetLinearVelocity().y+30.0f);
        [ball2 body]->SetLinearVelocity(force);
 

	}];
	
	CCMenuItemLabel *reset = [CCMenuItemFont itemWithString:@"Reset" block:^(id sender){
		[[CCDirector sharedDirector] replaceScene: [MainGameLayer scene]];
        
      	}];
	
    /*
	// Achievement Menu Item using blocks
	CCMenuItem *itemAchievement = [CCMenuItemFont itemWithString:@"Achievements" block:^(id sender) {
		
		
		GKAchievementViewController *achivementViewController = [[GKAchievementViewController alloc] init];
		achivementViewController.achievementDelegate = self;
		
		AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
		
		[[app navController] presentModalViewController:achivementViewController animated:YES];
		
		[achivementViewController release];
	}];
	
	// Leaderboard Menu Item using blocks
	CCMenuItem *itemLeaderboard = [CCMenuItemFont itemWithString:@"Leaderboard" block:^(id sender) {
		
		
		GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
		leaderboardViewController.leaderboardDelegate = self;
		
		AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
		
		[[app navController] presentModalViewController:leaderboardViewController animated:YES];
		
		[leaderboardViewController release];
	}];
	
    */
	CCMenu *menu = [CCMenu menuWithItems:start, reset, nil];
	
	[menu alignItemsVerticallyWithPadding:30];

	[menu setPosition:ccp( 960,700)];
	
	
	[self addChild: menu z:-1];	
}

-(void) initPhysics
{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	b2Vec2 gravity;
	gravity.Set(0.0f, -10.0f);
	world = new b2World(gravity);
	
	
	// Do we want to let bodies sleep?
	world->SetAllowSleeping(true);
	
	world->SetContinuousPhysics(true);
	
	m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	world->SetDebugDraw(m_debugDraw);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
	//		flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
//			flags += b2Draw::e_centerOfMassBit;
//	m_debugDraw->SetFlags(flags);
	
	
	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	
	// Call the body factory which allocates memory for the ground body
	// from a pool and creates the ground box shape (also from a pool).
	// The body is also added to the world.
	b2Body* groundBody = world->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.

}

-(void) draw
{
	//
	// IMPORTANT:
	// This is only for debug purposes
	// It is recommend to disable it
	//
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	world->DrawDebugData();	
	
	kmGLPopMatrix();
}

-(void) addNewSpriteAtPosition:(CGPoint)p
{
	CCLOG(@"Add sprite %0.2f x %02.f",p.x,p.y);
    
    
    PhysicsObject * point = [[PhysicsObject alloc] initWithPosition:p
                                                          filename:@"mask.png"
                                                        indefiener:12];
    [point setWorld:world];
    [point generateSquareBodyWithWidth:10 height:10 bodyType:b2_staticBody];
    
    [self addChild:point z:10];
    
    
    
    /*
	CCNode *parent = [self getChildByTag:kTagParentNode];
	
	//We have a 64x64 sprite sheet with 4 different 32x32 images.  The following code is
	//just randomly picking one of the images
	int idx = (CCRANDOM_0_1() > .5 ? 0:1);
	int idy = (CCRANDOM_0_1() > .5 ? 0:1);
	PhysicsSprite *sprite = [PhysicsSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(32 * idx,32 * idy,32,32)];						
	[parent addChild:sprite];
	
	sprite.position = ccp( p.x, p.y);
	
	// Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	b2Body *body = world->CreateBody(&bodyDef);
	
	// Define another box shape for our dynamic body.
	b2PolygonShape dynamicBox;
	dynamicBox.SetAsBox(.5f, .5f);//These are mid points for our 1m box
	
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;	
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
	body->CreateFixture(&fixtureDef);
	
	[sprite setPhysicsBody:body];
     */
}

-(void) update: (ccTime) dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);	
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [points removeAllObjects];
    
    CGPoint location;
    
    for( UITouch *touch in touches ) {
        location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
    }
     previousPoint_ = location;
    
    [self addPoint:location];
}

- (void)addPoint:(CGPoint)newPoint
{
    LinePoint *point = [[LinePoint alloc] init];
    point.pos = newPoint;
    point.width = 30;
    [points addObject:point];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint location;
    
    for( UITouch *touch in touches ) {
        location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
	
	}
    
    
    [self addPoint:location];
    
    NSMutableArray *smoothedPoints = [self calculateSmoothLinePoints];

    for (LinePoint *point in smoothedPoints) {
        [self addNewSpriteAtPosition:[point pos]];
    }


    previousPoint_ = location; 
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}


- (NSMutableArray *)calculateSmoothLinePoints
{
    if ([points count] > 2) {
        NSMutableArray *smoothedPoints = [NSMutableArray array];
        for (unsigned int i = 2; i < [points count]; ++i) {
            LinePoint *prev2 = [points objectAtIndex:i - 2];
            LinePoint *prev1 = [points objectAtIndex:i - 1];
            LinePoint *cur = [points objectAtIndex:i];
            
            CGPoint midPoint1 = ccpMult(ccpAdd(prev1.pos, prev2.pos), 0.5f);
            CGPoint midPoint2 = ccpMult(ccpAdd(cur.pos, prev1.pos), 0.5f);
            
            int segmentDistance = 2;
            float distance = ccpDistance(midPoint1, midPoint2);
            int numberOfSegments = MIN(128, MAX(floorf(distance / segmentDistance), 32));
            
            float t = 0.0f;
            float step = 1.0f / 10;
            for (NSUInteger j = 0; j < 10; j++) {
                LinePoint *newPoint = [[LinePoint alloc] init];
                newPoint.pos = ccpAdd(ccpAdd(ccpMult(midPoint1, powf(1 - t, 2)), ccpMult(prev1.pos, 2.0f * (1 - t) * t)), ccpMult(midPoint2, t * t));
                newPoint.width = powf(1 - t, 2) * ((prev1.width + prev2.width) * 0.5f) + 2.0f * (1 - t) * t * prev1.width + t * t * ((cur.width + prev1.width) * 0.5f);
                
                [smoothedPoints addObject:newPoint];
                t += step;
            }
            LinePoint *finalPoint = [[LinePoint alloc] init];
            finalPoint.pos = midPoint2;
            finalPoint.width = (cur.width + prev1.width) * 0.5f;
            [smoothedPoints addObject:finalPoint];
        }
        //! we need to leave last 2 points for next draw
        [points removeObjectsInRange:NSMakeRange(0, [points count] - 2)];
        return smoothedPoints;
    } else {
        return nil;
    }
}


#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

@end
