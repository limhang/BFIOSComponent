//
//  NormalCalendarsView.h
//  SoilDetector
//
//  Created by het on 2018/1/3.
//  Copyright © 2018年 kaka. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChoiceStartTimeEndTime)(NSInteger startTime, NSInteger endTime);
typedef void(^CalendarsCB)(NSInteger startTime, NSInteger endTime);
typedef NS_ENUM(NSInteger, MSSCalendarViewControllerType)
{
    MSSCalendarViewControllerLastType = 0,// 只显示当前月之前
    MSSCalendarViewControllerMiddleType,// 前后各显示一半
    MSSCalendarViewControllerNextType// 只显示当前月之后
};
@interface NormalCalendarsView : UIView
@property (nonatomic, copy) CalendarsCB calendarsCB;
@end

@interface NormalCalendarsCell : UITableViewCell
@property (nonatomic, copy) ChoiceStartTimeEndTime selectedTimeBlock;
@property (nonatomic,assign)NSInteger startDate;// 选中开始时间
@property (nonatomic,assign)NSInteger endDate;// 选中结束时间

@end

