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
            [self logWithGap:gap];
        }
    }
    _lastTimeStamp = link.timestamp;
}


-(void)logWithGap:(CFTimeInterval)gap{
    NSNumber* number = [[NSNumber alloc] initWithDouble:gap];
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.minimumFractionDigits = 3;
    formatter.maximumFractionDigits = 3;
    NSString* string = [formatter stringFromNumber:number];
    NSLog( @"NNUIThreadBlockObserver: %@秒間 UIスレッドがブロックされました", string );
}


@end
