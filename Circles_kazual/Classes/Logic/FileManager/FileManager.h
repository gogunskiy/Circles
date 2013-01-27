//
//  FileManager.h
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/22/13.
//
//

#import <Foundation/Foundation.h>

#define RESOURCE_FILE(file) [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:(file)]


@interface FileManager : NSObject

+ (NSString *)checkAndCreateFile:(NSString *)fileName;
+ (NSString *)documentsDirectory;

@end
