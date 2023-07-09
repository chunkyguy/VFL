//
//  VFLExampleView.m
//  VLFRunnerObjC
//
//  Created by Sidharth Juyal on 09/07/2023.
//

#import "VFLExampleView.h"
#import "VFLExample.h"
#import "VFLContext.h"
#import "VFLUtils.h"

@interface VFLExampleView () {
  VFLExample _example;
}
@end

@implementation VFLExampleView

- (instancetype)initWithExample:(VFLExample)example
{
  self = [super initWithFrame:CGRectZero];
  if (self) {
    _example = example;
    [self setUp];
  }
  return self;
}

- (void)setUp {}

@end

@interface VFLColorView : UIView
+ (instancetype)view;
@end
@implementation VFLColorView
+ (instancetype)view {
  return [[VFLColorView alloc] initWithColor:vfl_CreateRandomColor()];
}
- (instancetype)initWithColor:(UIColor *)color
{
  self = [super initWithFrame:CGRectZero];
  if (self) {
    self.backgroundColor = color;
  }
  return self;
}
@end

@interface VFLExampleFullView: VFLExampleView
@end
@implementation VFLExampleFullView
- (void)setUp
{
  [super setUp];
  VFLContext *context = [VFLContext contextWithView:self];
  VFLColorView *view = [VFLColorView view];
  [context addSubviewsWithBindings:NSDictionaryOfVariableBindings(view)];
  [context addConstraintsWithFormats:
     [NSArray arrayWithObjects:
      @"V:|[view]|", @"H:|[view]|",
      nil]
  ];
}
@end

@interface VFLExampleHSplitView: VFLExampleView
@end
@implementation VFLExampleHSplitView
- (void)setUp
{
  [super setUp];
  VFLContext *context = [VFLContext contextWithView:self];
  VFLColorView *leftView = [VFLColorView view];
  VFLColorView *rightView = [VFLColorView view];
  [context addSubviewsWithBindings:NSDictionaryOfVariableBindings(leftView, rightView)];
  [context addConstraintsWithFormats:
     [NSArray arrayWithObjects:
      @"V:|[leftView]|", @"V:|[rightView]|",
      @"H:|[leftView(==rightView)][rightView]|",
      nil]
  ];
}
@end

@interface VFLExampleVSplitView: VFLExampleView
@end
@implementation VFLExampleVSplitView
- (void)setUp
{
  [super setUp];
  VFLContext *context = [VFLContext contextWithView:self];
  VFLColorView *topView = [VFLColorView view];
  VFLColorView *bottomView = [VFLColorView view];
  [context addSubviewsWithBindings:NSDictionaryOfVariableBindings(topView, bottomView)];
  [context addConstraintsWithFormats:
     [NSArray arrayWithObjects:
      @"H:|[topView]|", @"H:|[bottomView]|",
      @"V:|[topView(==bottomView)][bottomView]|",
      nil]
  ];
}
@end

@interface VFLExampleFixedView: VFLExampleView
@end
@implementation VFLExampleFixedView
- (void)setUp
{
  [super setUp];
  VFLContext *context = [VFLContext contextWithView:self];
  VFLColorView *view = [VFLColorView view];
  [context addSubviewsWithBindings:NSDictionaryOfVariableBindings(view)];
  [context addConstraintsWithFormats:
     [NSArray arrayWithObjects:
      @"V:|-[view(100)]",
      @"H:|-[view(100)]",
      nil]
  ];
}
@end

@interface VFLExampleCenterView: VFLExampleView
@end
@implementation VFLExampleCenterView
- (void)setUp
{
  [super setUp];
  VFLContext *context = [VFLContext contextWithView:self];
  VFLColorView *view = [VFLColorView view];
  [context addSubviewsWithBindings:NSDictionaryOfVariableBindings(view)];
  [context addConstraintsWithFormats:
     [NSArray arrayWithObjects:
      @"H:[view(100)]",
      @"V:[view(100)]",
      nil]
  ];
  [context addConstraints:
     [NSArray arrayWithObjects:
      [NSLayoutConstraint constraintWithItem:view
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeCenterX
                                  multiplier:1
                                    constant:0],
      [NSLayoutConstraint constraintWithItem:view
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeCenterY
                                  multiplier:1
                                    constant:0],
      nil]
  ];
}
@end

@interface VFLExampleComplexView: VFLExampleView {
  VFLContext *_context;
}
@end
@implementation VFLExampleComplexView
- (void)setUp
{
  [super setUp];
  UIImage *square = [UIImage imageNamed:@"square"];
  UIImageView *headerVw = [[UIImageView alloc] initWithImage:square];
  VFLColorView *borderVw = [VFLColorView view];
  UIImageView *firstThumbVw = [[UIImageView alloc] initWithImage:square];
  UIImageView *secondThumbVw = [[UIImageView alloc] initWithImage:square];

  _context = [VFLContext contextWithView:self];
  [_context addSubviewsWithBindings:NSDictionaryOfVariableBindings(headerVw, borderVw, firstThumbVw, secondThumbVw)];
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  if (CGRectGetWidth(self.bounds) < CGRectGetHeight(self.bounds)) {
    [self layoutSubviewPortrait];
  } else {
    [self layoutSubviewLandscape];
  }
}

- (void)layoutSubviewPortrait
{
  [_context removeAllConstraints];
  [_context removeAllMetrics];
  [_context addMetrics:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [NSNumber numberWithDouble:CGRectGetWidth(self.bounds)], @"w",
      [NSNumber numberWithDouble:CGRectGetWidth(self.bounds) * 0.5], @"hw",
      nil]
  ];
  [_context addConstraintsWithFormats:
     [NSArray arrayWithObjects:
      @"H:|[headerVw]|",
      @"H:|[borderVw]|",
      @"H:|-[firstThumbVw(==secondThumbVw)]-[secondThumbVw]-|",
      @"V:|[headerVw(w)][borderVw(40)]",
      @"V:[firstThumbVw(hw)]|", @"V:[secondThumbVw(hw)]|",
      nil]
  ];
}

- (void)layoutSubviewLandscape
{
  [_context removeAllConstraints];
  [_context removeAllMetrics];
  [_context addMetrics:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [NSNumber numberWithDouble:CGRectGetHeight(self.bounds)], @"w",
      [NSNumber numberWithDouble:CGRectGetHeight(self.bounds) * 0.5], @"hw",
      nil]
  ];
  [_context addConstraintsWithFormats:
     [NSArray arrayWithObjects:
      @"H:|[headerVw(w)][borderVw(40)]",
      @"H:[firstThumbVw(hw)]|", @"H:[secondThumbVw(hw)]|",
      @"V:|[headerVw]|",
      @"V:|[borderVw]|",
      @"V:|-[firstThumbVw(==secondThumbVw)]-[secondThumbVw]-|",
      nil]
  ];

}
@end
