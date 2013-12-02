//
//  DFMovieLoadingViewController.m
//  DFMovieLoading
//
//  Created by Kiss Tamas on 2013.12.02..
//  Copyright (c) 2013 defko. All rights reserved.
//

#import "DFMovieLoadingViewController.h"
#import "DFProgressIndicator.h"

@interface DFMovieLoadingViewController ()

@end

@implementation DFMovieLoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_movieLoadinIndicator startAnimating];
}

- (IBAction)start:(UIButton*)sender {
    if (_movieLoadinIndicator.isAnimating) {
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        [_movieLoadinIndicator stopAnimating];
    } else {
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        [_movieLoadinIndicator startAnimating];
    }
}
@end
