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

#import "Digits.h"

@implementation Digits
@synthesize top;
@synthesize bottom;
- (void) reset {
    top = (random() % 10);
    bottom = (random() % 10);
    if (topHigher == YES) {
        if (top < bottom) {
            int temp = top;
            top = bottom;
            bottom = temp;
        }
    }
}
- (id) init {
    if (self == [super init]) {
        srandom(time(NULL));
        top = 0;
        bottom = 0;
        topHigher = NO;
        [self reset];
    }
    return self;
}
- (id) initWithTopHigher {
    if (self == [super init]) {
        srandom(time(NULL));
        top = 0;
        bottom = 0;
        topHigher = YES;
        [self reset];
    }
    return self;
}

@end
