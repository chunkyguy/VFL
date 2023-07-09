//
//  VFLViewController.m
//  VLFRunnerObjC
//
//  Created by Sidharth Juyal on 09/07/2023.
//

#import "VFLViewController.h"
#import "VFLContext.h"
#import "VFLUtils.h"
#import "VFLExampleView.h"

@interface VFLViewController () {
  VFLExample _example;
  VFLContext *_context;
}
@end

@implementation VFLViewController

+ (instancetype)viewControllerWithExample:(VFLExample)example
{
  return [[VFLViewController alloc] initWithExample:example];
}

- (instancetype)initWithExample:(VFLExample)example
{
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    _example = example;
    _context = [VFLContext context];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = VFLExampleGetName(_example);
  NSString *classname = VFLExampleGetClassname(_example);
  VFLExampleView *contentView = (VFLExampleView *)[[NSClassFromString(classname) alloc] initWithExample:_example];
  [_context setParentView:self.view];
  [_context addSubviewsWithBindings:NSDictionaryOfVariableBindings(contentView)];
  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewSafeAreaInsetsDidChange
{
  [super viewSafeAreaInsetsDidChange];
  [_context removeAllConstraints];
  [_context addMetrics:vfl_CreateUIEdgeInsetsMetrics(self.view.safeAreaInsets)];
  [_context addConstraintsWithFormats:
   [NSArray arrayWithObjects:
    @"V:|-(top)-[contentView]-(bottom)-|",
    @"H:|-(left)-[contentView]-(right)-|",
    nil]];
}

@end
