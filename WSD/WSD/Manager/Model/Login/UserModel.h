//
//  UserModel.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserModel : NSObject

/** 用户头像*/
@property (nonatomic, copy) NSString *avatar;



@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *areaId;
@property (nonatomic, copy) NSString *cellphone;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSNumber *gradeId;
@property (nonatomic, copy) NSString *gradeName;
@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *personSign;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, copy) NSString *sexName;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, copy) NSString *ticket;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSString *userFrom;
@property (nonatomic, copy) NSString *userFromName;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, strong) UIImage *levelImg;    //用户当前等级图标。默认为男爵
@property (nonatomic, copy) NSString *polesNumber;
@property (nonatomic, copy) NSString *handicap;








//当前登录状态
@property (nonatomic, assign) BOOL isLogin;

/** 获取用户模型*/
+ (instancetype)sharedUserModel;
//退出登录。清空数据
+(void)attempDealloc;

@end
