//
//  ChooseLevelLayer.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/21/13.
//
//

#import "ChooseLevelLayer.h"
#import "CCNode+SFGestureRecognizers.h"

@interface ChooseLevelLayer ()

- (void) addGestures;
- (void) initialize;

@end

@implementation ChooseLevelLayer

- (id) init {
    self = [super init];
    
    pages_ = [[NSMutableArray alloc] init];
    
    [self addGestures];
    [self initialize];
    
    return self;
}

- (void) dealloc
{
    [pages_ release];
    [super dealloc];
}


- (void) addGestures {
 
    UISwipeGestureRecognizer *swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    [swipeLeftRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:swipeLeftRecognizer];
    [swipeLeftRecognizer release];
    
    UISwipeGestureRecognizer *swipeRighttRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    [swipeRighttRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:swipeRighttRecognizer];
    [swipeRighttRecognizer release];
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
    [[pages_ objectAtIndex:currentPage_] show];
}


#pragma mark - GESTURE RECOGNIZERS METHODS -

- (void) leftSwipe:(id)sender {
    
    if (currentPage_ < [pages_ count]-1) {
        
        [[pages_ objectAtIndex:currentPage_] leftOut];
        
        currentPage_ ++ ;
        
        [self addChild:[pages_ objectAtIndex:currentPage_]];
        [[pages_ objectAtIndex:currentPage_] leftIn];
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"screen_transition_3.wav"];
    }
}


- (void) rightSwipe:(id)sender {
    
    if (currentPage_ > 0) {
        [[pages_ objectAtIndex:currentPage_] rightOut];
      
        currentPage_ -- ;
       
        [self addChild:[pages_ objectAtIndex:currentPage_]];
        [[pages_ objectAtIndex:currentPage_] rightIn];
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"screen_transition_3.wav"];
    }
}

#pragma mark - CHOOSE LEVEL PAGE DELEGATE -

- (void) setLayerEnabled:(BOOL)endbled {
    [self setIsTouchEnabled:endbled];
}

- (BOOL) needLeftArrowForPage:(ChooseLevelPageLayer *) page {
    
    NSInteger index = [pages_ indexOfObject:page];
    
    return index;
}

- (BOOL) needRightArrowForPage:(ChooseLevelPageLayer *) page {
  
    NSInteger index = [pages_ indexOfObject:page];
    
    return index < [pages_ count] - 1;
}

- (void) showPreviousPage {
    [self rightSwipe:nil];
}

- (void) showNextPage {
    [self leftSwipe:nil];
}

@end
