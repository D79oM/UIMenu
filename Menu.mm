#import <Foundation/Foundation.h>
#import "SwitchesTemplate.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@implementation Menu {
    CGPoint lastMenuLocation;
    UILabel *menuTitle;
    UIView *header;
    UIView *footer;
 UIButton *close;
 UIButton *swi;
UIWindow *main; 
UISwitch *swi1;
UISwitch *swi2;
}


NSUserDefaults *defaults;

UIScrollView *scrollView;
CGFloat menuWidth;
CGFloat scrollViewX;
NSString *credits;
UIColor *switchOnColor;
NSString *switchTitleFont;
UIColor *switchTitleColor;
UIColor *infoButtonColor;
NSString *menuIconBase64;
NSString *menuButtonBase64;

NSString *on = @"✅";
NSString *off = @"❌";

UIWindow *mainWindow;

UIView *selfView;


float scrollViewHeight = 0;

-(id)initWithTitle:(NSString *)title_ titleColor:(UIColor *)titleColor_ titleFont:(NSString *)titleFont_ credits:(NSString *)credits_ headerColor:(UIColor *)headerColor_ switchOffColor:(UIColor *)switchOffColor_ switchOnColor:(UIColor *)switchOnColor_ switchTitleFont:(NSString *)switchTitleFont_ switchTitleColor:(UIColor *)switchTitleColor_ infoButtonColor:(UIColor *)infoButtonColor_ maxVisibleSwitches:(int)maxVisibleSwitches_ menuWidth:(CGFloat )menuWidth_ menuIcon:(NSString *)menuIconBase64_ menuButton:(NSString *)menuButtonBase64_ {
    
    mainWindow = [UIApplication sharedApplication].keyWindow;
    selfView = self;
    
    menuWidth = menuWidth_;
    switchOnColor = switchOnColor_;
    
    credits = credits_;
    switchTitleFont = switchTitleFont_;
    switchTitleColor = switchTitleColor_;
    infoButtonColor = infoButtonColor_;

    menuButtonBase64 = menuButtonBase64_;
    
    defaults = [NSUserDefaults standardUserDefaults];
    

    self = [super initWithFrame:CGRectMake(0,0,menuWidth_, maxVisibleSwitches_ * 50 + 50)];
    self.center = mainWindow.center;
    self.layer.opacity = 0.0f;

self.layer.shadowOpacity = 5;
self.layer.shadowColor = [UIColor whiteColor].CGColor;
self.layer.shadowRadius = 10;

    

    header = [[UIView alloc]initWithFrame:CGRectMake(0, 1, menuWidth_, 44)];
    header.backgroundColor = headerColor_;
    CAShapeLayer *headerLayer = [CAShapeLayer layer];
    headerLayer.path = [UIBezierPath bezierPathWithRoundedRect: header.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){1.0, 1.0}].CGPath;
    header.layer.mask = headerLayer;
    [self addSubview:header];
    
         

    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, header.self.bounds.size.height, menuWidth_, self.bounds.size.height - header.self.bounds.size.height)];
    scrollView.backgroundColor = switchOffColor_;
    [self addSubview:scrollView];
    

    scrollViewX = scrollView.self.bounds.origin.x;
    

    menuTitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 3, menuWidth_ - 60, 50)];
    menuTitle.text = title_;
    menuTitle.textColor = titleColor_;
    menuTitle.font = [UIFont fontWithName:titleFont_ size:35.0f];
    menuTitle.adjustsFontSizeToFitWidth = true;
    menuTitle.textAlignment = NSTextAlignmentCenter;
    [header addSubview: menuTitle];



 close = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    close.frame = CGRectMake(8, 11, 25, 22);
    close.backgroundColor = [UIColor clearColor];

    [close setTitle:@"❌" forState:UIControlStateNormal];
    [close setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

[close addTarget:self action:@selector(hideMenu:) forControlEvents:UIControlEventTouchUpInside];

close.layer.cornerRadius = 10;   

    [header addSubview:close];

 swi = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    swi.frame = CGRectMake(50, 11, 25, 22);
    swi.backgroundColor = [UIColor clearColor];

    [swi setTitle:on
forState:UIControlStateNormal];
    [close setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

[swi addTarget:self action:@selector(swiOn) forControlEvents:UIControlEventTouchUpInside];

swi.layer.cornerRadius = 10;   

    [header addSubview:swi];

main = [UIApplication sharedApplication].keyWindow;

swi1 = [[UISwitch alloc]init];
[swi1 addTarget:self                action:@selector(swi1:)                forControlEvents:UIControlEventValueChanged];
[main addSubview:swi1];
swi2 = [[UISwitch alloc]init];
[swi2 addTarget:self                action:@selector(swi2:)                forControlEvents:UIControlEventValueChanged];
[main addSubview:swi2];


swi1.frame = CGRectMake(99999999999999, 99999999999999, 99999999999999, 99999999999999); 
swi2.frame = CGRectMake(99999999999999, 99999999999999, 99999999999999, 99999999999999);


    UIPanGestureRecognizer *dragMenuRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(menuDragged:)];
    [header addGestureRecognizer:dragMenuRecognizer];
    

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMenu:)];
  
    [close addGestureRecognizer:tapGestureRecognizer];




    footer = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 1, menuWidth_, 24)];
    footer.backgroundColor = headerColor_;
    CAShapeLayer *footerLayer = [CAShapeLayer layer];
    footerLayer.path = [UIBezierPath bezierPathWithRoundedRect: footer.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){1.0, 1.0}].CGPath;
    footer.layer.mask = footerLayer;
    [self addSubview:footer];
    



    
    [mainWindow addSubview:self];
    [self showMenuButton];
    
    return self;
}

