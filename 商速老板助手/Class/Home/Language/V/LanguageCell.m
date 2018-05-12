//
//  LanguageCell.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/8.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "LanguageCell.h"

@implementation LanguageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self titleLabel];
        [self clickBtn];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _titleLabel;
}

-(UIButton *)clickBtn{
    if (_clickBtn == nil) {
        _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_clickBtn];
        _clickBtn.hidden = YES;
        [_clickBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
        [_clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.height.width.mas_equalTo(20);
        }];
    }
    return _clickBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
