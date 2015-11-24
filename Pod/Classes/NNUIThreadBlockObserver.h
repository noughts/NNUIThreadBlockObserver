//
//  NNUIThreadBlockObserver.h
//  Pods
//
//  Created by noughts on 2015/11/25.
//
//

#import <Foundation/Foundation.h>

@interface NNUIThreadBlockObserver : NSObject

+ (instancetype)sharedInstance;

/// この値を超えた場合にログします。デフォルトは(1/60秒 * 1.1)
@property CFTimeInterval threathold;

-(void)start;

@end
