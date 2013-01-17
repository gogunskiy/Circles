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
#import "EntertainmentLayer.h"

@class Character;
@class LevelContainer;

#define PTM_RATIO 32

@interface MainGameLayer : BaseLayer <DrawingLayerDelegate>
{
 	CCTexture2D *spriteTexture_;	
	b2World* world_;				
	GLESDebugDraw *mdebugDraw_;		
    
    
    DrawingLayer * drawingLayer_;
    EntertainmentLayer * entertainmentLayer_;
    
    LevelContainer * currentLevel_;
    
    NSMutableArray * characters_;
}


@end
