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
    (9)frame不管对于位置还是大小，改变的都是自己本身。
    (10)frame的位置是以父视图的坐标系为参照，从而确定当前视图在父视图中的位置。
    (11)frame的大小改变时，当前视图的左上角位置不会发生改变，只是大小发生改变。
    ------
    (12)bounds改变位置时，改变的是子视图的位置，自身没有影响。其实就是改变了本身的坐标系原点。，默认本身坐标系原点是左上角。
    (13)bounds的大小改变时，当前视图的中心点不会发生改变，当前视图的大小发生改变，效果就像是缩放一样。
    (14)更改bounds的位置对于当前视图没有影响，相当于更改了当前视图的坐标系，对于子视图来说当前视图的左上角已经不是(0,0)，而是改变后的坐标，坐标系改了，那么所有子视图的位置也会跟着改变。
    (15)center是根据父容器的相对位置来计算的。无论是修改父容器的bounds或者自身的bounds，都不会改变center。况且使用bounds来缩放View，都是根据center中心点来缩放的，所以center不会改变。
    (16)使用frame改变view大小，center改变，因为缩放参考点为左上角。使用bounds改变view大小，center不变，因为缩放参考点为center。
    (17)个人总结：想修改view的位置而不影响其他，修改自身frame的位置；想修改view的大小，修改frame的大小或者bounds的大小（考虑相对位置的改变）。
                想修改viewA的所有子view的位置，修改viewA的bounds的位置（该父容器的坐标）。
 */
@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

#if 0
    NSLog(@"self.view.frame = %@",NSStringFromCGRect(self.view.frame));
    NSLog(@"self.view.bounds = %@",NSStringFromCGRect(self.view.bounds));
#endif

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

#if 0
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
#endif

    //---------实例
    UIView *viewFather = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    viewFather.backgroundColor = [UIColor colorWithWhite:0.741 alpha:1.000];
    [self.view addSubview:viewFather];

    UIView *viewSub = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 50, 80)];
    viewSub.backgroundColor = [UIColor colorWithRed:1.000 green:0.999 blue:0.721 alpha:1.000];
    [viewFather addSubview:viewSub];

#if 0
    // (1)修改父视图的bounds的位置
    [self printFrameAndBounds:viewFather viewOfSub:viewSub];
    [UIView animateWithDuration:3 animations:^{
        [viewFather setBounds:CGRectMake(30, 30, 200, 200)];
    } completion:^(BOOL finished) {
        [self printFrameAndBounds:viewFather viewOfSub:viewSub];
    }];
#endif

#if 0
    // (2)修改父视图的bounds的大小
    [self printFrameAndBounds:viewFather viewOfSub:viewSub];
    [UIView animateWithDuration:3 animations:^{
        [viewFather setBounds:CGRectMake(0, 0, 250, 250)];
    } completion:^(BOOL finished) {
        [self printFrameAndBounds:viewFather viewOfSub:viewSub];
    }];
#endif

#if 0
    // (3)修改子视图的bounds的位置
    [self printFrameAndBounds:viewFather viewOfSub:viewSub];
    [UIView animateWithDuration:3 animations:^{
        [viewSub setBounds:CGRectMake(50, 50, 50, 80)];
    } completion:^(BOOL finished) {
        [self printFrameAndBounds:viewFather viewOfSub:viewSub];
    }];
#endif

#if 0
    // (4)修改子视图的bounds的大小
    [self printFrameAndBounds:viewFather viewOfSub:viewSub];
    [UIView animateWithDuration:3 animations:^{
        [viewSub setBounds:CGRectMake(0, 0, 80, 110)];
    } completion:^(BOOL finished) {
        [self printFrameAndBounds:viewFather viewOfSub:viewSub];
    }];
#endif

#if 0
    // (5)修改父视图的frame的位置。父容器的center改变,子视图的center不变。
    [self printFrameAndBounds:viewFather viewOfSub:viewSub];
    [UIView animateWithDuration:3 animations:^{
        [viewFather setFrame:CGRectMake(20, 20, 200, 200)];
    } completion:^(BOOL finished) {
        [self printFrameAndBounds:viewFather viewOfSub:viewSub];
    }];
#endif

#if 0
    // (6)修改父视图的frame的大小。父容器的center改变，子视图的center不变。
    [self printFrameAndBounds:viewFather viewOfSub:viewSub];
    [UIView animateWithDuration:3 animations:^{
        [viewFather setFrame:CGRectMake(50, 50, 250, 250)];
    } completion:^(BOOL finished) {
        [self printFrameAndBounds:viewFather viewOfSub:viewSub];
    }];
#endif


}

- (void)printFrameAndBounds:(UIView *)viewOfFather viewOfSub:(UIView *)viewOfSub
{
    NSLog(@"viewOfFather.frame = %@;viewOfFather.bounds = %@;viewOfFather.center = %@",NSStringFromCGRect(viewOfFather.frame),NSStringFromCGRect(viewOfFather.bounds),NSStringFromCGPoint(viewOfFather.center));
    NSLog(@"viewOfSub.frame = %@;viewOfSub.bounds = %@;viewOfSub.center = %@",NSStringFromCGRect(viewOfSub.frame),NSStringFromCGRect(viewOfSub.bounds),NSStringFromCGPoint(viewOfSub.center));
}


@end

