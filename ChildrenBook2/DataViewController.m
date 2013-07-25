//
//  DataViewController.m
//  ChildrenBook2
//
//  Created by yueling zhang on 4/13/13.
//  Copyright (c) 2013 yueling. All rights reserved.
//

#import "DataViewController.h"
#import "HomePageViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ModelController.h"

@interface DataViewController ()
@property (strong, nonatomic) AVAudioPlayer *paragraph1;

@end

@implementation DataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *infoString1 = [[NSString alloc] initWithString:self.textObject[0]];
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:infoString1];
    NSInteger stringLength=[infoString1 length];
    
    UIColor *color = [UIColor blueColor];
    UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:20.0f];

    NSShadow *shadowDic=[[NSShadow alloc] init];
    [shadowDic setShadowBlurRadius:5.0];
    [shadowDic setShadowColor:[UIColor grayColor]];
    [shadowDic setShadowOffset:CGSizeMake(0, 3)];
    
    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, stringLength)];
//    NSLog(@"%@",attString);
    [attString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, stringLength)];
    [attString addAttribute:NSShadowAttributeName value:shadowDic range:NSMakeRange(0, stringLength)];
    
    self.dataImage.image = [UIImage imageNamed:self.dataObject];
    self.labelOne.attributedText = attString;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.paragraph1 stop];
}

