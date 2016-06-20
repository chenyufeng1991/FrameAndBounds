//
//  ViewController.m
//  FrameAndBounds
//
//  Created by chenyufeng on 6/20/16.
//  Copyright © 2016 chenyufengweb. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

/**
 *  (1)bounds的x,y不一定为0，其实默认是(0,0),除非调用了setBounds方法；
    (2)frame的size不一定等于bounds的size，可以把一个view旋转后比较；
    (3)frame的x，y是随意的，是相对于父视图的坐标位置；
    (4)Frame is in terms of superview's coordinate system;
       Bounds is in terms of local coordinate system;
    (5)bounds是修改自己坐标系的原点位置，进而影响到子view的显示位置。
    (6)setBounds也可以修改view的大小，进而修改frame。
    (7)setBounds可以修改子view的位置。setFrame可以主动修改自己在父view中的位置。
    (8)更改bounds的大小，bounds的大小代表当前视图的长和宽，修改长宽后，中心点继续保持不变，长宽进行改变，通过bounds修改长宽就像是以中心点为基准点对长宽两边同时进行缩放。
 */
@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"self.view.frame = %@",NSStringFromCGRect(self.view.frame));
    NSLog(@"self.view.bounds = %@",NSStringFromCGRect(self.view.bounds));

#if 0
    UIView *view01 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    view01.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view01];
    NSLog(@"view01.frame = %@",NSStringFromCGRect(view01.frame));
    NSLog(@"view01.bounds = %@",NSStringFromCGRect(view01.bounds));

    [UIView transitionWithView:view01 duration:0.3 options:0 animations:^{
        view01.transform = CGAffineTransformMakeRotation(M_PI_4);
    } completion:^(BOOL finished) {
        if (finished)
        {
            NSLog(@"view01.frame = %@",NSStringFromCGRect(view01.frame));
            NSLog(@"view01.bounds = %@",NSStringFromCGRect(view01.bounds));
        }
    }];

    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        NSLog(@"view01.frame = %@",NSStringFromCGRect(view01.frame));
    //        NSLog(@"view01.bounds = %@",NSStringFromCGRect(view01.bounds));
    //    });
#endif


#if 0
    UIView *view02 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    view02.backgroundColor = [UIColor colorWithWhite:0.851 alpha:1.000];
    [self.view addSubview:view02];

    UIView *view02_sub = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    view02_sub.backgroundColor = [UIColor colorWithRed:1.000 green:0.908 blue:0.552 alpha:1.000];
    [view02 addSubview:view02_sub];


    [UIView animateWithDuration:1 animations:^{
        // setBounds 强制将自己坐标系的左上角点改为（-30，-30）。那么真正的原点(0,0)自然向右下角偏移(30,30);
        // 注意：setBounds中的(x,y)只改变自己的坐标系统。子view的bounds和frame并不会改变。
        [view02 setBounds:CGRectMake(-30, -30, 200, 200)];
    } completion:^(BOOL finished) {
        NSLog(@"view02.frame = %@",NSStringFromCGRect(view02.frame));
        NSLog(@"view02.bounds = %@",NSStringFromCGRect(view02.bounds));
        NSLog(@"view02_sub.frame = %@",NSStringFromCGRect(view02_sub.frame));
        NSLog(@"view02_sub.bounds = %@",NSStringFromCGRect(view02_sub.bounds));
    }];
#endif


#if 0
    // 父类的frame改变，内部子view的frame和bounds不会改变
    [view02 setFrame:CGRectMake(0, 250, 150, 150)];
    NSLog(@"view02_sub.frame = %@",NSStringFromCGRect(view02_sub.frame));
    NSLog(@"view02_sub.bounds = %@",NSStringFromCGRect(view02_sub.bounds));
#endif


    UIView *view02 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view02.backgroundColor = [UIColor colorWithWhite:0.851 alpha:1.000];
    [self.view addSubview:view02];

    UIView *view02_sub = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    view02_sub.backgroundColor = [UIColor colorWithRed:1.000 green:0.908 blue:0.552 alpha:1.000];
    [view02 addSubview:view02_sub];

    [UIView animateWithDuration:1 animations:^{
        [view02 setBounds:CGRectMake(-100, -100, 50, 50)];
    } completion:^(BOOL finished) {
        NSLog(@"view02.frame = %@",NSStringFromCGRect(view02.frame));
        NSLog(@"view02.bounds = %@",NSStringFromCGRect(view02.bounds));
        NSLog(@"view02_sub.frame = %@",NSStringFromCGRect(view02_sub.frame));
        NSLog(@"view02_sub.bounds = %@",NSStringFromCGRect(view02_sub.bounds));
    }];









}


@end
