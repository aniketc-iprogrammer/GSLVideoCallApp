//
//  UserModer.h
//  GSLVideoCallApp
//
//  Created by Aniket on 10/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileInfoModel.h"
#import "GroupInfoModel.h"


@interface UserModel : NSObject

@property (strong,nonatomic) ProfileInfoModel* profileInfo;
@property (strong,nonatomic) GroupInfoModel *groupInfo;
@property (strong,nonatomic) NSString *displayPicturePath;

@end
