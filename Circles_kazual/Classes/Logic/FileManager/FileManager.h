//
//  FileManager.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/22/13.
//
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (NSString *)checkAndCreateFile:(NSString *)fileName;
+ (NSString *)documentsDirectory;

@end
