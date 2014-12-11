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
    
}

- (NSMenu *)applicationDockMenu:(NSApplication *)sender
{
    return self.menu;
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
    if (!flag){
        [self.windowJSON makeKeyAndOrderFront:self];
    }
    return YES;
}

- (IBAction)didPressedQuit:(id)sender
{
    exit(-1);
}

@end
