//
//  LPJCell.m
//  LPJCollectionDemo
//
//  Created by lovepeijun on 15/11/28.
//  Copyright © 2015年 lovepeijun. All rights reserved.
//

#import "LPJCell.h"


@interface LPJCell ()
@property(nonatomic, weak)UILabel *titleLabel; /** titleLabel */
@end

@implementation LPJCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
//
//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super initWithCoder:aDecoder]) {
//        [self setUp];
//    }
//    return self;
//}



- (void)setUp
{
    //    self.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.textColor = [UIColor blackColor];
    //    titleLabel.text = self.titleName;
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    
    //
    //    UIView *selectView = [[UIView alloc] init];
    //    selectView.backgroundColor = [UIColor lightGrayColor];
    //    self.selectedBackgroundView = selectView;
}

-(void)layoutSubviews
{
    self.titleLabel.center = self.contentView.center;
    self.titleLabel.bounds = self.bounds;
}

- (void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    self.titleLabel.text = _titleName;
}

@end
