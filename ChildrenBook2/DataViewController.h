//
//  DataViewController.h
//  ChildrenBook2
//
//  Created by yueling zhang on 4/13/13.
//  Copyright (c) 2013 yueling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController

@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) id textObject;
@property (strong, nonatomic) id recordObject;

@property (weak, nonatomic) IBOutlet UIImageView *dataImage;
@property (weak, nonatomic) IBOutlet UILabel *labelOne;

- (IBAction)readButton:(id)sender;

@end
