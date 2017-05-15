//
//  JGModel.m
//  JGWebCacheExample
//
//  Created by Jaygurnani on 14/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import "JGModel.h"

@implementation JGModel

-(JGModel *)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self != nil)
    {
        self.imageUrl = dictionary[@"urls"][@"thumb"];
        self.name = dictionary[@"user"][@"name"];
        self.profileImageUrl = dictionary[@"user"][@"profile_image"][@"large"];
        self.fullImageUrl = dictionary[@"urls"][@"full"];
    }
    return self;
}

@end
