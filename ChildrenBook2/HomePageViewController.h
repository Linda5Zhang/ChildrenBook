//
//  HomePageViewController.h
//  ChildrenBook2
//
//  Created by yueling zhang on 4/13/13.
//  Copyright (c) 2013 yueling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageViewController : UIViewController<UIGestureRecognizerDelegate>

- (IBAction)tapCredits:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *homePageImage;

@property (weak, nonatomic) IBOutlet UIImageView *birdImage;

@property (weak, nonatomic) IBOutlet UILabel *birdLabel;


@end
