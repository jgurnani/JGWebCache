//
//  JGDataDownloader.h
//  JGWebCache
//
//  Created by GlobalLogic on 13/05/17.
//  Copyright © 2017 Gurnani. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JGDataResponseBlock)(NSData * data, NSError * error);

@interface JGDataDownloader : NSObject

+(JGDataDownloader *)shared;
-(void)loadDataFromUrl:(NSString *)url withDoneBlock:(JGDataResponseBlock)doneBlock;


@end
