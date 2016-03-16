//
//  FormButton.m
//  GSLVideoCallApp
//
//  Created by Aniket on 15/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "FormButton.h"
#import "Constant.h"

@implementation FormButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self designButton];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self designButton];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self designButton];
    }
    
    return self;
}

- (void)designButton {
    self.layer.cornerRadius = 4.0;
    [self.titleLabel setFont:[UIFont fontWithName:kHELVETICA_NEUE_CONDENSED size:17]];
    self.layer.masksToBounds = YES;
}

@end
