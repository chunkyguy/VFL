//
//  VFLExampleView.h
//  VLFRunnerObjC
//
//  Created by Sidharth Juyal on 09/07/2023.
//

#import <UIKit/UIKit.h>
#import "VFLExample.h"

NS_ASSUME_NONNULL_BEGIN

@interface VFLExampleView : UIView
- (instancetype)initWithExample:(VFLExample)example;
- (void)setUp;
@end

NS_ASSUME_NONNULL_END
