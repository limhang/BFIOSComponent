

#import "NSDate+ButterFly.h"

@implementation NSDate (ButterFly)
+ (NSDate *)stringToDate: (NSString *)string {
    
    NSAssert(string, @"Parameter 'string' should not be nil");
    static NSDateFormatter *_dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
    });
    [_dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *destDate= [_dateFormatter dateFromString: string];
    return destDate;
}

+ (NSString *)dateToString: (NSDate *)date {
    
    NSAssert(date, @"Parameter 'date' should not be nil");
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate: date];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    
    NSString *dateStr = [NSString stringWithFormat:@"%d-%d-%d %d:%d",(int)year,(int)month,(int)day,(int)hour,(int)minute];
    
    return dateStr;
}

+(NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}


+(NSDate *)getPriousDateFromDate:(NSDate *)date withMonth:(int)month
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = 0;
    dateComponents.month = month;
    dateComponents.year = 0;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents
                                                         toDate:date
                                                        options:0];
}

+(NSString *)UTCEgihtHoursFromNowData:(NSDate *)date {
    NSDate *eightTime = [self getNowDateFromatAnDate:date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate: eightTime];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    return [NSString stringWithFormat:@"%d-%02d-%02d %02d:%02d",(int)year,(int)month,(int)day,(int)hour,(int)minute];
}

@end
