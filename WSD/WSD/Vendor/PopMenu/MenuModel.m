//
//  MenuModel.m
//  PopMenuTableView
//
//  Created by yy on 16/8/2.
//  Copyright © 2016年 KongPro. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)MenuModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
