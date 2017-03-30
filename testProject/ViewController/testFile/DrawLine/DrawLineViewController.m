//
//  DrawLineViewController.m
//  testProject
//
//  Created by mac3 on 17/3/28.
//  Copyright © 2017年 test. All rights reserved.
//

#import "DrawLineViewController.h"
#import "ZFChart.h"

@interface DrawLineViewController ()<ZFGenericChartDataSource, ZFWaveChartDelegate>

@property (nonatomic, strong) ZFWaveChart * waveChart;

@end

@implementation DrawLineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawNavWithTitle:@"测试波浪图形"];
    [self drawBackButton];
    
    //[self initUI];
    
}


#pragma - mark - 实现波浪图

-(void)initUI
{
    self.waveChart = [[ZFWaveChart alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, KScreenHeight - 64)];
    self.waveChart.dataSource = self;
    self.waveChart.delegate = self;
    self.waveChart.topicLabel.text = @"min";
    self.waveChart.unit = @"m";
    
    //    self.waveChart.isShowYLineSeparate = YES;
    //    self.waveChart.pathColor = ZFGrassGreen;
    
    self.waveChart.pathLineColor = ZFLightGray;
    self.waveChart.topicLabel.textColor = ZFPurple;
    
    self.waveChart.isResetAxisLineMaxValue = YES;
    
    //    self.waveChart.isAnimated = NO;
    //    self.waveChart.isResetAxisLineMinValue = YES;
    //    self.waveChart.isShowAxisLineValue = NO;
    //    self.waveChart.isShadowForValueLabel = NO;
    //    self.waveChart.valuePosition = kChartValuePositionOnBelow;
    //    self.waveChart.valueLabelPattern = kPopoverLabelPatternBlank;
    //    self.waveChart.wavePatternType = kWavePatternTypeForSharp;
    //    self.waveChart.valueLabelToWaveLinePadding = 20.f;
    
    [self.waveChart strokePath];
    [self.view addSubview:self.waveChart];

}


#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@"123", @"256", @"300", @"283", @"490", @"236", @"401", @"356", @"270", @"369", @"463", @"399"];
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@"5min", @"10min",@"15min",@"20min",@"25min",@"30min"];
}

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
    return 500;
}

//- (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart{
//    return 100;
//}

- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
    
    return 10;
}

#pragma mark - ZFWaveChartDelegate

//- (CGFloat)groupWidthInWaveChart:(ZFWaveChart *)waveChart{
//    return 50.f;
//}

//- (CGFloat)paddingForGroupsInWaveChart:(ZFWaveChart *)waveChart{
//    return 20.f;
//}

- (ZFGradientAttribute *)gradientColorInWaveChart:(ZFWaveChart *)waveChart{
    ZFGradientAttribute * gradientAttribute = [[ZFGradientAttribute alloc] init];
    gradientAttribute.colors = @[(id)ZFGold.CGColor, (id)ZFWhite.CGColor];
    gradientAttribute.locations = @[@(0.0), @(0.9)];
    
    return gradientAttribute;
}

- (void)waveChart:(ZFWaveChart *)waveChart popoverLabelAtIndex:(NSInteger)index popoverLabel:(ZFPopoverLabel *)popoverLabel{
    NSLog(@"第%ld个Label",(long)index);
    
    //可在此处进行popoverLabel被点击后的自身部分属性设置
    //    popoverLabel.textColor = ZFGold;
    //    [popoverLabel strokePath];
}


@end
