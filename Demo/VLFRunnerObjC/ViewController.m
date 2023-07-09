//
//  ViewController.m
//  VLFRunnerObjC
//
//  Created by Sidharth Juyal on 08/07/2023.
//

#import "ViewController.h"
#import "VFLContext.h"
#import "VFLExample.h"
#import "VFLUtils.h"
#import "VFLViewController.h"

static NSString *kCellId = @"cell-id";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
  VFLContext *_context;
}
@property (nonatomic, readonly) VFLContext *vflContext;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"VLF Demo";
  _context = [VFLContext context];
  
  [_context setParentView:self.view];
  UITableView *tableVw = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  [_context addSubviewsWithBindings:NSDictionaryOfVariableBindings(tableVw)];
  tableVw.dataSource = self;
  tableVw.delegate = self;
  [tableVw registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];
}

- (void)viewSafeAreaInsetsDidChange {
  [super viewSafeAreaInsetsDidChange];
  [_context removeAllConstraints];
  [_context addMetrics:vfl_CreateUIEdgeInsetsMetrics(self.view.safeAreaInsets)];
  [_context addConstraintsWithFormats:
   [NSArray arrayWithObjects:
    @"H:|-(left)-[tableVw]-(right)-|",
    @"V:|-(top)-[tableVw]-(bottom)-|",
    nil]];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return VFLExampleTotal;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
  cell.textLabel.text = VFLExampleGetName(indexPath.row);
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  VFLViewController *vwCtrl = [VFLViewController viewControllerWithExample:indexPath.row];
  [self.navigationController pushViewController:vwCtrl animated:YES];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
