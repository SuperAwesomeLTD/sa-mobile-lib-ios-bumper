//
//  SAViewController.m
//  SABumperPage
//
//  Created by devgabrielcoman on 08/07/2017.
//  Copyright (c) 2017 devgabrielcoman. All rights reserved.
//

#import "SAViewController.h"
#import "SABumperPage.h"

@interface SAViewController ()

@end

@implementation SAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *base65 = [self encodeToBase64String:[UIImage imageNamed:@"bg2"]];
    NSLog(@"%@", base65);
    NSMutableArray *arr = [[base65 componentsSeparatedByString:@"\n"] mutableCopy];
    for (int i = 0; i < [arr count]; i++) {
        NSString *purrItem = [arr objectAtIndex:i];
        NSString *novo = [purrItem stringByReplacingOccurrencesOfString:@"" withString:@""];
        NSString *newItem = [NSString stringWithFormat:@"[imageString appendString:@\"%@\"];", novo];
        [arr replaceObjectAtIndex:i withObject:newItem];
    }
    NSString *final = [arr componentsJoinedByString:@""];
    NSLog(@"%@", final);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)launchBumper:(id)sender {
    [SABumperPage setCallback:^{
//        NSLog(@"Ended, going to URL now");
    }];
    [SABumperPage overrideLogo:[UIImage imageNamed:@"kws_700"]];
    [SABumperPage overrideName:@"My App"];
    [SABumperPage play];
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end