-(void)swi1: (UISwitch *)D79oM1 {


    if ([D79oM1 isOn]) {

swi1.tintColor = [UIColor greenColor];

swi1.layer.borderColor = [UIColor greenColor].CGColor;


}else{

swi1.tintColor = [UIColor redColor];

swi1.layer.borderColor = [UIColor redColor].CGColor;


}
}

-(void)swi2: (UISwitch *)D79oM2 {

    if ([D79oM2 isOn]) {

swi2.tintColor = [UIColor greenColor];

swi2.layer.borderColor = [UIColor greenColor].CGColor;

}else{

swi2.tintColor = [UIColor redColor];

swi2.layer.borderColor = [UIColor redColor].CGColor;

}
}




- (void)swiOn {


swi1.tintColor = [UIColor redColor];

swi2.tintColor = [UIColor redColor];

swi1.layer.borderColor = [UIColor redColor].CGColor;
swi1.layer.borderWidth = 3.0f;

swi2.layer.borderColor = [UIColor redColor].CGColor;
swi2.layer.borderWidth = 3.0f;

swi1.layer.cornerRadius = 15.0;
swi2.layer.cornerRadius = 15.0;


swi1.frame = CGRectMake(174.5, 53.5, 51, 31); 
swi2.frame = CGRectMake(174.5, 20.5, 51, 31);

[swi setTitle:off
forState:UIControlStateNormal];
    [close setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

[swi addTarget:self action:@selector(swiOff) forControlEvents:UIControlEventTouchUpInside];


}





- (void)swiOff {


swi1.frame = CGRectMake(99999999999999, 99999999999999, 99999999999999, 99999999999999); 
swi2.frame = CGRectMake(99999999999999, 99999999999999, 99999999999999, 99999999999999);

    [swi setTitle:on
forState:UIControlStateNormal];
    [close setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

[swi addTarget:self action:@selector(swiOn) forControlEvents:UIControlEventTouchUpInside];


}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    lastMenuLocation = CGPointMake(self.frame.origin.x, self.frame.origin.y);
    
    [super touchesBegan:touches withEvent:event];
}


- (void)menuDragged:(UIPanGestureRecognizer *)pan {
    CGPoint newLocation = [pan translationInView:self.superview];
    
    self.frame = CGRectMake(lastMenuLocation.x + newLocation.x, lastMenuLocation.y + newLocation.y, self.frame.size.width, self.frame.size.height);
}


- (void)hideMenu:(UITapGestureRecognizer *)tap {
    if(tap.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 animations:^ {
            self.alpha = 0.0f;
        }];
    }
}


