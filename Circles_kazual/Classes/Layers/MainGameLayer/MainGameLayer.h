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
#import "GameInfoLayer.h"
#import "GamePauseLayer.h"
#import "GameResultLayer.h"
#import "DrawHelperLayer.h"
#import "LevelWorldLayer.h"

@class Character;
@class LevelContainer;

#define PTM_RATIO 32

@interface MainGameLayer : BaseLayer <DrawingLayerDelegate, GameInfoLayerDelegate, GamePauseLayerDelegate, GameResultLayerDelegate>
{
 	CCTexture2D *spriteTexture_;	
	b2World* world_;				
	GLESDebugDraw *mdebugDraw_;		
    
    
    DrawingLayer        * drawingLayer_;
    EntertainmentLayer  * entertainmentLayer_;
    GameInfoLayer       * infoLayer_;
    GamePauseLayer      * pauseLayer_;
    GameResultLayer     * resultLayer_;
    DrawHelperLayer     * drawHelpLayer_;
    LevelWorldLayer     * levelWorldLayer_;
    
    LevelContainer * currentLevel_;
    
    NSMutableArray * characters_;
    
    BOOL gameRunning_;
}


@end
