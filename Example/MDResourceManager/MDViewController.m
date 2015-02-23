//
//  MDViewController.m
//  MDResourceManager
//
//  Created by Joao Prudencio on 02/20/2015.
//  Copyright (c) 2014 Joao Prudencio. All rights reserved.
//

#import "MDViewController.h"
#import "MDResourceManager.h"
#import "MDAppDelegate.h"

@interface MDViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation MDViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    [self populateViews];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    [self populateViews];
}

- (void)populateViews {
    
    MDResourceManager *resourceManager = [MDAppDelegate sharedInstance].resourceManager;
    
////    CGFloat labelFontSize = [resourceManager floatForKey:@"labelFontSize"];
//    
//    self.label.font = [UIFont fontWithName:@"GillSans"
//                                      size:labelFontSize];
//    self.label.text = [NSString stringWithFormat:@"Font size %.02f",labelFontSize];
}

@end
