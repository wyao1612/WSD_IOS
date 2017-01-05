//
//  HomeInfoModel.h
//  GolfIOS
//
//  Created by yangbin on 16/12/20.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseObject.h"


@class HomeInfo;
@interface HomeInfoModel : BaseObject

/**data*/
@property (nonatomic, strong) HomeInfo *data;

@end


@interface HomeInfo : NSObject

/**广告列表*/
@property (nonatomic, strong) NSArray *adListInfo;
/**订单列表*/
@property (nonatomic, strong) NSArray *indexOrderListInfo;
/**投票列表*/
@property (nonatomic, strong) NSArray *voteActivityListInfo;
/**社区帖子列表*/
@property (nonatomic, strong) NSArray *communityArticleList;


@end


//MARK: - 广告

@interface AdModel : NSObject

/**id*/
@property (nonatomic, strong) NSNumber *ID;
/**img*/
@property (nonatomic, strong) NSString *img;
/**linkId*/
@property (nonatomic, strong) NSNumber *linkId;
/**lineType*/
@property (nonatomic, strong) NSNumber *linkType;
/**linkTypeName*/
@property (nonatomic, strong) NSString *linkTypeName;
/**title*/
@property (nonatomic, strong) NSString *title;

@end


