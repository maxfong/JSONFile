//
//  MAXEntityModelCreate.m
//  ConvertTools
//
//  Created by maxfong on 14-9-17.
//
//

#import "MAXEntityModelCreate.h"

@implementation MAXEntityModelCreate

+ (BOOL)createDirectory:(MAXSearchPathDirectory)directory error:(NSError **)error
{
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *fileSaveDirectory = [MAXEntityModelCreate saveFileDirectory];
    if (![manager createDirectoryAtPath:fileSaveDirectory withIntermediateDirectories:YES attributes:nil error:error])
    {
        return NO;
    }
    return YES;
}

+ (BOOL)createFileAtPath:(NSString *)filePath contentData:(NSData *)contentData attributes:(NSDictionary *)attr
{
    NSFileManager *manager=[NSFileManager defaultManager];
    return [manager createFileAtPath:filePath contents:contentData attributes:attr];
}

+ (NSData *)contentWithModel:(MAXFileEntityModel)model originalData:(NSDictionary *)dictionary options:(NSDictionary *)options
{
    NSString *modelContent = [self stringWithMode:model options:options];
    //替换数据
    NSString *replaceString = [MAXEntityModelReplace replaceStringWithString:modelContent object:dictionary fileModel:model options:options];
    
    return [replaceString dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)stringWithMode:(MAXFileEntityModel)model options:(NSDictionary *)options
{
    NSString *modelFilePath = [self modelFilePathWithModel:model options:options];
    return [NSString stringWithContentsOfFile:modelFilePath encoding:NSUTF8StringEncoding error:nil];
}

+ (NSString *)saveFileDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    return [NSString stringWithFormat:@"%@/MAXEntityFiles", paths[0]];
}

+ (NSString *)modelFilePathWithModel:(MAXFileEntityModel)model options:(NSDictionary *)options
{
    NSString *modelName = [self modelNameWithModel:model options:options];
    return [[NSBundle mainBundle] pathForResource:modelName ofType:@"model"];
}

//通过服务名和模型确定文件名称和路径
+ (NSString *)filePathWithModel:(MAXFileEntityModel)model options:(NSDictionary *)options
{
    NSString *saveFileDirectory = [self saveFileDirectory];
    NSString *fileName = [self fileNameWithModel:model options:options ];
    return [NSString stringWithFormat:@"%@/%@", saveFileDirectory, fileName];
}

+ (NSString *)modelNameWithModel:(MAXFileEntityModel)model options:(NSDictionary *)options
{
    //TIP:
    //you can use options[MAXModelFilePrefixKey] create different model
    return [NSString stringWithFormat:@"MAXEntityFilesModel.%c", (char)model];
}

+ (NSString *)fileNameWithModel:(MAXFileEntityModel)model options:(NSDictionary *)options
{
    NSString *fileName = options[MAXModelFileServerNameKey];
    NSString *className = [fileName capitalizedString];
    if ([fileName length] > 1) {
        className = [[[fileName substringToIndex:1] uppercaseString] stringByAppendingString:[fileName substringWithRange:NSMakeRange(1, fileName.length - 1)]];
    }
    return [NSString stringWithFormat:@"%@%@.%c", [options[MAXModelFilePrefixKey] capitalizedString] ?: @"", className ?: @"Demo", (char)model];
}

@end
