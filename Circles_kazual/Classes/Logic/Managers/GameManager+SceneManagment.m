//
//  GameManager+SceneManagment.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/17/13.
//
//

#import "GameManager+SceneManagment.h"
#import "MainMenuLayer.h"
#import "MainGameLayer.h"

@implementation GameManager (SceneManagment)


#pragma mark - SCENE MANAGMENT -

- (void) loadStartScene {
    [[CCDirector sharedDirector] runWithScene:[MainMenuLayer scene]];
}

- (void) loadMainMenuScene {
    [[CCDirector sharedDirector] replaceScene:[MainMenuLayer scene]];
}

- (void) loadMainGameLayer {
    [[CCDirector sharedDirector] replaceScene:[MainGameLayer scene]];
}


@end
