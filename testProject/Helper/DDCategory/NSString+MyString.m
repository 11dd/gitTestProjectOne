//
//  NSString+MyString.m
//  HitPool
//
//  Created by jyzml_success on 16/4/20.
//  Copyright © 2016年 . All rights reserved.
//

#import "NSString+MyString.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (MyString)

- (NSString *)MD5Hash16
{
    NSString *MD5Hash32=[self MD5Hash32];
    return [[MD5Hash32 substringToIndex:24] substringFromIndex:8];
}

- (NSString *)MD5Hash32
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

-(NSString*)conversionTimestampToString
{
    NSTimeInterval time=[self doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

- (BOOL)isNumber
{
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(str.length > 0)
    {
        return NO;
    }
    return YES;
}

- (NSString *)strToUTF8
{
    
    return  [(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)self, NULL, NULL,  kCFStringEncodingUTF8 )) lowercaseString];
}


- (NSString *)UTF8ToStr
{
    return [NSString stringWithString:[[self hyb_URLDecode] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}


- (NSString *)hyb_URLDecode {
    
    NSString *input = self;
    
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    
    [outputStr replaceOccurrencesOfString:@"+"
     
                               withString:@" "
     
                                  options:NSLiteralSearch
     
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}

- (NSString *)getNotNullStr:(NSString *)str;
{
    if ([str isKindOfClass:[NSNull class]] || str == nil ) {
        return @"";
    }else{
        return str;
    }
}

@end
