//
//  FileManager.m
//  Circles_kazual
//
//  Created by Gogunsky Vladimir on 1/22/13.
//
//

#import "FileManager.h"

@implementation FileManager

+ (NSString *)checkAndCreateFile:(NSString *)fileName
{
	BOOL success;
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	NSString *path = [[NSString alloc] initWithString:[[[self class] documentsDirectory] stringByAppendingPathComponent:fileName]];
    
	success = [fileManager fileExistsAtPath:path];
    
	if (success) {
		return [path autorelease];
	}
    
	NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    
	[fileManager copyItemAtPath:filePath toPath:path error:nil];
    
	[fileManager release];
    
	return [path autorelease];
}

+ (NSString *)documentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
	return [paths objectAtIndex:0];
}

@end
