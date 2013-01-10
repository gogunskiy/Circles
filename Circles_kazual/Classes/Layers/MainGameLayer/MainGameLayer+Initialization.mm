//
//  MainGameLayer+Initialization.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/10/13.
//
//

#import "MainGameLayer+Initialization.h"

@implementation MainGameLayer (Initialization)


-(void) initPhysics
{

	b2Vec2 gravity;
	gravity.Set(0.0f, -10.0f);
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

@end
