//
//  NormalCalendarsView.m
//  SoilDetector
//
//  Created by het on 2018/1/3.
//  Copyright © 2018年 kaka. All rights reserved.
//

#import "NormalCalendarsView.h"
#import "MSSCalendarManager.h"
#import "MSSCalendarHeaderModel.h"
#import "MSSCalendarDefine.h"
#import "MSSCalendarCollectionViewCell.h"
#import "MSSCalendarCollectionReusableView.h"
@interface NormalCalendarsView()<UITableViewDelegate,UITableViewDataSource>
/**tableview**/
@property (nonatomic, strong) UITableView *mainTableView;
/**头部视图**/
@property (nonatomic, strong) UIView *calendarsHeadView;

@end

@implementation NormalCalendarsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //主maintabelview
        [self addSubview:self.mainTableView];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NormalCalendarsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"calendars"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedTimeBlock = ^(NSInteger startTime, NSInteger endTime) {
        self.calendarsCB(startTime, endTime);
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.calendarsHeadView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenWidth / 7 * 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return ScreenWidth / 7 * 1;
}

#pragma mark - setters and getters
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 7 * 8) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.scrollEnabled = NO;
        [_mainTableView registerClass:[NormalCalendarsCell class] forCellReuseIdentifier:@"calendars"];
    }
    return _mainTableView;
}

- (UIView *)calendarsHeadView {
    if (!_calendarsHeadView) {
        _calendarsHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 7 *1)];
        //日期部分
//        UIView *data = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 7)];
//        data.backgroundColor = [UIColor yellowColor];
//        [_calendarsHeadView addSubview:data];
        //星期部分
//        UIView *week = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenWidth / 7, ScreenWidth, ScreenWidth / 7)];
//        week.backgroundColor = [UIColor redColor];
//        [_calendarsHeadView addSubview:week];
        
        UIView *weekView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 7 *1)];
//        weekView.backgroundColor = [UIColor sam_colorWithHex:themeColor];
        [_calendarsHeadView addSubview:weekView];
        
        NSArray *weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        int i = 0;
        NSInteger width = MSS_Iphone6Scale(54);
        for(i = 0; i < 7;i++)
        {
            UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * width, 0, width, MSS_WeekViewHeight)];
            weekLabel.backgroundColor = [UIColor clearColor];
            weekLabel.text = weekArray[i];
            weekLabel.font = [UIFont boldSystemFontOfSize:16.0f];
            weekLabel.textAlignment = NSTextAlignmentCenter;
            if(i == 0 || i == 6)
            {
                weekLabel.textColor = [UIColor sam_colorWithHex:themeColor];
            }
            else
            {
                weekLabel.textColor = [UIColor sam_colorWithHex:@"303030"];
            }
            [weekView addSubview:weekLabel];
        }
        
    }
    return _calendarsHeadView;
}

- (void)addWeakView
{

}

@end

//////////////////////////////////====NormalCalendarsCell====//////////////////////////////////

@interface NormalCalendarsCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**日历表格**/
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation NormalCalendarsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor grayColor];
        //创建7*6的日历表
        [self.contentView addSubview:self.mainCollectionView];
        //初始化数据
        [self initDataSource];
    }
    return self;
}

- (void)initDataSource
{
    _dataArray = [NSMutableArray new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MSSCalendarManager *manager = [[MSSCalendarManager alloc]initWithShowChineseHoliday:NO showChineseCalendar:NO startDate:1514736000];
        NSArray *tempDataArray = [manager getCalendarDataSoruceWithLimitMonth:13*1 type:MSSCalendarViewControllerLastType];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_dataArray addObjectsFromArray:tempDataArray];
            [self showCollectionViewWithStartIndexPath:manager.startIndexPath];
        });
    });
}

