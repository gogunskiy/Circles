//
//  LevelContainer.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/17/13.
//
//

#import <Foundation/Foundation.h>

@interface LevelContainer : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, retain) NSArray * characters;

- (void) setWithInfo:(NSDictionary *)info ;



@end
