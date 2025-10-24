// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'لوبي';

  @override
  String get selectLanguageTitle => 'اختر لغتك';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonOpenSettings => 'فتح الإعدادات';

  @override
  String get commonErrorGeneric => 'حدث خطأ ما!';

  @override
  String get commonNoItems => 'لا توجد عناصر مضافة هنا...';

  @override
  String get commonSelectRole => 'اختر دورك الآن!';

  @override
  String get formFillRequired => 'يرجى ملء جميع الحقول';

  @override
  String get messageSentSuccessfully => 'تم إرسال الرسالة بنجاح';

  @override
  String get redirectingToRegistration => 'يتم التحويل إلى التسجيل...';

  @override
  String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get resetPasswordButton => 'إعادة تعيين كلمة المرور';

  @override
  String get verifyEmailTitle => 'تأكيد البريد الإلكتروني';

  @override
  String get sendVerificationEmailButton => 'إرسال رسالة التأكيد';

  @override
  String get confirmButton => 'تأكيد';

  @override
  String permissionRequiredTitle(String permission) {
    return 'مطلوب إذن $permission';
  }

  @override
  String permissionRequiredBody(String permission, String purpose) {
    return 'يحتاج التطبيق إلى إذن $permission $purpose. يرجى منح الإذن في إعدادات التطبيق.';
  }

  @override
  String mediaMaxReached(int count) {
    return 'الحد الأقصى للوسائط هو $count';
  }

  @override
  String imageSizeTooLarge(int size) {
    return 'حجم الصورة كبير جداً. يجب أن يكون أقل من $size ميجابايت';
  }

  @override
  String get imagePickFailed => 'فشل في اختيار الصورة';

  @override
  String get mustPickImageBeforeVideo => 'يجب اختيار صورة أولاً قبل إضافة فيديو';

  @override
  String get onlyMp4Allowed => 'يُسمح فقط برفع فيديو MP4';

  @override
  String get videoPickFailed => 'فشل في اختيار الفيديو';

  @override
  String get atLeastOneImageMustRemain => 'يجب أن تبقى صورة واحدة على الأقل';

  @override
  String get cannotRemoveFirstImage => 'لا يمكن إزالة الصورة الأولى لأنها الوحيدة';

  @override
  String get filePickFailed => 'فشل في اختيار الملف';

  @override
  String fileTooLarge(int size) {
    return 'حجم الملف كبير جداً. يجب أن يكون أقل من $size ميجابايت';
  }

  @override
  String get errorPickingImage => 'حدث خطأ أثناء اختيار الصورة';

  @override
  String someImagesIgnoredOver(int size) {
    return 'تم تجاهل بعض الصور التي يتجاوز حجمها $size ميجابايت';
  }

  @override
  String get errorPickingImages => 'حدث خطأ أثناء اختيار الصور';

  @override
  String get errorPickingFile => 'حدث خطأ أثناء اختيار الملف';

  @override
  String videoTooLarge(int size) {
    return 'حجم الفيديو كبير جداً. يجب أن يكون أقل من $size ميجابايت';
  }

  @override
  String get errorPickingVideo => 'حدث خطأ أثناء اختيار الفيديو';

  @override
  String get activityUpdatedSuccess => 'تم تحديث النشاط بنجاح';

  @override
  String get cardDetailsAddedSuccessfully => 'تمت إضافة تفاصيل البطاقة بنجاح';

  @override
  String errorWithMessage(String message) {
    return 'خطأ: $message';
  }

  @override
  String checkInLabel(String date) {
    return 'تسجيل الدخول - $date';
  }

  @override
  String checkOutLabel(String date) {
    return 'تسجيل الخروج - $date';
  }

  @override
  String priceWithCurrency(num price, String currency) {
    return 'السعر : $price $currency';
  }

  @override
  String get currencySar => 'ر.س';

  @override
  String get pleaseAgreeToTerms => 'يرجى الموافقة على الشروط والأحكام';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get onlyJpgOrPngAllowed => 'يرجى اختيار صورة بصيغة JPG أو PNG فقط';

  @override
  String get conversationTitle => 'محادثاتك';

  @override
  String get searchHint => 'ابحث...';

  @override
  String get deleteConversationTitle => 'حذف المحادثة';

  @override
  String deleteConversationContent(String name) {
    return 'هل أنت متأكد أنك تريد حذف المحادثة مع $name?';
  }

  @override
  String get conversationDeletedSuccessfully => 'تم حذف المحادثة بنجاح';

  @override
  String get conversationDeleteError => 'حدث خطأ أثناء حذف المحادثة';

  @override
  String get commonDelete => 'حذف';

  @override
  String get activityDeletedSuccessfully => 'تم حذف النشاط بنجاح';

  @override
  String get deletePropertyTitle => 'حذف العقار';

  @override
  String get deletePropertyContent => 'هل أنت متأكد أنك تريد حذف هذا العقار؟';

  @override
  String get guestUser => 'مستخدم زائر';

  @override
  String get welcomeToOurApp => 'مرحبًا بك في تطبيقنا';

  @override
  String get start => 'ابدأ';

  @override
  String get yourProperties => 'عقاراتك';

  @override
  String get yourActivities => 'أنشطتك';

  @override
  String get beVendorNow => 'كن بائعًا الآن!';

  @override
  String get appCommission => 'عمولة التطبيق';

  @override
  String get commissionDetails => 'عمولة الطرف الأول لكل حجز يتم بواسطة الطرف الثاني هي 15% من الإيجار (لا تشمل ضريبة القيمة المضافة).';

  @override
  String get emailNotVerifiedMsg => 'لم يتم التحقق من بريدك الإلكتروني. يرجى الانتظار حتى يتم التحقق ثم حاول مرة أخرى.';

  @override
  String get account => 'الحساب';

  @override
  String get accountInfo => 'معلومات الحساب';

  @override
  String get save => 'حفظ';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get areYouSureDeleteAccount => 'هل أنت متأكد من حذف حسابك؟';

  @override
  String get yes => 'نعم';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get createYourAccount => 'أنشئ حسابك للمتابعة في استخدام التطبيق';

  @override
  String get agreeToTerms => 'الموافقة على الشروط والأحكام';

  @override
  String get comingSoon => 'قريبًا...';

  @override
  String get rateApp => 'قيّم التطبيق';

  @override
  String get inviteFriends => 'ادعُ الأصدقاء';

  @override
  String get noConversationsYet => 'لا توجد لديك أي محادثة بعد';

  @override
  String get toFunctionProperly => 'لتعمل بشكل صحيح';

  @override
  String get continueAsGuest => 'المتابعة كضيف';

  @override
  String get welcomeBack => 'مرحبًا بعودتك!';

  @override
  String get loginIntro => 'يرجى إدخال البريد الإلكتروني وكلمة المرور لتسجيل الدخول إلى حسابك.';

  @override
  String get emailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get orContinueWith => 'أو تابع باستخدام';

  @override
  String get continueWithGoogle => 'المتابعة باستخدام جوجل';

  @override
  String get continueWithFacebook => 'المتابعة باستخدام فيسبوك';

  @override
  String get yourName => 'اسمك';

  @override
  String get language => 'اللغة';

  @override
  String get yourAccount => 'حسابك';

  @override
  String get wallet => 'المحفظة';

  @override
  String get hostWithUs => 'استضف معنا';

  @override
  String get aboutLoby => 'عن لوبي';

  @override
  String get termsAndConditions => 'الشروط والأحكام';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get pleaseSelectValidAddress => 'يرجى اختيار عنوان صالح من الخريطة';

  @override
  String get enterActivityInfo => 'يرجى إدخال معلومات النشاط';

  @override
  String get nameOfActivity => 'اسم النشاط';

  @override
  String get enterActivityName => 'أدخل اسم النشاط';

  @override
  String get uploadStudioPhotosOrVideo => 'تحميل صور أو فيديو الاستوديو';

  @override
  String get activityTimeLabel => 'وقت النشاط';

  @override
  String get enterActivityTime => 'أدخل وقت النشاط';

  @override
  String get pleaseEnterActivityTime => 'يرجى إدخال وقت النشاط';

  @override
  String hoursHint(String count) {
    return '$count ساعات';
  }

  @override
  String get maximumGuests => 'الحد الأقصى للضيوف';

  @override
  String get enterMaxGuests => 'أدخل الحد الأقصى للضيوف';

  @override
  String get pleaseEnterMaxGuests => 'يرجى إدخال الحد الأقصى لعدد الضيوف';

  @override
  String get priceLabel => 'السعر';

  @override
  String get enterPrice => 'أدخل السعر';

  @override
  String get pleaseEnterPrice => 'يرجى إدخال السعر';

  @override
  String get update => 'تحديث';

  @override
  String get propertyUpdatedSuccessfully => 'تم تحديث العقار بنجاح';

  @override
  String get pleaseEnterValidEmail => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get pleaseCompleteInformation => 'يرجى إكمال المعلومات التالية';

  @override
  String get enterPropertyInfo => 'يرجى إدخال معلومات العقار';

  @override
  String get pleaseSelectAddressOnMap => 'يرجى تحديد العنوان على الخريطة';

  @override
  String get pleaseUploadAtLeastOneImage => 'يرجى رفع صورة واحدة على الأقل';

  @override
  String get propertyCreatedSuccessfully => 'تم إنشاء العقار بنجاح';

  @override
  String get addSomeDetails => 'أضف بعض التفاصيل';

  @override
  String get addDetails => 'أضف التفاصيل';

  @override
  String get pleaseEnterYourDetails => 'يرجى إدخال التفاصيل';

  @override
  String get tellGuestsWhatPlaceOffers => 'أخبر الضيوف بما يقدمه مكانك';

  @override
  String get uploadStudioPhotosOrVideoAlt => 'صور أو فيديو الاستوديو';

  @override
  String get uploadLeaseOrOwnershipContract => 'رفع عقد الإيجار أو الملكية';

  @override
  String get leaseOrOwnershipContract => 'عقد الإيجار أو الملكية';

  @override
  String get uploadTouristFacilityLicense => 'رفع ترخيص منشأة الضيافة السياحية';

  @override
  String get touristFacilityLicense => 'ترخيص منشأة الضيافة السياحية';

  @override
  String get optional => '(اختياري)';

  @override
  String get availableDateRange => 'نطاق التواريخ المتاح';

  @override
  String startDateLabel(String date) {
    return 'تاريخ البدء:   $date';
  }

  @override
  String endDateLabel(String date) {
    return 'تاريخ الانتهاء:   $date';
  }

  @override
  String get add => 'إضافة';

  @override
  String get lobyPlatformUsageAgreement => 'اتفاقية استخدام منصة لوبي';

  @override
  String get address => 'العنوان';

  @override
  String get enterYourAddressOrTapMap => 'أدخل عنوانك أو اضغط على أيقونة الخريطة للاختيار';

  @override
  String get pleaseEnterYourAddress => 'يرجى إدخال عنوانك';

  @override
  String get addSomeDetailsLabel => 'أضف بعض التفاصيل';

  @override
  String get addDetailsHint => 'أضف التفاصيل';

  @override
  String get pleaseEnterSomeDetails => 'يرجى إدخال بعض التفاصيل';

  @override
  String get tellGuestsOffers => 'أخبر الضيوف بما يقدمه مكانك';

  @override
  String get dateLabel => 'التاريخ';

  @override
  String get timeLabel => 'الوقت';

  @override
  String get yyyyMMdd => 'yyyy-MM-dd';

  @override
  String get hhmm => 'HH:MM';

  @override
  String get pricePerPersonHint => 'أدخل السعر لكل شخص';

  @override
  String get pricePerPerson => 'السعر لكل شخص';

  @override
  String get guestNumber => 'عدد الضيوف';

  @override
  String get enterMaxGuestNumber => 'أدخل الحد الأقصى لعدد الضيوف';

  @override
  String pleaseEnterField(String field) {
    return 'يرجى إدخال $field';
  }

  @override
  String enterOtpSentTo(String email) {
    return 'أدخل رمز التحقق المرسل إلى $email';
  }

  @override
  String get otp => 'رمز التحقق';

  @override
  String get pleaseEnterValidOtp => 'يرجى إدخال رمز تحقق صالح';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get pleaseEnterNewPassword => 'يرجى إدخال كلمة مرور جديدة';

  @override
  String get passwordAtLeastSix => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get pleaseConfirmYourPassword => 'يرجى تأكيد كلمة المرور';

  @override
  String get vendorPleaseChoose => 'يرجى الاختيار';

  @override
  String get vendorPropertyOwner => 'مالك عقار';

  @override
  String get vendorTouristActivity => 'نشاط سياحي';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navBookings => 'الحجوزات';

  @override
  String get navMessages => 'الرسائل';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get vendorIntroText => 'نص تجريبي: لوريم إيبسوم دولار سيت أميت، كونسيكتيتور أديبيسيسينغ إليت.\nديام هابيتانت.';

  @override
  String availabilityQuestion(String type) {
    return 'هل $type متاح؟';
  }

  @override
  String get availableLabel => 'متاح';

  @override
  String get notAvailableLabel => 'غير متاح';

  @override
  String get enterPricePerNight => 'أدخل السعر لليلة';

  @override
  String get continueLabel => 'متابعة';

  @override
  String get searchLocation => 'ابحث عن الموقع';

  @override
  String get lobbyOffersTitle => 'عروض لوبي';

  @override
  String get lobbyOffersDescription => 'إذا أضفت من شقة واحدة إلى 10 تكون النسبة 10% - من 0 إلى 20 تكون النسبة 15% - أكثر من 25 تكون النسبة 20%';

  @override
  String get imageLabel => 'صورة';

  @override
  String get videoLabel => 'فيديو';

  @override
  String uploadAtLeastOneImageWithMax(int count) {
    return 'ارفع صورة واحدة على الأقل (بحد أقصى $count وسائط)';
  }

  @override
  String get selectedLocation => 'الموقع المختار';

  @override
  String get gettingAddress => 'جارٍ جلب العنوان...';

  @override
  String get dragToSelectLocation => 'اسحب لتحديد الموقع';

  @override
  String get useCurrentLocation => 'استخدام الموقع الحالي';

  @override
  String get updateAddress => 'تحديث العنوان';

  @override
  String get confirmLocation => 'تأكيد الموقع';

  @override
  String get shareSomeBasics => 'شارك بعض الأساسيات عن مكانك';

  @override
  String get bedrooms => 'غرف نوم';

  @override
  String get beds => 'أسِرّة';

  @override
  String get bathrooms => 'حمّامات';

  @override
  String get addNewTagTitle => 'أضف وسمًا جديدًا';

  @override
  String get enterTagNameHint => 'أدخل اسم الوسم';

  @override
  String get commonAdd => 'إضافة';

  @override
  String get addOtherThings => 'أضف أشياء أخرى';

  @override
  String get reservationTitle => 'الحجوزات';

  @override
  String get currentReservations => 'الحجوزات الحالية';

  @override
  String get lastReservations => 'آخر الحجوزات';

  @override
  String get noReservationsFound => 'لا توجد حجوزات';

  @override
  String get dateLabelInline => 'التاريخ';

  @override
  String get checkOutInline => 'تسجيل الخروج';

  @override
  String get viewReservationDetails => 'عرض تفاصيل الحجز';

  @override
  String get clientName => 'اسم العميل';

  @override
  String reservationNumberLabel(String number) {
    return 'رقم الحجز $number';
  }

  @override
  String lastNumberLabel(String number) {
    return 'آخر رقم $number';
  }

  @override
  String freeCancellationBefore(String date) {
    return 'إلغاء مجاني قبل $date';
  }

  @override
  String get orderDetails => 'تفاصيل الطلب';

  @override
  String get summary => 'الملخص';

  @override
  String get commonAccept => 'قبول';

  @override
  String get commonRefuse => 'رفض';

  @override
  String get noteClientPaidFees => 'ملاحظة: قام العميل بدفع الرسوم';

  @override
  String get viewReservationSummary => 'عرض ملخص الحجز';

  @override
  String personCount(int count) {
    return '$count شخص';
  }

  @override
  String reservationStatusMessage(String status) {
    return 'حالة الحجز: $status';
  }

  @override
  String get statusCompleted => 'مكتمل';

  @override
  String get statusConfirmed => 'مؤكد';

  @override
  String get statusRefund => 'مسترد';

  @override
  String get availableBalance => 'الرصيد المتاح';

  @override
  String get updatedSuccessfully => 'تم التحديث بنجاح';

  @override
  String nightCount(int count) {
    return '$count ليلة';
  }

  @override
  String get perNight => 'لكل ليلة';

  @override
  String get fees => 'الرسوم';

  @override
  String get totalPrice => 'إجمالي السعر';

  @override
  String billCodeLabel(String code) {
    return 'رمز الفاتورة : $code';
  }

  @override
  String get totalPriceLabel => 'إجمالي السعر :';

  @override
  String get billDetails => 'تفاصيل الفاتورة';

  @override
  String get welcomeToLoby => 'مرحبًا بك في LOBY';

  @override
  String get onboardingWelcomeDescription => 'نص تجريبي: لوريم إيبسوم دولار سيت أميت، كونسيكتيتور أديبيسيسينغ إليت. يتم وضع نص تجريبي هنا.';

  @override
  String get letsStart => 'لنبدأ';

  @override
  String get skipLabel => 'تخطي';

  @override
  String get noMessagesYet => 'لا توجد رسائل بعد';

  @override
  String get startConversation => 'ابدأ المحادثة!';

  @override
  String get typeMessageHint => 'اكتب رسالة...';

  @override
  String get messageCannotBeEmpty => 'لا يمكن أن تكون الرسالة فارغة';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get yourNotifications => 'إشعاراتك';

  @override
  String get noNotificationsYet => 'لا توجد لديك أي إشعارات الآن';

  @override
  String get notificationTitle => 'إشعار';

  @override
  String get notificationName => 'اسم الإشعار';

  @override
  String get hello => 'مرحبًا';

  @override
  String get reservationCompletedMessage => 'تم إكمال حجز الاستوديو الخاص بك بنجاح!';
}