-(void)showMenu:(UITapGestureRecognizer *)tapGestureRecognizer {
    if(tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 animations:^ {
            self.alpha = 1.0f;
        }];


        restoreLastSession();
    }
}

void restoreLastSession() {
    for(OffsetPatcher *op in scrollView.subviews) {
        if([op isKindOfClass:[OffsetPatcher class]]) {
            

            std::vector<uint64_t> offsets = [op getOffsets];

            std::vector<uint64_t>bytes = [op getBytes];

            std::vector<MemoryPatch> memoryPatches = [op getMemoryPatches];
            
            if([defaults boolForKey:[op getPreferencesKey]]) {
                op.backgroundColor = switchOnColor;
                
                for(int i = 0; i < offsets.size(); i++) {
                    if(memoryPatches[i].Modify()) {
                       NSLog(@"[Mod Menu] - Patched succesfully!");
                    } else {
                        NSLog(@"[Mod Menu] - Patched unsuccesfully...");
                    }
                }
            } 
            else {
                op.backgroundColor = [UIColor clearColor];
                
                for(int i = 0; i < offsets.size(); i++) {
                    if(memoryPatches[i].Restore()) {
                        NSLog(@"[Mod Menu] - Restored succesfully!");
                    } else {
                        NSLog(@"[Mod Menu] - Restored unsuccesfully...");
                    }
                }
            }
        }
    }
 
    for(TextFieldSwitch *tfs in scrollView.subviews) {
        if([tfs isKindOfClass:[TextFieldSwitch class]]) {
            if([defaults boolForKey:[tfs getPreferencesKey]]) {
                tfs.backgroundColor = switchOnColor;
            } else {
                tfs.backgroundColor = [UIColor clearColor];
            }
        }
    }
}

-(void)showMenuButton {
    NSData* data = [[NSData alloc] initWithBase64EncodedString:menuButtonBase64 options:0];
    UIImage* menuButtonImage = [UIImage imageWithData:data];        
    
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    menuButton.frame = CGRectMake((mainWindow.frame.size.width/3), (mainWindow.frame.size.height/3), 57, 58);
    menuButton.backgroundColor = [UIColor clearColor];
menuButton.layer.shadowOpacity = 5;
menuButton.layer.shadowColor = [UIColor whiteColor].CGColor;
menuButton.layer.shadowRadius = 10;
    [menuButton setBackgroundImage:menuButtonImage forState:UIControlStateNormal];
    

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMenu:)];
    [menuButton addGestureRecognizer:tapGestureRecognizer];
    

    [menuButton addTarget:self action:@selector(buttonDragged:withEvent:)
       forControlEvents:UIControlEventTouchDragInside];
    [mainWindow addSubview:menuButton];
}


- (void)buttonDragged:(UIButton *)button withEvent:(UIEvent *)event {
    UITouch *touch = [[event touchesForView:button] anyObject];
    
    CGPoint previousLocation = [touch previousLocationInView:button];
    CGPoint location = [touch locationInView:button];
    CGFloat delta_x = location.x - previousLocation.x;
    CGFloat delta_y = location.y - previousLocation.y;
    
    button.center = CGPointMake(button.center.x + delta_x, button.center.y + delta_y);
}


-(void)menuIconTapped {
    [self showPopup:menuTitle.text description:credits];
    selfView.layer.opacity = 0.0f;
}

-(void)showPopup:(NSString *)title_ description:(NSString *)description_ {

}


- (void)addOffsetSwitchToMenu:(OffsetPatcher *)offsetPatcher {
    

    [offsetPatcher addTarget:self action:@selector(hackClicked:) forControlEvents:UIControlEventTouchDown];
    

    scrollViewHeight += 50;
    scrollView.contentSize = CGSizeMake(menuWidth, scrollViewHeight);
    [scrollView addSubview:offsetPatcher];
}





