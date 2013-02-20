//
//  GameManager+Sound.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 2/20/13.
//
//

#import "GameManager+Sound.h"
#import "SimpleAudioEngine.h"

@implementation GameManager (Sound)

- (void) preloadEffects {
   
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_GET_BONUS];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_LOSE];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_WIN];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_TRANSITION];
    [[SimpleAudioEngine sharedEngine] preloadEffect:SOUND_COUNTER];
}


- (void) playEffect:(NSString *)effect {
    [[SimpleAudioEngine sharedEngine] playEffect:effect];
    
}

@end
