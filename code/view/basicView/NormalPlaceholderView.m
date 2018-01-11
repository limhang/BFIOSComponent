//
//  NormalPlaceholderView.m
//  SoilDetector
//
//  Created by het on 2018/1/11.
//  Copyright © 2018年 kaka. All rights reserved.
//

#import "NormalPlaceholderView.h"

@interface NormalPlaceholderView()
/**图片**/
@property (nonatomic, strong) UIImageView *placeImage;
/**图片资源**/
@property (nonatomic, copy) NSString *imageSrc;
/**图片大小**/
@property (nonatomic, assign) CGSize imageSize;
/**图片到view上端的距离--使用字符串**/
@property (nonatomic, copy) NSString *img2viewHeight;

/**文字**/
@property (nonatomic, strong) UILabel *placeLabel;
/**文字颜色**/
@property (nonatomic, copy) NSString *fontColor;
/**文字字体**/
@property (nonatomic, assign) NSInteger font;
/*文字内容**/
@property (nonatomic, copy) NSString *labelText;

/**文字到图片的距离**/
@property (nonatomic, assign) CGFloat text2imgHeight;

@end

@implementation NormalPlaceholderView

- (instancetype)initWithFrame:(CGRect)frame ImageTop:(NSString *)top imageSize:(CGSize)imageSize textToImageHeight:(CGFloat)text2Image fontSize:(NSInteger)font fontColor:(NSString *)fontColor imageSrc:(NSString *)imageStr textSrc:(NSString *)str {
    self = [super initWithFrame:frame];
    if (self) {
        self.img2viewHeight = top;
        self.imageSize = imageSize;
        self.text2imgHeight = text2Image;
        self.font = font;
        self.fontColor = fontColor;
        self.imageSrc = imageStr;
        self.labelText = str;
        self.backgroundColor = [UIColor sam_colorWithHex:@"ffffff"];
        [self addSubview:self.placeImage];
        [self addSubview:self.placeLabel];
        [self resetFrame];
    }
    return self;
}

#pragma mark - private methods
- (void)resetFrame {
    if ([self.img2viewHeight isEqualToString:@"center"]) {
        [_placeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(self.imageSize.width);
            make.height.mas_equalTo(self.imageSize.height);
        }];
    } else {
        CGFloat img2view = [self.img2viewHeight floatValue];
        [_placeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.mas_equalTo(img2view);
            make.width.mas_equalTo(self.imageSize.width);
            make.height.mas_equalTo(self.imageSize.height);
        }];
    }
    
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.placeImage.mas_bottom).offset(self.text2imgHeight);
    }];
}

#pragma mark - setters and getters
- (UIImageView *)placeImage {
    if (!_placeImage) {
        _placeImage = [[UIImageView alloc]init];
        _placeImage.image = [UIImage imageNamed:self.imageSrc];
    }
    return _placeImage;
}

- (UILabel *)placeLabel {
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc]init];
        _placeLabel.numberOfLines = 0;
        _placeLabel.font = [UIFont systemFontOfSize:self.font];
        _placeLabel.textColor = [UIColor sam_colorWithHex:self.fontColor];
        _placeLabel.text = self.labelText;
    }
    return _placeLabel;
}

@end
