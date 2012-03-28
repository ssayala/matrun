//Copyright 2011 Sunil Sayala

//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "StatsResetDelegate.h"

@interface MathViewController : UIViewController 
<UIAlertViewDelegate, StatsResetDelegate> {
    CGPoint gestureStartPoint;
    NSInteger correctAnswerCount;
    NSInteger wrongAttemptCount;
    SystemSoundID tingSoundID;
    SystemSoundID buzzerSoundID;
    NSInteger problemCount;
    BOOL wrongAnswerSelected;
    BOOL topHigher;
}

@property (nonatomic, retain) IBOutlet UILabel *topLabel;
@property (nonatomic, retain) IBOutlet UILabel *bottomLabel;
@property (nonatomic, retain) IBOutlet UILabel *sign;
@property (nonatomic, retain) IBOutlet UILabel *answerA;
@property (nonatomic, retain) IBOutlet UILabel *answerB;
@property (nonatomic, retain) IBOutlet UILabel *answerC;
@property (nonatomic, retain) IBOutlet UILabel *answerD;
-(void)resetStats;
-(IBAction)showStats;
-(IBAction)setNumbers;
-(UIFont *)getFont;
-(UIFont *)getFont:(NSString*)fontName fontSize:(CGFloat)fontSize;
-(NSInteger)doOperation:(NSInteger)topNumber bottomNumber:(NSInteger)bottom;
-(NSInteger)getNextWrongAnswer:(NSInteger)count, ...;
-(void)highlightWrongAnswer:(UILabel *)answer;
-(void)initLabels;
-(NSString*)getOperationTitle;
-(NSString*)getOperationSymbol;

@end
