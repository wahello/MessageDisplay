//
//  JKEmotionSectionBarTableViewCell.m
//  MessageDisplay
//
//  Created by Jack on 15/3/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKEmotionSectionBarTableViewCell.h"

@implementation JKEmotionSectionBarTableViewCell




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.transform = CGAffineTransformMakeRotation(M_PI/2);
        self.frame = CGRectMake(0, 0, 35, 70);
        _iconImage = [[UIImageView alloc]init];
        _iconImage.frame = CGRectMake(18, 5, 30, 26);
        [self addSubview:_iconImage];
        _seperateLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"separatorLinePoint"]];
        _seperateLine.frame = CGRectMake(69.5, 0, 0.5, 40);
        [self addSubview:_seperateLine];
    }
    return self;
}



- (void)layoutSubviews
{
    self.imageView.frame = CGRectMake(0, 0, 32, 32);
    self.imageView.center = self.center;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
