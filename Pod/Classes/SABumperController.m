//
//  SABumperController.m
//  Pods
//
//  Created by Gabriel Coman on 07/08/2017.
//
//

#import "SABumperController.h"
#import "SABumperImageUtils.h"

//
// constants for this
#define BIG_LABEL_TXT @"You're now leaving:\n%@"
#define BIG_LABEL_TXT_NO_APP @"You're now leaving this app"
#define SMALL_LABEL_TXT @"A new site (which we don't own) will open in %ld seconds. Remember to stay safe online and ask an adult before buying anything!"
#define MAX_COUNTER 3

static sabumpercallback callback = ^(){};

@interface SABumperController ()

//
// views
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UILabel *bigLabel;
@property (nonatomic, strong) UILabel *smallLabel;

//
// parameters
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) UIImage *appLogo;

//
// the timer
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger counter;

@end

@implementation SABumperController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setTimerVars];
    [self createBackground];
    [self createSupportPanel];
    [self createLogo];
    [self createSmallLabel];
    [self createBigLabel];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self creatTimer];
}

- (void) setTimerVars {
    _counter = MAX_COUNTER;
}

- (void) creatTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFunction) userInfo:nil repeats:YES];
}

- (void) createBackground {
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}

- (void) createSupportPanel {
    
    CGSize screen = [UIScreen mainScreen].bounds.size;
    CGFloat padding = 20;
    CGFloat size = MIN(screen.width, screen.height) - 2 * padding;
    
    _bgView = [[UIImageView alloc] init];
    [_bgView setImage:[SABumperImageUtils backgroundImage]];
    [_bgView setContentMode:UIViewContentModeScaleAspectFill];
    _bgView.clipsToBounds = true;
    _bgView.layer.masksToBounds = false;
    _bgView.layer.shadowRadius = 5;
    _bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    _bgView.layer.shadowOpacity = 0.25;
    _bgView.layer.cornerRadius = 5;
    _bgView.layer.shadowOffset = CGSizeMake(0, 0);
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:_bgView];
    
    NSLayoutConstraint *wc = [NSLayoutConstraint constraintWithItem:_bgView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:size];
    NSLayoutConstraint *hc = [NSLayoutConstraint constraintWithItem:_bgView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:size];
    NSLayoutConstraint *xc = [NSLayoutConstraint constraintWithItem:_bgView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0];
    NSLayoutConstraint *yc = [NSLayoutConstraint constraintWithItem:_bgView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0];
    [NSLayoutConstraint activateConstraints:@[wc, hc, xc, yc]];
}

- (void) createLogo {
    
    CGSize screen = [UIScreen mainScreen].bounds.size;
    CGFloat padding = 20;
    CGFloat width = MIN(screen.width, screen.height) - 2 * padding;
    CGFloat height = 50;
    
    _logo = [[UIImageView alloc] init];
    
    if (_appLogo != NULL) {
        [_logo setImage:_appLogo];
    } else {
        [_logo setImage:[SABumperImageUtils defaultLogo]];
    }
    [_logo setContentMode:UIViewContentModeScaleAspectFit];
    _logo.translatesAutoresizingMaskIntoConstraints = false;
    [_bgView addSubview:_logo];
    
    NSLayoutConstraint *wc = [NSLayoutConstraint constraintWithItem:_logo
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:width];
    NSLayoutConstraint *hc = [NSLayoutConstraint constraintWithItem:_logo
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:height];
    NSLayoutConstraint *xc = [NSLayoutConstraint constraintWithItem:_logo
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_bgView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0];
    NSLayoutConstraint *yc = [NSLayoutConstraint constraintWithItem:_logo
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_bgView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0];
    [NSLayoutConstraint activateConstraints:@[wc, hc, xc, yc]];
}

- (void) createSmallLabel {
    
    _smallLabel = [[UILabel alloc] init];
    _smallLabel.text = [NSString stringWithFormat:SMALL_LABEL_TXT, (long)_counter];
    _smallLabel.textColor = [UIColor whiteColor];
    _smallLabel.font = [UIFont systemFontOfSize:14];
    _smallLabel.textAlignment = NSTextAlignmentCenter;
    _smallLabel.translatesAutoresizingMaskIntoConstraints = false;
    _smallLabel.numberOfLines = 0;
    [_bgView addSubview:_smallLabel];
    
    NSLayoutConstraint *lc = [NSLayoutConstraint constraintWithItem:_smallLabel
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_bgView
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:12.0];
    NSLayoutConstraint *rc = [NSLayoutConstraint constraintWithItem:_smallLabel
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_bgView
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:-12.0];
    NSLayoutConstraint *bc = [NSLayoutConstraint constraintWithItem:_smallLabel
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_bgView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-16.0];
    [NSLayoutConstraint activateConstraints:@[lc, rc, bc]];
    
}

- (void) createBigLabel {
    
    _bigLabel = [[UILabel alloc] init];
    _bigLabel.textColor = [UIColor whiteColor];
    _bigLabel.font = [UIFont systemFontOfSize:18 weight:6];
    _bigLabel.textAlignment = NSTextAlignmentCenter;
    _bigLabel.translatesAutoresizingMaskIntoConstraints = false;
    _bigLabel.numberOfLines = 0;
    [_bgView addSubview:_bigLabel];
    
    NSString *localAppName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    //
    // set proper app name
    if (_appName != NULL) {
        _bigLabel.text = [NSString stringWithFormat:BIG_LABEL_TXT, _appName];
    }
    else if (localAppName != NULL) {
        _bigLabel.text = [NSString stringWithFormat:BIG_LABEL_TXT, localAppName];
    } else {
        _bigLabel.text = BIG_LABEL_TXT_NO_APP;
    }
    
    
    NSLayoutConstraint *lc = [NSLayoutConstraint constraintWithItem:_bigLabel
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_bgView
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:12.0];
    NSLayoutConstraint *rc = [NSLayoutConstraint constraintWithItem:_bigLabel
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_bgView
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:-12.0];
    NSLayoutConstraint *bc = [NSLayoutConstraint constraintWithItem:_bigLabel
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_smallLabel
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:-5.0];
    [NSLayoutConstraint activateConstraints:@[lc, rc, bc]];
}

- (void) timerFunction {
    
    if (_counter > 0) {
        
        //
        // decrement counter
        _counter--;
        
        //
        // update small label
        _smallLabel.text = [NSString stringWithFormat:SMALL_LABEL_TXT, (long)_counter];
        
    } else {
        //
        // invalidate timer
        [_timer invalidate];
        _timer = nil;
        
        //
        // dismiss view controller
        [self dismissViewControllerAnimated:YES completion:^{
            callback();
        }];
    }
}

+ (SABumperController*) getNewVC {
    SABumperController *newVC = [[SABumperController alloc] init];
    newVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    return newVC;
}

+ (void) playFromVC:(UIViewController*) parent {
    
    SABumperController *newVC = [SABumperController getNewVC];
    [parent presentViewController:newVC animated:true completion:nil];
}

+ (void) playFromVC:(UIViewController*) parent
 andOverrideAppName:(NSString*) name
 andOverrideAppLogo:(UIImage*) image {
    
    SABumperController *newVC = [SABumperController getNewVC];
    newVC.appName = name;
    newVC.appLogo = image;
    [parent presentViewController:newVC animated:true completion:nil];
}

+ (void) setCallback:(sabumpercallback)cb {
    callback = cb;
}

@end