-(void)hackClicked:(OffsetPatcher *)offsetPatcher {

NSURL *soundFileURL = [NSURL URLWithString:@"https://l.top4top.io/m_1908noa6v0.mp3"];


    NSError *error;

AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL

                                                                   error:&error];
    player.numberOfLoops = -1;


[player play];
      
    

    std::vector<uint64_t> offsets = [offsetPatcher getOffsets];
    std::vector<uint64_t>bytes = [offsetPatcher getBytes];
    std::vector<MemoryPatch> memoryPatches = [offsetPatcher getMemoryPatches];
    
    bool isOn = [defaults boolForKey:[offsetPatcher getPreferencesKey]];
    

    if(!isOn) {

        for(int i = 0; i < offsets.size(); i++) {

            if(memoryPatches[i].Modify()) {
                NSLog(@"[Mod Menu] - Patched succesfully!");
            } else {
                NSLog(@"[Mod Menu] - Patched unsuccesfully...");
            }
        }
     
        [UIView animateWithDuration:0.3 animations:^ {
            



offsetPatcher.backgroundColor = switchOnColor;
        }];
        
        [defaults setBool:true forKey:[offsetPatcher getPreferencesKey]];
    } else {




    
        for(int i = 0; i < offsets.size(); i++) {

            if(memoryPatches[i].Restore()) {
                NSLog(@"[Mod Menu] - Restored succesfully!");
            } else {
                NSLog(@"[Mod Menu] - Restored unsuccesfully...");
            }
        }
 
        [UIView animateWithDuration:0.3 animations:^ {
            offsetPatcher.backgroundColor = [UIColor clearColor];
        }];
        
        [defaults setBool:false forKey:[offsetPatcher getPreferencesKey]];
 
    }
}



- (void)addTextfieldSwitchToMenu:(TextFieldSwitch *)textfieldSwitch {
    

    [textfieldSwitch addTarget:self action:@selector(textfieldClicked:) forControlEvents:UIControlEventTouchDown];
    

    scrollViewHeight += 50;
    scrollView.contentSize = CGSizeMake(menuWidth, scrollViewHeight);
    [scrollView addSubview:textfieldSwitch];
}


-(void)textfieldClicked:(TextFieldSwitch *)textfieldSwitch {
    
    bool isOn = [defaults boolForKey:[textfieldSwitch getPreferencesKey]];
    

    if(!isOn) {
        [UIView animateWithDuration:0.3 animations:^ {
            textfieldSwitch.backgroundColor = switchOnColor;
        }];

        [defaults setBool:true forKey:[textfieldSwitch getPreferencesKey]];
        
    } else {
        [UIView animateWithDuration:0.3 animations:^ {
            textfieldSwitch.backgroundColor = [UIColor clearColor];
        }];
        
        [defaults setBool:false forKey:[textfieldSwitch getPreferencesKey]];
    }
    
}


- (void)addSliderSwitchToMenu:(SliderSwitch *)sliderSwitch {
    

    [sliderSwitch addTarget:self action:@selector(sliderSwitchClicked:) forControlEvents:UIControlEventTouchDown];
    

    scrollViewHeight += 50;
    scrollView.contentSize = CGSizeMake(menuWidth, scrollViewHeight);
    [scrollView addSubview:sliderSwitch];
}


-(void)sliderSwitchClicked:(SliderSwitch *)sliderSwitch {
    
    bool isOn = [defaults boolForKey:[sliderSwitch getPreferencesKey]];
    

    if(!isOn) {
        [UIView animateWithDuration:0.3 animations:^ {
            sliderSwitch.backgroundColor = switchOnColor;
        }];
        
        [defaults setBool:true forKey:[sliderSwitch getPreferencesKey]];
        
    } else {
        [UIView animateWithDuration:0.3 animations:^ {
            sliderSwitch.backgroundColor = [UIColor clearColor];
        }];
        
        [defaults setBool:false forKey:[sliderSwitch getPreferencesKey]];
    }
    
}
@end