- (void)showCollectionViewWithStartIndexPath:(NSIndexPath *)startIndexPath
{
//    [self addWeakView];
    [_mainCollectionView reloadData];
    // 滚动到上次选中的位置
    if(startIndexPath)
    {
        [_mainCollectionView scrollToItemAtIndexPath:startIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        _mainCollectionView.contentOffset = CGPointMake(0, _mainCollectionView.contentOffset.y - 100);
    }
    else
    {
//        if(_type == MSSCalendarViewControllerLastType)
//        {
//            if([_dataArray count] > 0)
//            {
//                [_mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_dataArray.count - 1] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
//            }
//        }
//        else if(_type == MSSCalendarViewControllerMiddleType)
//        {
//            if([_dataArray count] > 0)
//            {
//                [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:(_dataArray.count - 1) / 2] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
//                _collectionView.contentOffset = CGPointMake(0, _collectionView.contentOffset.y - MSS_HeaderViewHeight);
//            }
//        }
    }
}

#pragma UICollectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_dataArray count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    MSSCalendarHeaderModel *headerItem = _dataArray[section];
    return headerItem.calendarItemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSSCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSSCalendarCollectionViewCell" forIndexPath:indexPath];
    if(cell)
    {
        MSSCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
        MSSCalendarModel *calendarItem = headerItem.calendarItemArray[indexPath.row];
        cell.dateLabel.text = @"";
        cell.dateLabel.textColor = MSS_TextColor;
        cell.subLabel.text = @"";
        cell.subLabel.textColor = MSS_SelectSubLabelTextColor;
        cell.isSelected = NO;
        cell.backgroundColor = [UIColor sam_colorWithHex:@"ffffff"];
        cell.userInteractionEnabled = NO;
        cell.layer.mask = nil;
        if(calendarItem.day > 0)
        {
            cell.dateLabel.text = [NSString stringWithFormat:@"%ld",(long)calendarItem.day];
            if ([calendarItem.holiday isEqualToString:@"今天"]) {
                cell.dateLabel.text = calendarItem.holiday;
            }
            cell.userInteractionEnabled = YES;
        }
        else
        {
            if(calendarItem.week == 0 || calendarItem.week == 6)
            {
                cell.dateLabel.textColor = MSS_WeekEndTextColor;
                cell.subLabel.textColor = MSS_WeekEndTextColor;
            }
            if(calendarItem.holiday.length > 0)
            {
                cell.dateLabel.text = calendarItem.holiday;
                if(YES)
                {
                    cell.dateLabel.textColor = MSS_HolidayTextColor;
                    cell.subLabel.textColor = MSS_HolidayTextColor;
                }
            }
        }
        
        // 开始日期 -- 还没有选择结束日期时候
        if(calendarItem.dateInterval == _startDate && !_endDate)
        {
//            cell.isSelected = YES;
//            cell.dateLabel.textColor = MSS_SelectTextColor;
            cell.backgroundColor = [UIColor sam_colorWithHex:themeColor];
            UIBezierPath *maskPAth = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:cell.bounds.size];
            CAShapeLayer *caShapeLayer = [CAShapeLayer layer];
            caShapeLayer.path = maskPAth.CGPath;
            cell.layer.mask = caShapeLayer;
        }
        // 开始日期 -- 有选择结束日期时候
        else if(calendarItem.dateInterval == _startDate && _endDate) {
            cell.backgroundColor = [UIColor sam_colorWithHex:themeColor];
            
            UIBezierPath *maskPAth = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:cell.bounds.size];
            CAShapeLayer *caShapeLayer = [CAShapeLayer layer];
            caShapeLayer.path = maskPAth.CGPath;
            cell.layer.mask = caShapeLayer;
        }
        // 结束日期
        else if (calendarItem.dateInterval == _endDate)
        {
//            cell.isSelected = YES;
//            cell.dateLabel.textColor = MSS_SelectTextColor;
            cell.backgroundColor = [UIColor sam_colorWithHex:themeColor];
            cell.subLabel.text = MSS_SelectEndText;
            UIBezierPath *maskPAth = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:cell.bounds.size];
            CAShapeLayer *caShapeLayer = [CAShapeLayer layer];
            caShapeLayer.path = maskPAth.CGPath;
            cell.layer.mask = caShapeLayer;
        }
        // 开始和结束之间的日期
        else if(calendarItem.dateInterval > _startDate && calendarItem.dateInterval < _endDate)
        {
//            cell.isSelected = YES;
            cell.backgroundColor = [UIColor sam_colorWithHex:@"81d4f9"];
//            cell.dateLabel.textColor = MSS_SelectTextColor;
        }
        
        if(!NO)
        {
            if(calendarItem.type == MSSCalendarNextType)
            {
                cell.dateLabel.textColor = MSS_TouchUnableTextColor;
                cell.subLabel.textColor = MSS_TouchUnableTextColor;
                cell.userInteractionEnabled = NO;
            }
        }
    }
    return cell;
}

// 添加header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MSSCalendarCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MSSCalendarCollectionReusableView" forIndexPath:indexPath];
        MSSCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
        headerView.headerLabel.text = headerItem.headerText;
        return headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSSCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
    MSSCalendarModel *calendaItem = headerItem.calendarItemArray[indexPath.row];
    // 当开始日期为空时
    if(_startDate == 0)
    {
        _startDate = calendaItem.dateInterval;
//        [self showPopViewWithIndexPath:indexPath];
    }
    // 当开始日期和结束日期同时存在时(点击为重新选时间段)
    else if(_startDate > 0 && _endDate > 0)
    {
        _startDate = calendaItem.dateInterval;
        _endDate = 0;
//        [self showPopViewWithIndexPath:indexPath];
    }
    else
    {
        // 判断第二个选择日期是否比现在开始日期大
        if(_startDate < calendaItem.dateInterval)
        {
            _endDate = calendaItem.dateInterval;
            //选择时间完成
            if (self.selectedTimeBlock) {
                self.selectedTimeBlock(_startDate, _endDate);
            }
        }
        else
        {
            _startDate = calendaItem.dateInterval;
//            [self showPopViewWithIndexPath:indexPath];
        }
    }
    [_mainCollectionView reloadData];

}


#pragma mark - setters and getters
- (UICollectionView *)mainCollectionView {
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(ScreenWidth / 7, ScreenWidth / 7 );
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.headerReferenceSize = CGSizeMake(MSS_SCREEN_WIDTH, MSS_HeaderViewHeight);
        flowLayout.minimumLineSpacing = 0;
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 7 * 6) collectionViewLayout:flowLayout];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.backgroundColor = [UIColor sam_colorWithHex:@"ffffff"];
        [_mainCollectionView registerClass:[MSSCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"MSSCalendarCollectionViewCell"];
        [_mainCollectionView registerClass:[MSSCalendarCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MSSCalendarCollectionReusableView"];
    }
    return _mainCollectionView;
}

@end

