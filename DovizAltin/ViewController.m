//
//  ViewController.m
//  DovizAltin
//
//  Created by user30357 on 6/22/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import "ViewController.h"
#import "APIClient.h"
#import "GoldTableViewController.h"

@interface ViewController ()
@property (nonatomic, retain) IBOutlet UISegmentedControl *typeSegmentedControl;
@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (nonatomic, weak) UIViewController *currentViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Adding user.
    [APIClient AddUser];
    
    //Adding the inital viewController.
    UIViewController *vc = [self viewControllerForSegmentIndex:self.typeSegmentedControl.selectedSegmentIndex];
    [self addChildViewController:vc];
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
    self.currentViewController = vc;
}

-(BOOL)shouldAutorotate{
    return NO;
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    UIViewController *vc = [self viewControllerForSegmentIndex:sender.selectedSegmentIndex];
    [self addChildViewController:vc];
    [self transitionFromViewController:self.currentViewController toViewController:vc duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
    } completion:^(BOOL finished) {
        [self.currentViewController.view removeFromSuperview];
        vc.view.frame = self.contentView.bounds;
        [self.contentView addSubview:vc.view];
        [vc didMoveToParentViewController:self];
        [self.currentViewController removeFromParentViewController];
        self.currentViewController = vc;
    }];
}

- (UIViewController *)viewControllerForSegmentIndex:(NSInteger)index {
    UIViewController *vc;
    switch (index) {
        case 0:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrencyViewController"];
            break;
        case 1:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GoldViewController"];
            break;
        case 2:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AlarmViewController"];
            break;
        default:
            break;
    }
    return vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
