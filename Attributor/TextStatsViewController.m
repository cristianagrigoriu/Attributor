//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Cristiana on 18/06/15.
//  Copyright (c) 2015 Cristiana. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colourfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

//-(void) viewDidLoad
//{
//    [super viewDidLoad];
//    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"testarea" attributes:@{NSForegroundColorAttributeName : [UIColor greenColor], NSStrokeWidthAttributeName : @-3}];
//}

- (void) setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    if (self.view.window) [self updateUI];//if window = nil, I'm not on screen; it only updates the stats if I'm on screen; otherwise viewWillAppear does it
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    self.colourfulCharactersLabel.text = [NSString stringWithFormat:@"%lu colourful characters", (unsigned long)[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu outlined characters", (unsigned long)[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
    
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index++;
        }
    }
    return characters;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
