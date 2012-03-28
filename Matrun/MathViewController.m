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

#import "MathViewController.h"
#import "NSArrayHelpers.h"
#import "Digits.h"
#import "StatsViewController.h"

#define kMinimumGestureLength    25
#define kMaximumVariance         5

@implementation MathViewController
@synthesize topLabel;
@synthesize bottomLabel;
@synthesize sign;
@synthesize answerA;
@synthesize answerB;
@synthesize answerC;
@synthesize answerD;

-(NSString *)getOperationTitle {
    return @"Math";
}

-(NSString *)getOperationSymbol {
    return @"";
}

-(NSInteger)doOperation:(NSInteger)topNumber bottomNumber:(NSInteger)bottom {
    return 0;
}

-(NSInteger)getNextWrongAnswer:(NSInteger)count,... {
    Digits *digits; 
    if (topHigher) {
        digits = [[Digits alloc] initWithTopHigher];
    }
    else {
        digits = [[Digits alloc] init];
        
    }    
    BOOL repeated = NO;
    NSInteger value;
    NSInteger operated;
    va_list args;
    
    do {
        
        [digits reset];
        operated = [self doOperation:digits.top bottomNumber:digits.bottom];
        repeated = NO;
        va_start(args, count);
        for( int i = 0; i < count; i++ ) {
            value = va_arg(args, NSInteger);
            if (value == operated) {
                repeated = YES;
                break;
            }
        }       
        va_end(args);

    } while (repeated);
    [digits release];
    return operated;
}

-(void)initLabels {
    answerA.highlighted = NO;
    answerB.highlighted = NO;
    answerC.highlighted = NO;
    answerD.highlighted = NO;
    answerD.hidden = NO;
    answerC.hidden = NO;
    answerB.hidden = NO;
}

-(void)resetStats {
    wrongAttemptCount = 0;
    correctAnswerCount = 0;
    problemCount = 0;
    [self setNumbers];
}

-(IBAction)showStats {
    StatsViewController *statsController = [[StatsViewController alloc] initWithNibName:@"StatsView" bundle:nil];
    [statsController setTotalCount:problemCount];
    [statsController setWrongAttemptCount:wrongAttemptCount];
    [statsController setCorrectAttemptCount:correctAnswerCount];
    statsController.sectionTitle = [self getOperationTitle];
    statsController.delegate = self;
   
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:statsController];
   
    [self presentModalViewController:navigationController animated:YES];
    [navigationController release];
    [statsController release];
}

-(IBAction)setNumbers {
   
    problemCount++;
    [self initLabels];
 
    Digits *digits; 
    if (topHigher) {
        digits = [[Digits alloc] initWithTopHigher];
    }
    else {
        digits = [[Digits alloc] init];

    }
    
    NSInteger correctAnswer = [self doOperation:digits.top bottomNumber:digits.bottom];
    topLabel.text = [NSString stringWithFormat:@"%d", digits.top];
    bottomLabel.text = [NSString stringWithFormat:@"%@ %d", [self getOperationSymbol],digits.bottom];
    answerA.text = [NSString stringWithFormat:@"%d", correctAnswer];
    [digits release];

    NSInteger wrongAnswerB = [self getNextWrongAnswer:1,correctAnswer];
    answerB.text = [NSString stringWithFormat:@"%d", wrongAnswerB];
    
    NSInteger wrongAnswerC = [self getNextWrongAnswer:2,correctAnswer, wrongAnswerB];
    answerC.text = [NSString stringWithFormat:@"%d", wrongAnswerC];
    
    NSInteger wrongAnswerD = [self getNextWrongAnswer:3, correctAnswer, wrongAnswerB, wrongAnswerC];
    answerD.text = [NSString stringWithFormat:@"%d", wrongAnswerD];
    
    //Shuffle the label positions
    NSArray *frames = [[NSArray arrayWithObjects: [NSValue valueWithCGRect:answerA.frame], [NSValue valueWithCGRect:answerB.frame], [NSValue valueWithCGRect:answerC.frame], [NSValue valueWithCGRect:answerD.frame], nil] shuffled];
    
    answerA.frame = [[frames objectAtIndex:0] CGRectValue];
    answerB.frame = [[frames objectAtIndex:1] CGRectValue];
    answerC.frame = [[frames objectAtIndex:2] CGRectValue];
    answerD.frame = [[frames objectAtIndex:3] CGRectValue];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    topLabel.font = [self getFont];
    bottomLabel.font = [self getFont];
    sign.font = [self getFont];
    answerA.font = [self getFont];
    answerB.font = [self getFont];
    answerC.font = [self getFont];
    answerD.font = [self getFont];
    correctAnswerCount = 0;
    wrongAttemptCount = 0;
    problemCount = 0;
    wrongAnswerSelected = NO;
    [self setNumbers];
    
}

