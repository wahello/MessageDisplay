//
//  DetailViewController.m
//  MessageDisplay
//
//  Created by Jack on 15/3/23.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "DetailViewController.h"
#import "DemoMessageTableViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}
- (IBAction)nextPage:(id)sender {
    DemoMessageTableViewController *vc =[[DemoMessageTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
