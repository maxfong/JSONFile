//
//  MAXPluginController.m
//  ConvertUnicode
//
//  Created by maxfong on 14-7-15.
//
//

#import "MAXPluginController.h"
#import "NSString+UnicodeConvert.h"
#import "MAXJSONDictionary.h"
#import "MAXEntityModelOperation.h"

@implementation MAXPluginController

-(void)windowDidLoad
{
    [super windowDidLoad];
}

- (IBAction)didPressedConvertChinese:sender
{
    NSString *input = txtvJSONInput.string ?: @"";
    NSString *convertedString = [input chineseFromUnicode];
    [txtvJSONOutput setString:convertedString];
}

- (IBAction)didPressedAlert:sender
{
    NSAlert *alert = [NSAlert alertWithMessageText:@"提示" defaultButton:@"确定" alternateButton:@"取消" otherButton:nil informativeTextWithFormat:@"更多想法请联系maxfong，是否访问项目github？"];
    [alert beginSheetModalForWindow:nil modalDelegate:self didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    if (returnCode == 1)
    {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/maxfong/JSONFile"]];
    }
}

- (IBAction)didPressedCheckJSON:sender
{
    NSString *outputString = txtvConsole.string ?: @"";
    
    NSDictionary *dictionary = [MAXJSONDictionary dictionaryWithJSONString:outputString error:nil];
    if ([dictionary isKindOfClass:[NSDictionary class]])
    {
        [txtvConsole setString:[[MAXJSONDictionary stringWithDictionary:dictionary] chineseFromUnicode]];
        [txtfConsole setStringValue:@"success"];
    }
    else
    {
        NSString *errorMsg = [MAXJSONDictionary JSONSpecificFromError:nil originString:outputString];
        [txtfConsole setStringValue:(errorMsg ?: @"fail")];
    }
}

- (IBAction)didPressedFileCreate:sender
{
    NSString *outputString = txtvConsole.string ?: @"";
    NSError *error;
    NSDictionary *dictionary = [MAXJSONDictionary dictionaryWithJSONString:outputString error:&error];
    if (error || ![dictionary isKindOfClass:[NSDictionary class]])
    {
        [txtfConsole setStringValue:@"fail"];
    }
    else
    {
        [MAXEntityModelOperation createEntityFileWithDictionary:dictionary
                                                          model:MAXHeadAndComplieEntity
                                                      directory:MAXUserDesktopDirectory
                                                        options:@{MAXModelFileServerNameKey : @"__main__"}
                                                          error:nil];
        [txtfConsole setStringValue:@"success"];
    }
}

@end