/*******************************************************************************
 * @method      ReadForMe
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void)readForMe
{
    NSError *error;
    NSString *paragraph1Path = [[NSBundle mainBundle] pathForResource:(NSString *)self.recordObject ofType:@"aiff"];
    NSLog(@"the record file name is %@",self.recordObject);
    NSURL *backgroundMusicURL = [NSURL fileURLWithPath:paragraph1Path];
    
    _paragraph1 = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    [self.paragraph1 prepareToPlay];
    [self.paragraph1 play];

}

- (IBAction)readButton:(id)sender
{
    [self readForMe];
    [self prepareForHighlightWords];

}

- (void)highlightWords:(NSTimer *)theTimer
{
//    NSLog(@"%@",[theTimer userInfo]);
    NSString *page1String = [[NSString alloc] initWithString:self.textObject[0]];
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:page1String];
    NSInteger stringLength=[page1String length];
    
    UIColor *highlightColor = [UIColor greenColor];
    UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    
    NSShadow *shadowDic=[[NSShadow alloc] init];
    [shadowDic setShadowBlurRadius:5.0];
    [shadowDic setShadowColor:[UIColor grayColor]];
    [shadowDic setShadowOffset:CGSizeMake(0, 3)];
    
    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, stringLength)];

    [attString addAttribute:NSForegroundColorAttributeName value:highlightColor range:NSMakeRange([[[theTimer userInfo] objectForKey:@"startIndex"] integerValue],[[[theTimer userInfo] objectForKey:@"wordLength"] integerValue])];
    [attString addAttribute:NSShadowAttributeName value:shadowDic range:NSMakeRange(0, stringLength)];
    
    self.labelOne.attributedText = attString;
    NSLog(@"highlight words did happen!");
}

- (void)prepareForHighlightWords
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSTimer *timer;
    
    NSArray *timeStart0_playful = [[NSArray alloc] initWithObjects:@"0.095", @"1.325", @"2.101", @"2.726", @"3.597",
                                   @"4.959", @"6.549", @"7.079", @"7.874", @"8.972",
                                   @"10.108", @"10.676",@"11.603",@"12.152",@"12.417",nil];
    
    NSArray *theRange0_playful = [[NSArray alloc] initWithObjects:@{@"startIndex": [NSNumber numberWithInt: 0], @"wordLength": [NSNumber numberWithInt:6]},
                                  @{@"startIndex": [NSNumber numberWithInt: 7], @"wordLength": [NSNumber numberWithInt:3]},
                                  @{@"startIndex": [NSNumber numberWithInt: 11], @"wordLength": [NSNumber numberWithInt:1]},
                                  @{@"startIndex": [NSNumber numberWithInt: 13], @"wordLength": [NSNumber numberWithInt:6]},
                                  @{@"startIndex": [NSNumber numberWithInt: 20], @"wordLength": [NSNumber numberWithInt:5]},
                                  
                                  @{@"startIndex": [NSNumber numberWithInt: 26], @"wordLength": [NSNumber numberWithInt:9]},
                                  @{@"startIndex": [NSNumber numberWithInt: 36], @"wordLength": [NSNumber numberWithInt:2]},
                                  @{@"startIndex": [NSNumber numberWithInt: 39], @"wordLength": [NSNumber numberWithInt:3]},
                                  @{@"startIndex": [NSNumber numberWithInt: 43], @"wordLength": [NSNumber numberWithInt:4]},
                                  @{@"startIndex": [NSNumber numberWithInt: 48], @"wordLength": [NSNumber numberWithInt:7]},
                                  
                                  @{@"startIndex": [NSNumber numberWithInt: 56], @"wordLength": [NSNumber numberWithInt:4]},
                                  @{@"startIndex": [NSNumber numberWithInt: 61], @"wordLength": [NSNumber numberWithInt:2]},
                                  @{@"startIndex": [NSNumber numberWithInt: 64], @"wordLength": [NSNumber numberWithInt:3]},
                                  @{@"startIndex": [NSNumber numberWithInt: 68], @"wordLength": [NSNumber numberWithInt:1]},
                                  @{@"startIndex": [NSNumber numberWithInt: 70], @"wordLength": [NSNumber numberWithInt:4]},
                                  nil];
    
    
    NSArray *timeStart1_escape = [[NSArray alloc] initWithObjects:@"0.092", @"0.770", @"1.631", @"2.254", @"3.500",
                                  @"4.123", @"5.827", @"6.303", @"7.109", @"8.227",
                                  @"8.392", @"8.685",@"9.766",@"10.701",@"11.305",
                                  @"11.654",nil];
    
    NSArray *theRange1_escape = [[NSArray alloc] initWithObjects:@{@"startIndex": [NSNumber numberWithInt: 0], @"wordLength": [NSNumber numberWithInt:3]},
                                 @{@"startIndex": [NSNumber numberWithInt: 4], @"wordLength": [NSNumber numberWithInt:4]},
                                 @{@"startIndex": [NSNumber numberWithInt: 9], @"wordLength": [NSNumber numberWithInt:2]},
                                 @{@"startIndex": [NSNumber numberWithInt: 12], @"wordLength": [NSNumber numberWithInt:7]},
                                 @{@"startIndex": [NSNumber numberWithInt: 20], @"wordLength": [NSNumber numberWithInt:6]},
                                 
                                 @{@"startIndex": [NSNumber numberWithInt: 27], @"wordLength": [NSNumber numberWithInt:6]},
                                 @{@"startIndex": [NSNumber numberWithInt: 35], @"wordLength": [NSNumber numberWithInt:2]},
                                 @{@"startIndex": [NSNumber numberWithInt: 38], @"wordLength": [NSNumber numberWithInt:3]},
                                 @{@"startIndex": [NSNumber numberWithInt: 42], @"wordLength": [NSNumber numberWithInt:7]},
                                 @{@"startIndex": [NSNumber numberWithInt: 50], @"wordLength": [NSNumber numberWithInt:2]},
                                 
                                 @{@"startIndex": [NSNumber numberWithInt: 53], @"wordLength": [NSNumber numberWithInt:3]},
                                 @{@"startIndex": [NSNumber numberWithInt: 57], @"wordLength": [NSNumber numberWithInt:5]},
                                 @{@"startIndex": [NSNumber numberWithInt: 63], @"wordLength": [NSNumber numberWithInt:3]},
                                 @{@"startIndex": [NSNumber numberWithInt: 67], @"wordLength": [NSNumber numberWithInt:7]},
                                 @{@"startIndex": [NSNumber numberWithInt: 75], @"wordLength": [NSNumber numberWithInt:3]},
                                 
                                 @{@"startIndex": [NSNumber numberWithInt: 79], @"wordLength": [NSNumber numberWithInt:9]},
                                 nil];
    
    
    NSArray *timeStart2_saw = [[NSArray alloc] initWithObjects:@"0.087", @"0.873", @"1.172", @"1.621", @"2.032",
                               @"3.366", @"4.239", @"4.725",@"5.473", @"5.785",
                               @"7.331",@"7.780", @"8.154",nil];
    
    NSArray *theRange2_saw = [[NSArray alloc] initWithObjects:@{@"startIndex": [NSNumber numberWithInt: 0], @"wordLength": [NSNumber numberWithInt:4]},
                              @{@"startIndex": [NSNumber numberWithInt: 5], @"wordLength": [NSNumber numberWithInt:2]},
                              @{@"startIndex": [NSNumber numberWithInt: 8], @"wordLength": [NSNumber numberWithInt:3]},
                              @{@"startIndex": [NSNumber numberWithInt: 12], @"wordLength": [NSNumber numberWithInt:1]},
                              @{@"startIndex": [NSNumber numberWithInt: 14], @"wordLength": [NSNumber numberWithInt:7]},
                              
                              @{@"startIndex": [NSNumber numberWithInt: 22], @"wordLength": [NSNumber numberWithInt:7]},
                              @{@"startIndex": [NSNumber numberWithInt: 30], @"wordLength": [NSNumber numberWithInt:4]},
                              @{@"startIndex": [NSNumber numberWithInt: 35], @"wordLength": [NSNumber numberWithInt:1]},
                              @{@"startIndex": [NSNumber numberWithInt: 37], @"wordLength": [NSNumber numberWithInt:5]},
                              @{@"startIndex": [NSNumber numberWithInt: 43], @"wordLength": [NSNumber numberWithInt:4]},
                              
                              @{@"startIndex": [NSNumber numberWithInt: 48], @"wordLength": [NSNumber numberWithInt:2]},
                              @{@"startIndex": [NSNumber numberWithInt: 51], @"wordLength": [NSNumber numberWithInt:4]},
                              @{@"startIndex": [NSNumber numberWithInt: 56], @"wordLength": [NSNumber numberWithInt:3]},
                              nil];
    
    
    NSArray *timeStart3_ask = [[NSArray alloc] initWithObjects:@"0.102", @"0.565", @"1.103", @"3.087", @"3.912",
                               @"4.126", @"4.765", @"5.470",nil];
    
    NSArray *theRange3_ask = [[NSArray alloc] initWithObjects:@{@"startIndex": [NSNumber numberWithInt: 0], @"wordLength": [NSNumber numberWithInt:2]},
                              @{@"startIndex": [NSNumber numberWithInt: 3], @"wordLength": [NSNumber numberWithInt:3]},
                              @{@"startIndex": [NSNumber numberWithInt: 7], @"wordLength": [NSNumber numberWithInt:6]},
                              @{@"startIndex": [NSNumber numberWithInt: 15], @"wordLength": [NSNumber numberWithInt:5]},
                              @{@"startIndex": [NSNumber numberWithInt: 21], @"wordLength": [NSNumber numberWithInt:3]},
                              
                              @{@"startIndex": [NSNumber numberWithInt: 25], @"wordLength": [NSNumber numberWithInt:3]},
                              @{@"startIndex": [NSNumber numberWithInt: 29], @"wordLength": [NSNumber numberWithInt:6]},
                              @{@"startIndex": [NSNumber numberWithInt: 36], @"wordLength": [NSNumber numberWithInt:9]},
                              nil];
    
    
    
    NSArray *timeStart4_answer = [[NSArray alloc] initWithObjects:@"0.091", @"0.620", @"1.749", @"2.861", @"3.226",
                                  @"4.355", @"4.702", @"7.034", @"7.654", @"8.692",
                                  @"9.203", @"9.768",@"10.478",@"11.335",@"11.681",nil];
    
    NSArray *theRange4_answer = [[NSArray alloc] initWithObjects:@{@"startIndex": [NSNumber numberWithInt: 0], @"wordLength": [NSNumber numberWithInt:3]},
                                 @{@"startIndex": [NSNumber numberWithInt: 4], @"wordLength": [NSNumber numberWithInt:7]},
                                 @{@"startIndex": [NSNumber numberWithInt: 12], @"wordLength": [NSNumber numberWithInt:6]},
                                 @{@"startIndex": [NSNumber numberWithInt: 19], @"wordLength": [NSNumber numberWithInt:2]},
                                 @{@"startIndex": [NSNumber numberWithInt: 22], @"wordLength": [NSNumber numberWithInt:3]},
                                 
                                 @{@"startIndex": [NSNumber numberWithInt: 26], @"wordLength": [NSNumber numberWithInt:3]},
                                 @{@"startIndex": [NSNumber numberWithInt: 30], @"wordLength": [NSNumber numberWithInt:5]},
                                 @{@"startIndex": [NSNumber numberWithInt: 37], @"wordLength": [NSNumber numberWithInt:4]},
                                 @{@"startIndex": [NSNumber numberWithInt: 42], @"wordLength": [NSNumber numberWithInt:8]},
                                 @{@"startIndex": [NSNumber numberWithInt: 51], @"wordLength": [NSNumber numberWithInt:3]},
                                 
                                 @{@"startIndex": [NSNumber numberWithInt: 55], @"wordLength": [NSNumber numberWithInt:4]},
                                 @{@"startIndex": [NSNumber numberWithInt: 60], @"wordLength": [NSNumber numberWithInt:3]},
                                 @{@"startIndex": [NSNumber numberWithInt: 64], @"wordLength": [NSNumber numberWithInt:4]},
                                 @{@"startIndex": [NSNumber numberWithInt: 69], @"wordLength": [NSNumber numberWithInt:1]},
                                 @{@"startIndex": [NSNumber numberWithInt: 71], @"wordLength": [NSNumber numberWithInt:8]},
                                 nil];
    
    
    
    NSArray *timeStart5_surprise = [[NSArray alloc] initWithObjects:@"0.000", @"0.503", @"1.468", @"1.944", @"3.482",
                                    @"3.985", @"5.830", @"7.607", @"8.305", @"8.711",nil];
    
    NSArray *theRange5_surprise = [[NSArray alloc] initWithObjects:@{@"startIndex": [NSNumber numberWithInt: 0], @"wordLength": [NSNumber numberWithInt:2]},
                                   @{@"startIndex": [NSNumber numberWithInt: 3], @"wordLength": [NSNumber numberWithInt:3]},
                                   @{@"startIndex": [NSNumber numberWithInt: 7], @"wordLength": [NSNumber numberWithInt:3]},
                                   @{@"startIndex": [NSNumber numberWithInt: 11], @"wordLength": [NSNumber numberWithInt:7]},
                                   @{@"startIndex": [NSNumber numberWithInt: 19], @"wordLength": [NSNumber numberWithInt:3]},
                                   
                                   @{@"startIndex": [NSNumber numberWithInt: 23], @"wordLength": [NSNumber numberWithInt:5]},
                                   @{@"startIndex": [NSNumber numberWithInt: 30], @"wordLength": [NSNumber numberWithInt:6]},
                                   @{@"startIndex": [NSNumber numberWithInt: 37], @"wordLength": [NSNumber numberWithInt:5]},
                                   @{@"startIndex": [NSNumber numberWithInt: 43], @"wordLength": [NSNumber numberWithInt:4]},
                                   @{@"startIndex": [NSNumber numberWithInt: 48], @"wordLength": [NSNumber numberWithInt:10]},
                                   nil];
    
    
    
    NSArray *timeStart6_explain = [[NSArray alloc] initWithObjects:@"0.000", @"0.593", @"1.631", @"4.301", @"5.042",
                                   @"6.031", @"6.476", @"7.215", @"7.860", @"9.739",
                                   @"10.678", @"11.271",@"11.864",@"12.408",@"13.199",
                                   @"13.842",@"14.386",@"15.671",@"16.066",@"16.660",
                                   @"17.549",@"17.994",@"18.538",@"19.378",@"20.466",
                                   @"21.750",@"22.592",@"25.041",@"25.360",@"26.794",
                                   @"27.189",@"27.782",@"28.425",@"29.562",@"30.056",
                                   @"31.787",@"32.133",@"32.528",@"33.171",nil];
    
    NSArray *theRange6_explain = [[NSArray alloc] initWithObjects:@{@"startIndex": [NSNumber numberWithInt: 0], @"wordLength": [NSNumber numberWithInt:3]},
                                  @{@"startIndex": [NSNumber numberWithInt: 4], @"wordLength": [NSNumber numberWithInt:7]},
                                  @{@"startIndex": [NSNumber numberWithInt: 12], @"wordLength": [NSNumber numberWithInt:5]},
                                  @{@"startIndex": [NSNumber numberWithInt: 18], @"wordLength": [NSNumber numberWithInt:4]},
                                  @{@"startIndex": [NSNumber numberWithInt: 23], @"wordLength": [NSNumber numberWithInt:4]},
                                  
                                  @{@"startIndex": [NSNumber numberWithInt: 28], @"wordLength": [NSNumber numberWithInt:3]},
                                  @{@"startIndex": [NSNumber numberWithInt: 32], @"wordLength": [NSNumber numberWithInt:2]},
                                  @{@"startIndex": [NSNumber numberWithInt: 35], @"wordLength": [NSNumber numberWithInt:4]},
                                  @{@"startIndex": [NSNumber numberWithInt: 40], @"wordLength": [NSNumber numberWithInt:6]},
                                  @{@"startIndex": [NSNumber numberWithInt: 47], @"wordLength": [NSNumber numberWithInt:3]},
                                  
                                  @{@"startIndex": [NSNumber numberWithInt: 51], @"wordLength": [NSNumber numberWithInt:2]},
                                  @{@"startIndex": [NSNumber numberWithInt: 54], @"wordLength": [NSNumber numberWithInt:1]},
                                  @{@"startIndex": [NSNumber numberWithInt: 56], @"wordLength": [NSNumber numberWithInt:4]},
                                  @{@"startIndex": [NSNumber numberWithInt: 61], @"wordLength": [NSNumber numberWithInt:4]},
                                  @{@"startIndex": [NSNumber numberWithInt: 66], @"wordLength": [NSNumber numberWithInt:6]},
                                  
                                  @{@"startIndex": [NSNumber numberWithInt: 73], @"wordLength": [NSNumber numberWithInt:5]},
                                  @{@"startIndex": [NSNumber numberWithInt: 79], @"wordLength": [NSNumber numberWithInt:4]},
                                  @{@"startIndex": [NSNumber numberWithInt: 84], @"wordLength": [NSNumber numberWithInt:1]},
                                  @{@"startIndex": [NSNumber numberWithInt: 86], @"wordLength": [NSNumber numberWithInt:3]},
                                  @{@"startIndex": [NSNumber numberWithInt: 90], @"wordLength": [NSNumber numberWithInt:5]},
                                  
                                  @{@"startIndex": [NSNumber numberWithInt: 96], @"wordLength": [NSNumber numberWithInt:3]},
                                  @{@"startIndex": [NSNumber numberWithInt: 100], @"wordLength": [NSNumber numberWithInt:4]},
                                  @{@"startIndex": [NSNumber numberWithInt: 105], @"wordLength": [NSNumber numberWithInt:3]},
                                  @{@"startIndex": [NSNumber numberWithInt: 109], @"wordLength": [NSNumber numberWithInt:4]},
                                  @{@"startIndex": [NSNumber numberWithInt: 114], @"wordLength": [NSNumber numberWithInt:1]},
                                  
                                  @{@"startIndex": [NSNumber numberWithInt: 116], @"wordLength": [NSNumber numberWithInt:6]},
                                  @{@"startIndex": [NSNumber numberWithInt: 123], @"wordLength": [NSNumber numberWithInt:9]},
                                  @{@"startIndex": [NSNumber numberWithInt: 134], @"wordLength": [NSNumber numberWithInt:1]},
                                  @{@"startIndex": [NSNumber numberWithInt: 136], @"wordLength": [NSNumber numberWithInt:7]},
                                  @{@"startIndex": [NSNumber numberWithInt: 144], @"wordLength": [NSNumber numberWithInt:2]},
                                  
                                  @{@"startIndex": [NSNumber numberWithInt: 147], @"wordLength": [NSNumber numberWithInt:1]},
                                  @{@"startIndex": [NSNumber numberWithInt: 149], @"wordLength": [NSNumber numberWithInt:4]},
                                  @{@"startIndex": [NSNumber numberWithInt: 154], @"wordLength": [NSNumber numberWithInt:6]},
                                  @{@"startIndex": [NSNumber numberWithInt: 161], @"wordLength": [NSNumber numberWithInt:4]},
                                  @{@"startIndex": [NSNumber numberWithInt: 166], @"wordLength": [NSNumber numberWithInt:7]},
                                  
                                  @{@"startIndex": [NSNumber numberWithInt: 174], @"wordLength": [NSNumber numberWithInt:1]},
                                  @{@"startIndex": [NSNumber numberWithInt: 176], @"wordLength": [NSNumber numberWithInt:3]},
                                  @{@"startIndex": [NSNumber numberWithInt: 180], @"wordLength": [NSNumber numberWithInt:2]},
                                  @{@"startIndex": [NSNumber numberWithInt: 183], @"wordLength": [NSNumber numberWithInt:10]},
                                  nil];
    
    
    
    NSArray *timeStart7_ashamed = [[NSArray alloc] initWithObjects:@"0.053", @"1.021", @"1.711", @"2.912", @"3.332",
                                   @"3.880", @"4.270",nil];
    
    NSArray *theRange7_ashamed = [[NSArray alloc] initWithObjects:@{@"startIndex": [NSNumber numberWithInt: 0], @"wordLength": [NSNumber numberWithInt:5]},
                                  @{@"startIndex": [NSNumber numberWithInt: 6], @"wordLength": [NSNumber numberWithInt:7]},
                                  @{@"startIndex": [NSNumber numberWithInt: 14], @"wordLength": [NSNumber numberWithInt:5]},
                                  @{@"startIndex": [NSNumber numberWithInt: 21], @"wordLength": [NSNumber numberWithInt:2]},
                                  @{@"startIndex": [NSNumber numberWithInt: 24], @"wordLength": [NSNumber numberWithInt:3]},
                                  
                                  @{@"startIndex": [NSNumber numberWithInt: 28], @"wordLength": [NSNumber numberWithInt:3]},
                                  @{@"startIndex": [NSNumber numberWithInt: 32], @"wordLength": [NSNumber numberWithInt:8]},
                                  nil];
    
    
    
    NSArray *timeStart8_study = [[NSArray alloc] initWithObjects:@"0.115", @"0.772", @"1.815", @"2.214", @"2.819",
                                 @"3.553", @"4.145", @"5.818", @"6.102", @"6.913",
                                 @"7.904", @"8.238",nil];
    
    NSArray *theRange8_study = [[NSArray alloc] initWithObjects:@{@"startIndex": [NSNumber numberWithInt: 0], @"wordLength": [NSNumber numberWithInt:5]},
                                @{@"startIndex": [NSNumber numberWithInt: 6], @"wordLength": [NSNumber numberWithInt:5]},
                                @{@"startIndex": [NSNumber numberWithInt: 12], @"wordLength": [NSNumber numberWithInt:2]},
                                @{@"startIndex": [NSNumber numberWithInt: 15], @"wordLength": [NSNumber numberWithInt:3]},
                                @{@"startIndex": [NSNumber numberWithInt: 19], @"wordLength": [NSNumber numberWithInt:6]},
                                
                                @{@"startIndex": [NSNumber numberWithInt: 26], @"wordLength": [NSNumber numberWithInt:4]},
                                @{@"startIndex": [NSNumber numberWithInt: 31], @"wordLength": [NSNumber numberWithInt:5]},
                                @{@"startIndex": [NSNumber numberWithInt: 38], @"wordLength": [NSNumber numberWithInt:3]},
                                @{@"startIndex": [NSNumber numberWithInt: 42], @"wordLength": [NSNumber numberWithInt:5]},
                                @{@"startIndex": [NSNumber numberWithInt: 48], @"wordLength": [NSNumber numberWithInt:7]},
                                
                                @{@"startIndex": [NSNumber numberWithInt: 56], @"wordLength": [NSNumber numberWithInt:4]},
                                @{@"startIndex": [NSNumber numberWithInt: 61], @"wordLength": [NSNumber numberWithInt:7]},
                                nil];
    
    
    NSArray *timeStart9_poet = [[NSArray alloc] initWithObjects:@"0.146", @"1.578", @"1.952", @"2.684", @"3.628",
                                @"4.035", @"4.442", @"4.702", @"5.545", @"6.178",
                                @"7.321", @"7.744", @"8.086",@"8.915",nil];
    
    NSArray *theRange9_poet = [[NSArray alloc] initWithObjects:@{@"startIndex": [NSNumber numberWithInt: 0], @"wordLength": [NSNumber numberWithInt:8]},
                               @{@"startIndex": [NSNumber numberWithInt: 10], @"wordLength": [NSNumber numberWithInt:2]},
                               @{@"startIndex": [NSNumber numberWithInt: 13], @"wordLength": [NSNumber numberWithInt:3]},
                               @{@"startIndex": [NSNumber numberWithInt: 17], @"wordLength": [NSNumber numberWithInt:6]},
                               @{@"startIndex": [NSNumber numberWithInt: 24], @"wordLength": [NSNumber numberWithInt:3]},
                               
                               @{@"startIndex": [NSNumber numberWithInt: 28], @"wordLength": [NSNumber numberWithInt:2]},
                               @{@"startIndex": [NSNumber numberWithInt: 31], @"wordLength": [NSNumber numberWithInt:3]},
                               @{@"startIndex": [NSNumber numberWithInt: 35], @"wordLength": [NSNumber numberWithInt:4]},
                               @{@"startIndex": [NSNumber numberWithInt: 40], @"wordLength": [NSNumber numberWithInt:6]},
                               @{@"startIndex": [NSNumber numberWithInt: 47], @"wordLength": [NSNumber numberWithInt:5]},
                               
                               @{@"startIndex": [NSNumber numberWithInt: 53], @"wordLength": [NSNumber numberWithInt:2]},
                               @{@"startIndex": [NSNumber numberWithInt: 56], @"wordLength": [NSNumber numberWithInt:3]},
                               @{@"startIndex": [NSNumber numberWithInt: 60], @"wordLength": [NSNumber numberWithInt:4]},
                               @{@"startIndex": [NSNumber numberWithInt: 65], @"wordLength": [NSNumber numberWithInt:8]},
                               nil];
    
    
    
    if ([[defaults objectForKey:@"currentPage"] isEqualToNumber:[NSNumber numberWithInt: 0]]) {
        for (int i=0; i<15; i++) {
            timer = [NSTimer scheduledTimerWithTimeInterval:[timeStart0_playful[i] doubleValue]
                                                     target:self
                                                   selector:@selector(highlightWords:)
                                                   userInfo:theRange0_playful[i]
                                                    repeats:NO];
        }
        
    }
    else if ([[defaults objectForKey:@"currentPage"] isEqualToNumber:[NSNumber numberWithInt: 1]]){
        for (int i=0; i<16; i++) {
            timer = [NSTimer scheduledTimerWithTimeInterval:[timeStart1_escape[i] doubleValue]
                                                     target:self
                                                   selector:@selector(highlightWords:)
                                                   userInfo:theRange1_escape[i]
                                                    repeats:NO];
        }
    }
    else if ([[defaults objectForKey:@"currentPage"] isEqualToNumber:[NSNumber numberWithInt: 2]]){
        for (int i=0; i<13; i++) {
            timer = [NSTimer scheduledTimerWithTimeInterval:[timeStart2_saw[i] doubleValue]
                                                     target:self
                                                   selector:@selector(highlightWords:)
                                                   userInfo:theRange2_saw[i]
                                                    repeats:NO];
        }
    }
    else if ([[defaults objectForKey:@"currentPage"] isEqualToNumber:[NSNumber numberWithInt: 3]]){
        for (int i=0; i<8; i++) {
            timer = [NSTimer scheduledTimerWithTimeInterval:[timeStart3_ask[i] doubleValue]
                                                     target:self
                                                   selector:@selector(highlightWords:)
                                                   userInfo:theRange3_ask[i]
                                                    repeats:NO];
        }
    }
    else if ([[defaults objectForKey:@"currentPage"] isEqualToNumber:[NSNumber numberWithInt: 4]]){
        for (int i=0; i<15; i++) {
            timer = [NSTimer scheduledTimerWithTimeInterval:[timeStart4_answer[i] doubleValue]
                                                     target:self
                                                   selector:@selector(highlightWords:)
                                                   userInfo:theRange4_answer[i]
                                                    repeats:NO];
        }
    }
    else if ([[defaults objectForKey:@"currentPage"] isEqualToNumber:[NSNumber numberWithInt: 5]]){
        for (int i=0; i<10; i++) {
            timer = [NSTimer scheduledTimerWithTimeInterval:[timeStart5_surprise[i] doubleValue]
                                                     target:self
                                                   selector:@selector(highlightWords:)
                                                   userInfo:theRange5_surprise[i]
                                                    repeats:NO];
        }
    }
    
    
    
    
    else if ([[defaults objectForKey:@"currentPage"] isEqualToNumber:[NSNumber numberWithInt: 6]]){
        for (int i=0; i<39; i++) {
            timer = [NSTimer scheduledTimerWithTimeInterval:[timeStart6_explain[i] doubleValue]
                                                     target:self
                                                   selector:@selector(highlightWords:)
                                                   userInfo:theRange6_explain[i]
                                                    repeats:NO];
        }
    }
    
    
    
    
    else if ([[defaults objectForKey:@"currentPage"] isEqualToNumber:[NSNumber numberWithInt: 7]]){
        for (int i=0; i<7; i++) {
            timer = [NSTimer scheduledTimerWithTimeInterval:[timeStart7_ashamed[i] doubleValue]
                                                     target:self
                                                   selector:@selector(highlightWords:)
                                                   userInfo:theRange7_ashamed[i]
                                                    repeats:NO];
        }
    }
    else if ([[defaults objectForKey:@"currentPage"] isEqualToNumber:[NSNumber numberWithInt: 8]]){
        for (int i=0; i<12; i++) {
            timer = [NSTimer scheduledTimerWithTimeInterval:[timeStart8_study[i] doubleValue]
                                                     target:self
                                                   selector:@selector(highlightWords:)
                                                   userInfo:theRange8_study[i]
                                                    repeats:NO];
        }
    }
    else{
        for (int i=0; i<14; i++) {
            timer = [NSTimer scheduledTimerWithTimeInterval:[timeStart9_poet[i] doubleValue]
                                                     target:self
                                                   selector:@selector(highlightWords:)
                                                   userInfo:theRange9_poet[i]
                                                    repeats:NO];
        }
    }
}



@end
