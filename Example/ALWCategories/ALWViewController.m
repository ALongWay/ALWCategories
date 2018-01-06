//
//  ALWViewController.m
//  ALWCategories
//
//  Created by lisong on 05/08/2017.
//  Copyright (c) 2017 lisong. All rights reserved.
//

#import "ALWViewController.h"
#import "ALWCategories.h"

@interface ALWViewController ()

@end

@implementation ALWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [colorView setBackgroundColor:[UIColor greenColor]];
    UILabel *colorLabel = [[UILabel alloc] initWithFrame:colorView.bounds];
    [colorLabel setText:@"绿色"];
    [colorView addSubview:colorLabel];
    
    UIImage *image = [UIImage getSnapshotWithView:colorView];

    UIImageView *test1 = [[UIImageView alloc] initWithFrame:colorView.bounds];
    test1.top = 30;
    test1.centerX = self.view.width / 2.0;
    [test1 setLayerBorderColor:[UIColor redColor] borderWidth:2 cornerRadius:10];
    [test1 setBackgroundColor:[UIColor blackColor]];
    [test1 setImage:image];
    [self.view addSubview:test1];
    
    UIImageView *test2 = [[UIImageView alloc] initWithFrame:colorView.bounds];
    test2.top = test1.bottom + 10;
    test2.centerX = self.view.width / 2.0;
    [test2 setLayerBorderColor:[UIColor redColor] borderWidth:2 cornerRadius:10];
    [test2.layer setBackgroundColor:[UIColor blackColor].CGColor];
    [test2 setImage:image];
    [self.view addSubview:test2];

    
    image = [image clipImageWithRoundCornerRadius:10 corners:UIRectCornerTopLeft | UIRectCornerTopRight borderWidth:2 borderColor:[UIColor redColor]];
    
    UIImageView *test3 = [[UIImageView alloc] initWithFrame:colorView.bounds];
    test3.top = test2.bottom + 10;
    test3.centerX = self.view.width / 2.0;
    [test3 setLayerBorderColor:[UIColor redColor] borderWidth:1 cornerRadius:10];
    [test3 setBackgroundColor:[UIColor blackColor]];
    [test3 setImage:image];
    [self.view addSubview:test3];
    
    UIImageView *test4 = [[UIImageView alloc] initWithFrame:colorView.bounds];
    test4.top = test3.bottom + 10;
    test4.centerX = self.view.width / 2.0;
    [test4 setLayerBorderColor:[UIColor redColor] borderWidth:1 cornerRadius:10];
    [test4.layer setBackgroundColor:[UIColor blackColor].CGColor];
    [test4 setImage:image];
    [self.view addSubview:test4];
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 20, 20)];
    image = [image clipImageWithBezierPath:path];
    
    UIImageView *test5 = [[UIImageView alloc] initWithFrame:colorView.bounds];
    test5.top = test4.bottom + 10;
    test5.centerX = self.view.width / 2.0;
    [test5.layer setBackgroundColor:[UIColor blackColor].CGColor];
    [test5 setImage:image];
    [self.view addSubview:test5];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
