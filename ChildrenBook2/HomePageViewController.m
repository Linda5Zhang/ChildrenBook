//
//  HomePageViewController.m
//  ChildrenBook2
//
//  Created by yueling zhang on 4/13/13.
//  Copyright (c) 2013 yueling. All rights reserved.
//

#import "HomePageViewController.h"
#import "CreditsTableViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface HomePageViewController ()

// Class extension methods (note they do not have to be explicitly defined, compiler will identify them)
- (void)addGestureRecognizersToBird:(UIView *)piece;
- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer;
- (void)rotatePiece:(UIRotationGestureRecognizer *)gestureRecognizer;
- (void)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer;
- (void)playSoundEffect:(NSString*)soundName;


@end

@implementation HomePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.homePageImage setAlpha:0];
    [self.birdImage setAlpha:0];
    [self.birdLabel setAlpha:0];
    
    self.birdImage.userInteractionEnabled = YES;
    [self.view addSubview:self.birdImage];
    
    [self startAnimation];
    [self birdAnimation];
    
    [self addGestureRecognizersToBird:self.birdImage];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startAnimation
{
    [UIView animateWithDuration:1.5 animations:^{ [self.homePageImage setAlpha:1 ];}
     ];
    NSLog(@"startAnimation(Home page image animation) did appear!");
}

-(void)birdAnimation
{
    self.birdImage.center = CGPointMake(700, 200);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    self.birdImage.alpha = 1;
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    self.birdImage.center = CGPointMake(200, 200);
    [UIView commitAnimations];
    NSLog(@"birdAnimation(The bird fly animation) did appear!");
    
    [self alertAnimation];
}

-(void)alertAnimation
{
    self.birdLabel.center = CGPointMake(311, 33);
    [UIView beginAnimations:@"alert" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelay:1.5];
    self.birdLabel.alpha = 1;
    [UIView setAnimationRepeatCount:2];
    [UIView setAnimationRepeatAutoreverses:YES];
    
    CGPoint center = CGPointMake(311, 30);
    if(center.y > self.birdLabel.center.y) {
        center.y -= 5.0f;
        self.birdLabel.center = center;
    } else {
        center.y += 5.0f;
        self.birdLabel.center = center;
    }
    [UIView commitAnimations];
    
    NSLog(@"alertAnimation(show tips about dragging the bird animation) did appear!");
}


/*******************************************************************************
 * @method          addGestureToOrnament:
 * @abstract        Add gestures to the bird to detect rotation, translation, and scaling
 * @description
 ******************************************************************************/
- (void)addGestureRecognizersToBird:(UIView *)piece
{
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotatePiece:)];
    [piece addGestureRecognizer:rotationGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
    [pinchGesture setDelegate:self];
    [piece addGestureRecognizer:pinchGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
    [piece addGestureRecognizer:panGesture];
    
}

/*******************************************************************************
 * @method      panPiece:
 * @abstract    <# abstract #>
 * @description shift the piece's center by the pan amount
 *              reset the gesture recognizer's translation to {0, 0} after applying so the next
 *              callback is a delta from the current position
 *******************************************************************************/
- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *piece = [gestureRecognizer view];
    [[piece superview] bringSubviewToFront:piece];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
    [self playSoundEffect:@"birdsound"];
}

/*******************************************************************************
 * @method      rotatePiece:
 * @abstract    <# abstract #>
 * @description rotate the piece by the current rotation
 *              reset the gesture recognizer's rotation to 0 after applying so
 *              the next callback is a delta from the current rotation
 *******************************************************************************/
- (void)rotatePiece:(UIRotationGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformRotate([[gestureRecognizer view] transform], [gestureRecognizer rotation]);
        [gestureRecognizer setRotation:0];
    }
    
}

/*******************************************************************************
 * @method      scalePiece
 * @abstract
 * @description Scale the piece by the current scale; reset the gesture recognizer's
 *              rotation to 0 after applying so the next callback is a delta from the current scale
 *******************************************************************************/
- (void)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
        [gestureRecognizer setScale:1];
    }
    
}

- (IBAction)tapCredits:(id)sender
{
    CreditsTableViewController *ctvc = [[CreditsTableViewController alloc] initWithNibName:@"CreditsTableViewController" bundle:nil];
    [self.navigationController pushViewController:ctvc animated:YES];
}

#pragma mark - Sound Effect
/*******************************************************************************
 * @method          playSoundEffect
 * @abstract        Play a short sound when the bird is dragged
 * @description     <# Description #>
 ******************************************************************************/
- (void)playSoundEffect:(NSString*)soundName
{
    NSLog(@">>> Play sound named: %@",soundName);
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:soundName ofType:@"aiff"];
    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundID);
    AudioServicesPlaySystemSound(soundID);
    NSLog(@"the sound effect did play.");
}

@end