@implementation OffsetPatcher {
    NSString *preferencesKey;
    std::vector<uint64_t> offsets;
    std::vector<uint64_t> bytes;
    std::vector<MemoryPatch> memoryPatches;
    UILabel *offsetPatchSwitch;
    NSString *description;
}

- (id)initHackNamed:(NSString *)hackName_ description:(NSString *)description_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<uint64_t>)bytes_ {
    
    offsets = offsets_;
    bytes = bytes_;
    description = description_;


    for(int i = 0; i < offsets.size(); i++) {

        if(bytes[i] < 0xFFFFFFFF) {
            bytes[i] = _OSSwapInt32(bytes[i]);
            memoryPatches.push_back(MemoryPatch(NULL,offsets[i], &bytes[i], sizeof(uint32_t)));
        } else {
            bytes[i] = _OSSwapInt64(bytes[i]);
            memoryPatches.push_back(MemoryPatch(NULL,offsets[i], &bytes[i], sizeof(uint64_t)));
        }
    }
    
    preferencesKey = hackName_;
    
    self = [super initWithFrame:CGRectMake(-1, scrollViewX + scrollViewHeight - 1, menuWidth + 2, 50)];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    
    offsetPatchSwitch = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, menuWidth - 60, 50)];
    offsetPatchSwitch.text = hackName_;
    offsetPatchSwitch.textColor = switchTitleColor;
    offsetPatchSwitch.font = [UIFont fontWithName:switchTitleFont size:18];
    offsetPatchSwitch.adjustsFontSizeToFitWidth = true;
    offsetPatchSwitch.textAlignment = NSTextAlignmentCenter;
    [self addSubview:offsetPatchSwitch];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    infoButton.frame = CGRectMake(menuWidth - 30, 15, 20, 20);
    infoButton.tintColor = infoButtonColor;
    
   
    
    return self;
}



-(NSString *)getPreferencesKey {
    return preferencesKey;
}

-(NSString *)getDescription {
    return description;
}

- (std::vector<uint64_t>)getOffsets {
    return offsets;
}

- (std::vector<uint64_t>)getBytes {
    return bytes;
}

- (std::vector<MemoryPatch>)getMemoryPatches {
    return memoryPatches;
}


@end



@implementation TextFieldSwitch {
    NSString *preferencesKey;
    NSString *switchValueKey;
    NSString *description;
    UILabel *textfieldSwitch;
    UILabel *descirptionLabel;
    UITextField *textfieldValue;
}

- (id)initTextfieldNamed:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_ {
    

    preferencesKey = hackName_;

    switchValueKey = [hackName_ stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];
    
    description = description_;
    
    self = [super initWithFrame:CGRectMake(-1, scrollViewX + scrollViewHeight -1, menuWidth + 2, 50)];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    

    textfieldSwitch = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, menuWidth - 60, 30)];
    textfieldSwitch.text = hackName_;
    textfieldSwitch.textColor = switchTitleColor;
    textfieldSwitch.font = [UIFont fontWithName:switchTitleFont size:18];
    textfieldSwitch.adjustsFontSizeToFitWidth = true;
    textfieldSwitch.textAlignment = NSTextAlignmentCenter;
    [self addSubview:textfieldSwitch];
    

    textfieldValue = [[UITextField alloc]initWithFrame:CGRectMake(menuWidth / 4 - 10, textfieldSwitch.self.bounds.origin.x - 5 + textfieldSwitch.self.bounds.size.height, menuWidth / 2, 20)];
    textfieldValue.layer.borderWidth = 2.0f;
    textfieldValue.layer.borderColor = inputBorderColor_.CGColor;
    textfieldValue.layer.cornerRadius = 10.0f;
    textfieldValue.textColor = switchTitleColor;
    textfieldValue.textAlignment = NSTextAlignmentCenter;
    textfieldValue.delegate = self;
    textfieldValue.backgroundColor = [UIColor clearColor];
    

    if([[NSUserDefaults standardUserDefaults] objectForKey:switchValueKey] != nil) {

        textfieldValue.text = [[NSUserDefaults standardUserDefaults] objectForKey:switchValueKey];
    }
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    infoButton.frame = CGRectMake(menuWidth - 30, 15, 20, 20);
    infoButton.tintColor = infoButtonColor;
    
   
    
    [self addSubview:textfieldValue];
    
    return self;
}


