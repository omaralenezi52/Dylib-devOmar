// ============================================================
//  Dev Omar — Credits Dylib
//  Twitter: FQ_1E   |   Telegram: o52lo
// ============================================================
//  بطاقة حقوق أنيقة تظهر بمنتصف الشاشة أول ما يفتح التطبيق.
//  تدعم الوضع الليلي والنهاري.
//  كل الإعدادات تحت مباشرة — عدّلها براحتك.
// ============================================================

#import <UIKit/UIKit.h>

// ================= الإعدادات =================
static NSString *const kOwnerName    = @"OMAR";                     // الاسم الظاهر
static NSString *const kMessage      = @"شكراً لاستخدامك التطبيق";   // الرسالة تحت الاسم
static NSString *const kTwitterUser  = @"FQ_1E";                   // يوزر تويتر (بدون @)
static NSString *const kTelegramUser = @"o52lo";                   // يوزر تيليجرام (بدون @)

// اللون الرئيسي للأزرار (تليجرام) — غيّره لما تبي
#define kAccentColor  [UIColor colorWithRed:0.16 green:0.55 blue:0.92 alpha:1.0]

// نوع الظهور: YES = مرة وحدة بعمر التطبيق | NO = كل ما يفتح التطبيق
static const BOOL kShowOnce = NO;
// =============================================

static BOOL gShown = NO;

#pragma mark - Overlay View

@interface OMRCreditsOverlay : UIView
@property (nonatomic, strong) UIView *card;
- (void)present;
@end

@implementation OMRCreditsOverlay

+ (UIImage *)appIcon {
    NSDictionary *icons = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIcons"];
    NSArray *files = icons[@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    return files.lastObject ? [UIImage imageNamed:files.lastObject] : nil;
}

+ (void)openURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) return;
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self buildUI];
    }
    return self;
}

- (BOOL)isDark {
    if (@available(iOS 13.0, *)) {
        return (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark);
    }
    return NO;
}

