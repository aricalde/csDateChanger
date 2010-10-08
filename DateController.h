#import <Cocoa/Cocoa.h>

@interface DateController : NSObject {
	IBOutlet NSDatePicker *datePickerControl;
	IBOutlet NSTextField *getTexto;
}
- (IBAction)btnGet:(id)sender;
@end
