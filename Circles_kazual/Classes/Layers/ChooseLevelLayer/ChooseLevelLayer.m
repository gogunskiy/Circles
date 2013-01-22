//
//  ChooseLevelLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/21/13.
//
//

#import "ChooseLevelLayer.h"
#import "CCNode+SFGestureRecognizers.h"
#import "ChooseLevelLayer+Touches.h"

@interface ChooseLevelLayer ()

- (void) initialize;

@end

@implementation ChooseLevelLayer

- (id) init {
    self = [super init];
    
    pages_ = [[NSMutableArray alloc] init];
    
    [self initialize];
    
    return self;
}

- (void) dealloc
{
    [pages_ release];
    [super dealloc];
}


- (void) initialize {
    NSArray * levelsInfo = [GAME levelsInformation];

    for (NSDictionary *pagesInfo in levelsInfo) {
        
        ChooseLevelPageLayer * page =[[ChooseLevelPageLayer alloc] init];
        [page setInfo:pagesInfo];
        [page setDelegate:self];
        [page initialize];
        
        [pages_ addObject:page];
        [page release];
    }
    
    currentPage_ = [[Settings objectForKey:SETTINGS_KEY_CHOOSE_LEVEL_ACTIVE_PAGE] intValue];
    
    [self addChild:[pages_ objectAtIndex:currentPage_]];
}


#pragma mark - GESTURE RECOGNIZERS METHODS -

- (void) leftSwipe:(id)sender {
    NSLog(@"LEFT SWIPE");
}


- (void) rightSwipe:(id)sender {
    NSLog(@"RIGHT SWIPE");
}


@end