-(BOOL)textFieldShouldReturn:(UITextField*)textfieldValue_ {
    

    switchValueKey = [[self getPreferencesKey] stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];
    [defaults setObject:textfieldValue_.text forKey:[self getSwitchValueKey]];
    [textfieldValue_ resignFirstResponder];
    
    return true;
}

-(NSString *)getPreferencesKey {
    return preferencesKey;
}

-(NSString *)getSwitchValueKey {
    return switchValueKey;
}

-(NSString *)getDescription {
    return description;
}
@end





@implementation SliderSwitch {
    NSString *hackName;
    NSString *preferencesKey;
    NSString *switchValueKey;
    NSString *description;
    UILabel *sliderSwitch;
    UILabel *descirptionLabel;
    UISlider *sliderValue;
    float valueOfSlider;
}

- (id)initSliderNamed:(NSString *)hackName_ description:(NSString *)description_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_{
    

    preferencesKey = hackName_;

    switchValueKey = [hackName_ stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];
    
    description = description_;
    
    self = [super initWithFrame:CGRectMake(-1, scrollViewX + scrollViewHeight -1, menuWidth + 2, 50)];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    

    sliderSwitch = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, menuWidth - 60, 30)];
    sliderSwitch.text = [NSString stringWithFormat:@"%@ %.2f", hackName_, sliderValue.value];
    sliderSwitch.textColor = switchTitleColor;
    sliderSwitch.font = [UIFont fontWithName:switchTitleFont size:18];
    sliderSwitch.adjustsFontSizeToFitWidth = true;
    sliderSwitch.textAlignment = NSTextAlignmentCenter;
    [self addSubview:sliderSwitch];
    

    sliderValue = [[UISlider alloc]initWithFrame:CGRectMake(menuWidth / 4 - 20, sliderSwitch.self.bounds.origin.x - 4 + sliderSwitch.self.bounds.size.height, menuWidth / 2 + 20, 20)];
    sliderValue.thumbTintColor = sliderColor_;
    sliderValue.minimumTrackTintColor = switchTitleColor;
    sliderValue.maximumTrackTintColor = switchTitleColor;
    sliderValue.minimumValue = minimumValue_;
    sliderValue.maximumValue = maximumValue_;
    sliderValue.continuous = true;
    [sliderValue addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    valueOfSlider = sliderValue.value;
    

    if([[NSUserDefaults standardUserDefaults] objectForKey:switchValueKey] != nil) {
        sliderValue.value = [[NSUserDefaults standardUserDefaults] floatForKey:switchValueKey];
        sliderSwitch.text = [NSString stringWithFormat:@"%@ %.2f", hackName_, sliderValue.value];
    }
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    infoButton.frame = CGRectMake(menuWidth - 30, 15, 20, 20);
    infoButton.tintColor = infoButtonColor;
    
   
    
    [self addSubview:sliderValue];
    
    return self;
}

-(void)sliderValueChanged:(UISlider *)slider_ {
    

    switchValueKey = [[self getPreferencesKey] stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];

    sliderSwitch.text = [NSString stringWithFormat:@"%@ %.2f", [self getPreferencesKey], slider_.value];
    
    [defaults setFloat:slider_.value forKey:[self getSwitchValueKey]];
}

-(NSString *)getPreferencesKey {
    return preferencesKey;
}

-(NSString *)getSwitchValueKey {
    return switchValueKey;
}

-(NSString *)getDescription {
    return description;
}

@end