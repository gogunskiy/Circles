//
//  BaseLayer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/12/13.
//
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface BaseLayer : CCLayer

+ (CCScene *) scene;

- (void) setBackgroundImage:(NSString *)imageName;

- (void) addElements ;

@end
