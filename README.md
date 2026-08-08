# Dylib-devOmar

بطاقة حقوق أنيقة تظهر بمنتصف الشاشة أول ما يفتح التطبيق.
تدعم الوضع الليلي والنهاري، مع أزرار تواصل متناسقة.

**By OMAR** — Twitter: `FQ_1E` · Telegram: `o52lo`

## كيف أحصل على ملف الـ dylib؟

1. أي تعديل ترفعه على المستودع (branch `main`) يبني الـ dylib تلقائياً عبر GitHub Actions.
2. بعد ما يخلص البناء (علامة ✅ خضراء)، روح على تبويب **Releases** بالمستودع.
3. حمّل `DevOmar.dylib` من آخر Release.
   - أو من تبويب **Actions** → آخر تشغيل → قسم **Artifacts**.

## التخصيص

كل الإعدادات بأعلى ملف [`Tweak.x`](Tweak.x):

| الإعداد | الوظيفة |
|---------|---------|
| `kOwnerName` | الاسم الظاهر |
| `kMessage` | الرسالة تحت الاسم |
| `kTwitterUser` | يوزر تويتر (بدون @) |
| `kTelegramUser` | يوزر تيليجرام (بدون @) |
| `kAccentColor` | لون زر تيليجرام |
| `kShowOnce` | `YES` = مرة وحدة / `NO` = كل فتح |

## الحقن

استخدم أداة مثل **Sideloadly** (خانة Inject dylibs) أو **cyan** لحقن `DevOmar.dylib` بأي تطبيق IPA.
