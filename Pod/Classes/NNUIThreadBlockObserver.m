//
//  NNUIThreadBlockObserver.m
//  Pods
//
//  Created by noughts on 2015/11/25.
//
//

#import "NNUIThreadBlockObserver.h"

@implementation NNUIThreadBlockObserver{
    CFTimeInterval _lastTimeStamp;
}

+ (instancetype)sharedInstance{
    static NNUIThreadBlockObserver* sharedInstance;
    static dispatch_once_t once;
    dispatch_once( &once, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.threathold = 1/60.0 * 1.1;
    });
    return sharedInstance;
}

-(void)start{
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateValue:)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}


-(void)updateValue:(CADisplayLink *)link{
    if( _lastTimeStamp ){
        CFTimeInterval gap = link.timestamp - _lastTimeStamp;
        if( gap > _threathold ){
            NSLog( @"NNUIThreadBlockObserver: %@ms UIスレッドがブロックされました", @(ceil(gap*1000)) );
        }
    }
    _lastTimeStamp = link.timestamp;
}



@end
