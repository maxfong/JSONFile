//
//  MAXAppDelegate.m
//  JSONFile
//
//  Created by maxfong on 14-9-18.
//
//

#import "MAXAppDelegate.h"

@interface MAXAppDelegate ()

@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) IBOutlet NSMenu *menu;

@end

@implementation MAXAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:70];
    [self.statusItem  setMenu:self.menu];
    [self.statusItem  setHighlightMode:YES];
    [self.statusItem  setTitle:@"JSONFile"];
    
    [self.windowRequest setLevel:NSNormalWindowLevel];
    [self.windowConvert setLevel:NSNormalWindowLevel];
    [self.windowJSON setLevel:NSNormalWindowLevel];
}

-(IBAction)didPressedQuit:(id)sender
{
    exit(-1);
}

@end