- (UIFont *)getFont:(NSString *)fontName fontSize:(CGFloat)size {
    
    return [UIFont fontWithName:fontName size:size];
}

- (UIFont *)getFont {
    return [self getFont:@"Eraser" fontSize:48.0];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.topLabel = nil;
    self.bottomLabel = nil;
    self.sign = nil;
    self.answerA = nil;
    self.answerB = nil;
    self.answerC = nil;
    self.answerD = nil;

}

- (void)dealloc
{
    [super dealloc];
    [topLabel release];
    [bottomLabel release];
    [sign release];
    [answerA release];
    [answerB release];
    [answerC release];
    [answerD release];
}

-(void)highlightWrongAnswer:(UILabel *)answer {
    if (answer.highlighted != YES) {
        wrongAttemptCount++;
        answer.highlighted = YES;
        answer.highlightedTextColor = [UIColor redColor]; 
    }
}


#pragma mark -
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    gestureStartPoint = [touch locationInView:self.view];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view];
	
    CGFloat deltaX = fabsf(gestureStartPoint.x - currentPosition.x);
    CGFloat deltaY = fabsf(gestureStartPoint.y - currentPosition.y);
	
    if ((deltaX >= kMinimumGestureLength && deltaY <= kMaximumVariance) || 
        (deltaY >= kMinimumGestureLength &&
         deltaX <= kMaximumVariance) ){
            if ((CGRectContainsPoint([self.topLabel frame], [touch locationInView:self.view])) ||
                (CGRectContainsPoint([self.bottomLabel frame], [touch locationInView:self.view]))) {
                [self performSelector:@selector(setNumbers) withObject:nil afterDelay:0];
            }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (answerA.highlighted == NO) {
        UITouch *touch = [[event allTouches] anyObject];
        if (CGRectContainsPoint([self.answerA frame], [touch locationInView:self.view])) {
            //The score has been reset at this point;
            if (problemCount == 0) problemCount++;
            correctAnswerCount++;
            answerA.highlighted = YES;
            answerA.highlightedTextColor = [UIColor greenColor];
            answerB.hidden = YES;
            answerC.hidden = YES;
            answerD.hidden = YES;
            [self performSelector:@selector(setNumbers) withObject:nil afterDelay:1.0];
        }
        else {
            //The score has been reset at this point;
            if (problemCount == 0) problemCount++;
            
            BOOL selectedAnswerB = CGRectContainsPoint([self.answerB frame], [touch locationInView:self.view]);
            BOOL selectedAnswerC = CGRectContainsPoint([self.answerC frame], [touch locationInView:self.view]);
            BOOL selectedAnswerD = CGRectContainsPoint([self.answerD frame], [touch locationInView:self.view]);
            if (selectedAnswerB || selectedAnswerC || selectedAnswerD) {
                if (selectedAnswerB) {
                    [self highlightWrongAnswer:answerB];                
                }
                else if (selectedAnswerC) {
                    [self highlightWrongAnswer:answerC];
                }
                else if (selectedAnswerD) {
                    [self highlightWrongAnswer:answerD];
                }
            }
        }
    }
}
-(void)doneWithStats:(id)controller{
    if ([controller resetStatsPressed] == YES) {
        [self resetStats];
    }
    [self dismissModalViewControllerAnimated:YES];

}
@end
