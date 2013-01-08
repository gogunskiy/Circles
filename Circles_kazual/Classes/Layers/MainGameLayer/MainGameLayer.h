//
//  HelloWorldLayer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 11/3/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import <GameKit/GameKit.h>


#import "Box2D.h"
#import "GLES-Render.h"
#import "DrawingLayer.h"

@class PhysicsObject;


#define PTM_RATIO 32

@interface MainGameLayer : CCLayer <DrawingLayerDelegate>
{
    // basic physics engine ivars
	CCTexture2D *spriteTexture_;	// weak ref
	b2World* world;					// strong ref
	GLESDebugDraw *m_debugDraw;		// strong ref
    
    
    DrawingLayer * drawingLayer_;
   
    PhysicsObject * ball;
    PhysicsObject * ball2;

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
