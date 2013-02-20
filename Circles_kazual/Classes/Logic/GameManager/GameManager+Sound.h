//
//  GameManager+Sound.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 2/20/13.
//
//

#import "GameManager.h"

static NSString * const SOUND_GET_BONUS     = @"get_bonus_sound.wav";
static NSString * const SOUND_LOSE          = @"loseSound.wav";
static NSString * const SOUND_WIN           = @"winSound.wav";
static NSString * const SOUND_TRANSITION    = @"screen_transition_3.wav";
static NSString * const SOUND_COUNTER       = @"counter.wav";


@interface GameManager (Sound)


- (void) preloadEffects;
- (void) playEffect:(NSString *)effect;

@end
