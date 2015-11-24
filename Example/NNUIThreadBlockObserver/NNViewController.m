//
//  NNViewController.m
//  NNUIThreadBlockObserver
//
//  Created by Koichi Yamamoto on 11/25/2015.
//  Copyright (c) 2015 Koichi Yamamoto. All rights reserved.
//

#import "NNViewController.h"


@implementation NNViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)sleep:(id)sender{
    sleep(1);
}

@end