- (void)buildUI {
    BOOL dark = [self isDark];
    UIColor *cardBG    = dark ? [UIColor colorWithRed:0.11 green:0.11 blue:0.12 alpha:1.0] : [UIColor whiteColor];
    UIColor *textMain  = dark ? [UIColor whiteColor] : [UIColor colorWithRed:0.1 green:0.1 blue:0.12 alpha:1.0];
    UIColor *textSub   = dark ? [UIColor colorWithWhite:0.7 alpha:1.0] : [UIColor colorWithWhite:0.45 alpha:1.0];
    UIColor *btnBorder = dark ? [UIColor colorWithWhite:1.0 alpha:0.18] : [UIColor colorWithWhite:0.0 alpha:0.12];

    // إغلاق باللمس على الخلفية
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTapped:)];
    [self addGestureRecognizer:tap];

    // ---- البطاقة ----
    CGFloat cardW = MIN(320.0, self.bounds.size.width - 48.0);
    UIView *card = [[UIView alloc] init];
    self.card = card;
    card.backgroundColor = cardBG;
    card.layer.cornerRadius = 22.0;
    card.layer.shadowColor = [UIColor blackColor].CGColor;
    card.layer.shadowOpacity = dark ? 0.5 : 0.18;
    card.layer.shadowRadius = 24.0;
    card.layer.shadowOffset = CGSizeMake(0, 10);
    card.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:card];
    [NSLayoutConstraint activateConstraints:@[
        [card.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [card.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [card.widthAnchor constraintEqualToConstant:cardW],
    ]];

    // ستاك عمودي
    UIStackView *stack = [[UIStackView alloc] init];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.alignment = UIStackViewAlignmentCenter;
    stack.spacing = 12.0;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [card addSubview:stack];
    [NSLayoutConstraint activateConstraints:@[
        [stack.topAnchor constraintEqualToAnchor:card.topAnchor constant:26],
        [stack.bottomAnchor constraintEqualToAnchor:card.bottomAnchor constant:-22],
        [stack.leadingAnchor constraintEqualToAnchor:card.leadingAnchor constant:22],
        [stack.trailingAnchor constraintEqualToAnchor:card.trailingAnchor constant:-22],
    ]];

    // ---- زر الإغلاق X ----
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeBtn setTitle:@"✕" forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    [closeBtn setTitleColor:textSub forState:UIControlStateNormal];
    closeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [card addSubview:closeBtn];
    [NSLayoutConstraint activateConstraints:@[
        [closeBtn.topAnchor constraintEqualToAnchor:card.topAnchor constant:10],
        [closeBtn.trailingAnchor constraintEqualToAnchor:card.trailingAnchor constant:-14],
        [closeBtn.widthAnchor constraintEqualToConstant:30],
        [closeBtn.heightAnchor constraintEqualToConstant:30],
    ]];

    // ---- الأيقونة ----
    UIImage *icon = [OMRCreditsOverlay appIcon];
    if (icon) {
        UIImageView *iv = [[UIImageView alloc] initWithImage:icon];
        iv.layer.cornerRadius = 16.0;
        iv.layer.masksToBounds = YES;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.translatesAutoresizingMaskIntoConstraints = NO;
        [iv.widthAnchor constraintEqualToConstant:72].active = YES;
        [iv.heightAnchor constraintEqualToConstant:72].active = YES;
        [stack addArrangedSubview:iv];
    }

    // ---- الاسم ----
    UILabel *name = [[UILabel alloc] init];
    name.text = kOwnerName;
    name.font = [UIFont systemFontOfSize:26 weight:UIFontWeightHeavy];
    name.textColor = textMain;
    name.textAlignment = NSTextAlignmentCenter;
    [stack addArrangedSubview:name];

    // ---- الرسالة ----
    UILabel *msg = [[UILabel alloc] init];
    msg.text = kMessage;
    msg.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    msg.textColor = textSub;
    msg.textAlignment = NSTextAlignmentCenter;
    msg.numberOfLines = 0;
    [stack addArrangedSubview:msg];

    UIView *spacer = [[UIView alloc] init];
    [spacer.heightAnchor constraintEqualToConstant:4].active = YES;
    [stack addArrangedSubview:spacer];

    // ---- زر تويتر ----
    UIButton *tw = [self accountButtonTitle:[NSString stringWithFormat:@"𝕏  %@", kTwitterUser]
                                       text:textMain border:btnBorder];
    [tw addTarget:self action:@selector(openTwitter) forControlEvents:UIControlEventTouchUpInside];
    [stack addArrangedSubview:tw];
    [tw.widthAnchor constraintEqualToAnchor:stack.widthAnchor].active = YES;
    [tw.heightAnchor constraintEqualToConstant:46].active = YES;

    // ---- زر تيليجرام (الرئيسي) ----
    UIButton *tg = [UIButton buttonWithType:UIButtonTypeSystem];
    [tg setTitle:[NSString stringWithFormat:@"✈  Telegram — %@", kTelegramUser] forState:UIControlStateNormal];
    tg.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    [tg setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tg.backgroundColor = kAccentColor;
    tg.layer.cornerRadius = 14.0;
    [tg addTarget:self action:@selector(openTelegram) forControlEvents:UIControlEventTouchUpInside];
    [stack addArrangedSubview:tg];
    [tg.widthAnchor constraintEqualToAnchor:stack.widthAnchor].active = YES;
    [tg.heightAnchor constraintEqualToConstant:50].active = YES;
}

- (UIButton *)accountButtonTitle:(NSString *)title text:(UIColor *)text border:(UIColor *)border {
    UIButton *b = [UIButton buttonWithType:UIButtonTypeSystem];
    [b setTitle:title forState:UIControlStateNormal];
    b.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    [b setTitleColor:text forState:UIControlStateNormal];
    b.layer.cornerRadius = 14.0;
    b.layer.borderWidth = 1.0;
    b.layer.borderColor = border.CGColor;
    return b;
}

- (void)openTwitter  { [OMRCreditsOverlay openURL:[NSString stringWithFormat:@"https://twitter.com/%@", kTwitterUser]]; }
- (void)openTelegram { [OMRCreditsOverlay openURL:[NSString stringWithFormat:@"https://t.me/%@", kTelegramUser]]; }

- (void)present {
    self.card.transform = CGAffineTransformMakeScale(0.85, 0.85);
    self.card.alpha = 0.0;
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:0.5 options:0 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.45];
        self.card.transform = CGAffineTransformIdentity;
        self.card.alpha = 1.0;
    } completion:nil];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.card.alpha = 0.0;
        self.card.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL f){ [self removeFromSuperview]; }];
}

- (void)bgTapped:(UITapGestureRecognizer *)tap {
    CGPoint p = [tap locationInView:self];
    if (!CGRectContainsPoint(self.card.frame, p)) {
        [self dismiss];
    }
}

@end

#pragma mark - Helpers

static UIWindow *OMRActiveWindow(void) {
    UIWindow *fallback = nil;
    for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
        if (![scene isKindOfClass:[UIWindowScene class]]) continue;
        UIWindowScene *ws = (UIWindowScene *)scene;
        for (UIWindow *w in ws.windows) {
            if (!fallback) fallback = w;
            if (w.isKeyWindow) return w;
        }
    }
    return fallback;
}

static void OMRShowCredits(void) {
    UIWindow *host = OMRActiveWindow();
    if (!host) return;
    OMRCreditsOverlay *overlay = [[OMRCreditsOverlay alloc] initWithFrame:host.bounds];
    [host addSubview:overlay];
    [overlay present];
}

#pragma mark - Entry (no Substrate needed — works on sideloaded apps)

static void OMRScheduleShow(void) {
    if (kShowOnce && gShown) return;
    gShown = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        OMRShowCredits();
    });
}

__attribute__((constructor))
static void OMRInit(void) {
    @autoreleasepool {
        // نراقب لحظة تفعيل التطبيق — لا يحتاج Substrate
        [[NSNotificationCenter defaultCenter]
            addObserverForName:UIApplicationDidBecomeActiveNotification
                        object:nil
                         queue:[NSOperationQueue mainQueue]
                    usingBlock:^(NSNotification *note) {
            OMRScheduleShow();
        }];

        // احتياط: لو كان التطبيق فعّال قبل تحميل الدايلب
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
                OMRScheduleShow();
            }
        });
    }
}
