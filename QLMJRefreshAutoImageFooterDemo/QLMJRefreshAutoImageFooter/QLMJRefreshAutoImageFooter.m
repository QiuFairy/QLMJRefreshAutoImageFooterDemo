//
//  QLMJRefreshAutoImageFooter.m
//  JiaoKan
//
//  Created by qiu on 2019/8/8.
//  Copyright © 2019 qiu. All rights reserved.
//

#import "QLMJRefreshAutoImageFooter.h"

@interface QLMJRefreshAutoImageFooter()
@property (weak, nonatomic) UIImageView *noDataImageView;

@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

@property (nonatomic, assign, getter = isNoDataStatus) BOOL noDataStatus;
@end

@implementation QLMJRefreshAutoImageFooter
#pragma mark - 懒加载
- (UIImageView *)noDataImageView
{
    if (!_noDataImageView) {
        UIImageView *noDataImageView = [[UIImageView alloc] init];
        noDataImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_noDataImageView = noDataImageView];
    }
    return _noDataImageView;
}

- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}

- (void)setNoDataImage:(UIImage *)noDataImage{
    _noDataImage = noDataImage;
}

#pragma mark - 实现父类的方法
- (void)prepare
{
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    
    if (self.isNoDataStatus && self.noDataImage != nil) {
        //这里判断是否显示了noDataView
        
        if (self.noDataImageView.constraints.count) return;
        
        
        /* 根据图片设置控件的高度 */
        if (self.noDataImage.size.height > self.mj_h) {
            self.scrollView.mj_insetB -= self.mj_h;
            self.mj_h = self.noDataImage.size.height;
            self.scrollView.mj_insetB += self.mj_h;
        }
        //设置scrollView.mj_insetB来设置底部刷新View的展示
        self.noDataImageView.frame = self.bounds;
        
    }else{
        if (self.loadingView.constraints.count) return;
        
        //修改底部刷新view的高度，同步修改scrollView.mj_insetB
        
        if (self.mj_h != MJRefreshFooterHeight) {
            self.scrollView.mj_insetB -= self.mj_h;
            self.mj_h = MJRefreshFooterHeight;
            self.scrollView.mj_insetB += self.mj_h;
        }
        
        self.stateLabel.frame = self.bounds;
        
        // 设置圈圈的位置
        CGFloat loadingCenterX = self.mj_w * 0.5;
        if (!self.isRefreshingTitleHidden) {
            loadingCenterX -= self.stateLabel.mj_textWith * 0.5 + self.labelLeftInset;
        }
        CGFloat loadingCenterY = self.mj_h * 0.5;
        self.loadingView.center = CGPointMake(loadingCenterX, loadingCenterY);
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        [self.loadingView stopAnimating];
        
        self.stateLabel.hidden = NO;
        self.noDataStatus = NO;
        self.noDataImageView.hidden = YES;
        
        //去除constraints以便placeSubviews的刷新
        [self.loadingView removeConstraints:self.loadingView.constraints];
    } else if (state == MJRefreshStateRefreshing) {
        [self.loadingView startAnimating];
        
        self.stateLabel.hidden = NO;
        self.noDataStatus = NO;
        self.noDataImageView.hidden = YES;
        
        [self.noDataImageView removeConstraints:self.noDataImageView.constraints];
    }else if (state == MJRefreshStateNoMoreData){
        [self.loadingView stopAnimating];
        self.noDataStatus = YES;
        self.stateLabel.hidden = YES;
        self.noDataImageView.hidden = NO;
        
        self.noDataImageView.image = self.noDataImage;
        [self.loadingView removeConstraints:self.loadingView.constraints];
        
    }
}
@end
