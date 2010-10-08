#import "DateController.h"

@implementation DateController
- (IBAction)btnGet:(id)sender {
	NSString *actualPath, *actualFile;
	actualPath = [[getTexto stringValue] stringByDeletingLastPathComponent];
    actualFile = [[getTexto stringValue] lastPathComponent];
	NSDate *kpedo = [datePickerControl dateValue];
	NSDateFormatter *paFormatear = [[[NSDateFormatter alloc] init] autorelease];
	[paFormatear setDateStyle:NSDateFormatterNoStyle];
	[paFormatear setTimeStyle:NSDateFormatterNoStyle];
	[paFormatear setDateFormat:	(NSString*)@"yyyyMMddhhmm"];
	NSString *paMostrar = [paFormatear stringFromDate:kpedo];
	NSString *comando = [[[NSString alloc] init] autorelease];
	comando = @"touch -t ";
	comando = [comando stringByAppendingString:[paFormatear stringFromDate:kpedo]];
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSTask *newTask = [[NSTask alloc] init];
	int status;
	[newTask setLaunchPath: @"/usr/bin/touch"];
	NSArray *misArgumentos;
	misArgumentos = [NSArray arrayWithObjects:@"-t", paMostrar, actualFile, nil];
	[newTask setArguments: misArgumentos];
	[newTask setCurrentDirectoryPath:actualPath];
	NSPipe *pipe;
	pipe = [NSPipe pipe];
	[newTask setStandardOutput:pipe];
	NSFileHandle *file;
	file = [pipe fileHandleForReading];
	[newTask launch];
	[newTask waitUntilExit];
	NSData *data;
	data = [file readDataToEndOfFile];
	NSString *string;
	string = [[NSString alloc] initWithData:data  encoding: NSUTF8StringEncoding];
	status = [newTask terminationStatus];
	[pool release];
	[getTexto setStringValue:@""];
}

@end
