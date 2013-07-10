//
//  ModelController.m
//  ChildrenBook2
//
//  Created by yueling zhang on 4/13/13.
//  Copyright (c) 2013 yueling. All rights reserved.
//

#import "ModelController.h"
#import "DataViewController.h"
/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface ModelController()

@property (readonly, strong, nonatomic) NSArray *pageData;
@property (readonly, strong, nonatomic) NSArray *pageText;
@property (readonly, strong, nonatomic) NSArray *pageRecord;

@end

@implementation ModelController

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
        
        _pageData = [NSArray arrayWithObjects:@"page_play",@"page_notstudy",@"page_grandma",
                                                @"page_ask",@"page_answer",@"page_surprise",@"page_explain",@"page_shame",@"page_study",@"page_poet",nil];
        _pageText = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"Li Bai was a famous poet. \nHowever, he was very playful when he was a kid.", nil],
                                            [NSArray arrayWithObjects:@"One day, he escaped school again. \nHe was walking in the field and feeling the sunshine. ", nil],
                                            [NSArray arrayWithObjects:@"Then he saw a grandma working near a grass hut.\nHe came up.", nil],
                                            [NSArray arrayWithObjects:@"Li Bai asked, \n\"What are you doing, grandma?\"", nil],
                                            [NSArray arrayWithObjects:@"The grandma smiled to him and said, \n\"I’m grinding the iron rod into a needle.\"", nil],
                                            [NSArray arrayWithObjects:@"Li Bai was shocked and said, \n\"What? How’s that possible?\"", nil],
                                            [NSArray arrayWithObjects:@"The grandma said, \"The iron rod is very thick, but if I work hard enough every day, I can grind the iron rod into a needle someday!\" \nI believe if I work harder than others, I can do anything.\"", nil],
                                            [NSArray arrayWithObjects:@"After hearing this, \nLi Bai was ashamed. ", nil],
                                            [NSArray arrayWithObjects:@"After then, Li Bai worked very hard, \nand never escaped from school. ", nil],
                                            [NSArray arrayWithObjects:@"Finally, \nLi Bai became one of the most famous poets in the Tang Dynasty.", nil],
                                            nil];
        
        _pageRecord = [NSArray arrayWithObjects:@"playful",@"escape",@"saw",@"ask",@"answer",@"surprise",
                       @"explain",@"ashamed",@"study",@"finally", nil];
        
    }
    return self;
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];   
    [defaults setObject: [[NSNumber alloc] initWithInt:index ] forKey:@"currentPage"];
     NSLog(@"Defaults:%@",[defaults dictionaryRepresentation]);
    [[NSUserDefaults standardUserDefaults] synchronize];

    // Create a new view controller and pass suitable data.
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.dataObject = self.pageData[index];
    dataViewController.textObject = self.pageText[index];
    dataViewController.recordObject = self.pageRecord[index];
    
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController
{   
     // Return the index of the given data view controller.
     // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
