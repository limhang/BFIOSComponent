/*
 Name: NormalPlaceholderView.h
 Version: 0.0.1
 Created by jacob on 2018/1/11
 简介：通用占位图，默认文字和图片
 功能：{
 输入端(主动)：控制图片和文字的位置
 输出端(被动)：占不支持外界点击等手势，后期增加
 }
 依赖的文件：暂无
 */

#import <UIKit/UIKit.h>

@interface NormalPlaceholderView : UIView

- (instancetype)initWithFrame:(CGRect)frame ImageTop:(NSString *)top imageSize:(CGSize)imageSize textToImageHeight:(CGFloat)text2Image fontSize:(NSInteger)font fontColor:(NSString *)fontColor imageSrc:(NSString *)imageStr textSrc:(NSString *)str;


@end

//使用说明：
//_displayImage = [[NormalPlaceholderView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) ImageTop:@"center" imageSize:CGSizeMake(192*NewBasicWidth, 147*NewBasicHeight) textToImageHeight:10 fontSize:16 fontColor:@"848484" imageSrc:@"空数据" textSrc:@"暂无数据"];

