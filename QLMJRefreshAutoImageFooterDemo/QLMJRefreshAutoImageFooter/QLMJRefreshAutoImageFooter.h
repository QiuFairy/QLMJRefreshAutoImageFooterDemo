//
//  QLMJRefreshAutoImageFooter.h
//  JiaoKan
//
//  Created by qiu on 2019/8/8.
//  Copyright © 2019 qiu. All rights reserved.
//

/*!
 仿照MJRefreshAutoNormalFooter来写
 添加了MJRefreshStateNoMoreData状态下的空数据ImageView(此处也可以修改成view)
 */

#import "MJRefreshAutoStateFooter.h"

NS_ASSUME_NONNULL_BEGIN

@interface QLMJRefreshAutoImageFooter : MJRefreshAutoStateFooter

/** 仅用于没有更多数据时的展示 */
@property (nonatomic, strong) UIImage *noDataImage;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end

NS_ASSUME_NONNULL_END
