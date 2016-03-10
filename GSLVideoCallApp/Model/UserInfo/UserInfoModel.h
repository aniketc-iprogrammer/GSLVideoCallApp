//
//  UserInfoModel.h
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface UserInfoModel : JSONModel

@property (strong,nonatomic) NSString *avatarName;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *isDevice;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *updated_at;
@property (strong,nonatomic) NSString *username;


@end
