//
//  JGModel.h
//  JGWebCacheExample
//
//  Created by Jaygurnani on 14/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGModel : NSObject

@property (nonatomic, strong) NSString * imageUrl;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * profileImageUrl;
@property (nonatomic, strong) NSString * fullImageUrl;

-(JGModel *)initWithDictionary:(NSDictionary *)dictionary;

@end
