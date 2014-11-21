//
//  NSString+MAXTheFirstLetter.m
//  JSONFile
//
//  Created by maxfong on 14/11/21.
//
//

#import "NSString+MAXTheFirstLetter.h"

@implementation NSString (MAXTheFirstLetter)

- (NSString *)fristLetterString
{
    NSString *fileName = [self copy];
    NSString *className = [fileName capitalizedString];
    if ([fileName length] > 1) {
        className = [[[fileName substringToIndex:1] uppercaseString] stringByAppendingString:[fileName substringWithRange:NSMakeRange(1, fileName.length - 1)]];
    }
    return className;
}
@end
