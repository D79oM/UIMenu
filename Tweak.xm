#import "Macros.h"

void setup() {

patchOffset(0x10254DFAC ,0xE003271E);

[switches addOffsetSwitch:@" علامة تصويب | SMALL CROSS "
description:@""
offsets:{0x10254DFAC}
bytes:{0xE003271E}];

                                    
}

void setupMenu() {
menu = [[Menu alloc]  initWithTitle:@"‍ᗪ79ㄖ爪 ~"
titleColor:[UIColor blackColor]
titleFont:@"Copperplate-Bold"
credits:@""
headerColor:[[UIColor whiteColor] colorWithAlphaComponent:0.60]
switchOffColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.86]
switchOnColor:[[UIColor alloc] initWithPatternImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://j.top4top.io/p_1904yxupi0.png"]]]]
switchTitleFont:@"Copperplate-Bold"switchTitleColor:[UIColor whiteColor]
infoButtonColor:[UIColor whiteColor]
maxVisibleSwitches:4
menuWidth:350
menuIcon:@""
#import "MenuButton.h"
];

setup();
}

static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {

NSUserDefaults *check;
check = [NSUserDefaults standardUserDefaults];

timer(5) {

setupMenu();

UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ᗪ79ㄖ爪 ~" message:@"By @D79oM" 
preferredStyle:UIAlertControllerStyleAlert];

UIAlertAction* D79oMButton = [UIAlertAction

actionWithTitle:@"ENJOY" style:UIAlertActionStyleDefault
handler:^(UIAlertAction * action) {
}];

[D79oMButton setValue:[UIColor redColor] forKey:@"titleTextColor"];

[alert addAction:D79oMButton];

[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];

});
}
%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}