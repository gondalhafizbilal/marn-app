import 'package:flutter/widgets.dart';

class AppStrings {
  const AppStrings._(this.languageCode);

  static const en = AppStrings._('en');
  static const ar = AppStrings._('ar');

  final String languageCode;

  bool get isArabic => languageCode == 'ar';

  static AppStrings of(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return locale == 'ar' ? ar : en;
  }

  String _t(String english, String arabic) => isArabic ? arabic : english;

  String get appName => 'Marn';
  String get appTagline => _t(
    'A blue marketplace for families, agencies, and services.',
    'سوق مرن للعائلات والوكالات والخدمات.',
  );

  String get english => 'English';
  String get arabic => 'العربية';
  String get switchToEnglish => 'English';
  String get switchToArabic => 'العربية';
  String get loading => _t('Loading...', 'جار التحميل...');
  String get saving => _t('Saving...', 'جار الحفظ...');
  String get updating => _t('Updating...', 'جار التحديث...');
  String get submitting => _t('Submitting...', 'جار الإرسال...');
  String get posting => _t('Posting...', 'جار النشر...');
  String get search => _t('Search', 'بحث');
  String get filters => _t('Filters', 'الفلاتر');
  String get all => _t('All', 'الكل');
  String get categories => _t('Categories', 'الفئات');
  String get recommended => _t('Recommended', 'موصى به');
  String get featured => _t('Featured', 'مميز');
  String get rating => _t('Rating', 'التقييم');
  String get jobs => _t('Jobs', 'الوظائف');
  String get openRequests => _t('Open requests', 'الطلبات المفتوحة');
  String get requests => _t('Requests', 'الطلبات');
  String get ads => _t('Ads', 'الإعلانات');
  String get views => _t('views', 'مشاهدات');

  String get navHome => _t('Home', 'الرئيسية');
  String get navWishlist => _t('Wishlist', 'المفضلة');
  String get navRequests => _t('Requests', 'الطلبات');
  String get navPostAd => _t('Post Ad', 'أضف إعلان');
  String get navProfile => _t('Profile', 'الملف');
  String get aiChatbot => _t('AI Chatbot', 'مساعد مرن');

  String get loginTitle => _t('Enter your phone number', 'أدخل رقم هاتفك');
  String get loginSubtitle => _t(
    'We’ll use this to sign you in or to create an\naccount if don’t have one yet.',
    'سنستخدمه لتسجيل دخولك أو إنشاء حساب إذا لم يكن لديك حساب بعد.',
  );
  String get phoneNumber => _t('Phone number', 'رقم الهاتف');
  String get sending => _t('Sending...', 'جار الإرسال...');
  String get signIn => _t('Sign in', 'تسجيل الدخول');
  String get termsAndConditions => _t('Terms & Conditions', 'الشروط والأحكام');
  String get or => _t('Or', 'أو');
  String get continueText => _t('Continue', 'متابعة');
  String get continueAsGuest => _t('Continue as guest', 'المتابعة كضيف');
  String get createNewAccount => _t('Create a new account', 'إنشاء حساب جديد');
  String get registerTitle => _t('Welcome Back !', 'مرحباً بعودتك!');
  String get registerSubtitle => _t(
    'Sign in with your email and password\nor social media to continue',
    'أضف بياناتك مرة واحدة واستخدمها في الحجوزات والإعلانات والطلبات.',
  );
  String get name => _t('Name', 'الاسم');
  String get enterYourName => _t('Enter your name', 'أدخل اسمك');
  String get fullName => _t('Full name', 'الاسم الكامل');
  String get email => _t('Email', 'البريد الإلكتروني');
  String get emailOptional =>
      _t('Email (Optional)', 'البريد الإلكتروني (اختياري)');
  String get contactNumber => _t('Contact Number', 'رقم التواصل');
  String get gender => _t('Gender', 'الجنس');
  String get maleFemale => _t('Male/female', 'ذكر/أنثى');
  String get createAccount => _t('Create account', 'إنشاء الحساب');
  String get creating => _t('Creating...', 'جار الإنشاء...');
  String get save => _t('Save', 'حفظ');
  String get haveAccount => _t('Already have an account?', 'لديك حساب بالفعل؟');
  String get verifyTitle => _t('Enter Verification Code', 'أدخل رمز التحقق');
  String get verifySubtitle => _t(
    'Please enter 4 digit verification that have been\nsent to your Whatsapp.',
    'أدخل رمز التحقق الذي أرسلناه إلى هاتفك.',
  );
  String get otpCode => _t('OTP code', 'رمز التحقق');
  String get verifyCode => _t('Verify code', 'تحقق من الرمز');
  String get verifying => _t('Verifying...', 'جار التحقق...');
  String get verify => _t('Verify', 'تحقق');
  String get changeNumber => _t('Change number', 'تغيير الرقم');
  String get dontReceiveCode => _t('Don’t receive code ?', 'لم تستلم الرمز؟');
  String get resendCode => _t('Resend code', 'إعادة إرسال الرمز');

  String get languageTitle => _t('Choose language', 'اختر اللغة');
  String get languageSubtitle => _t(
    'Select your preferred app language.',
    'حدد لغة التطبيق المفضلة لديك.',
  );
  String get continueButton => _t('Continue', 'متابعة');

  String get onboardingSemanticsSkipAds => _t('Skip ads', 'تخطي الإعلانات');
  String get onboardingPostDiscover =>
      _t('Post and discover ads', 'انشر واكتشف الإعلانات');
  String get onboardingPostDiscoverSubtitle => _t(
    'Find the right household help, services, and offers quickly.',
    'اعثر بسرعة على المساعدة المنزلية والخدمات والعروض المناسبة.',
  );
  String get onboardingCompare =>
      _t('Compare trusted providers', 'قارن بين مزودي الخدمة الموثوقين');
  String get onboardingCompareSubtitle => _t(
    'Review profiles, packages, ratings, and request details.',
    'راجع الملفات والباقات والتقييمات وتفاصيل الطلب.',
  );
  String get onboardingBook => _t('Book with confidence', 'احجز بثقة');
  String get onboardingBookSubtitle => _t(
    'Track requests, payments, chats, and reviews in one app.',
    'تابع الطلبات والمدفوعات والمحادثات والتقييمات في تطبيق واحد.',
  );

  String get location => _t('Location', 'الموقع');
  String get setLocation => _t('Set your location', 'حدد موقعك');
  String get setLocationSubtitle => _t(
    'Marn uses your location to rank nearby services and agencies.',
    'يستخدم مرن موقعك لترتيب الخدمات والوكالات القريبة.',
  );
  String get useCurrentLocation =>
      _t('Use current location', 'استخدم الموقع الحالي');
  String get useCurrentLocationSubtitle =>
      _t('Detect your area automatically.', 'اكتشف منطقتك تلقائياً.');
  String get chooseOnMap => _t('Choose on map', 'اختر على الخريطة');
  String get chooseOnMapSubtitle => _t(
    'Pin your preferred service area manually.',
    'حدد منطقة الخدمة المفضلة يدوياً.',
  );
  String get skipForNow => _t('Skip for now', 'تخطي الآن');
  String get chooseLocation => _t('Choose location', 'اختر الموقع');
  String get searchLocation => _t('Search Location', 'ابحث عن موقع');
  String get locationDetails => _t('Location Details', 'تفاصيل الموقع');
  String get currentLocation => _t('Current location', 'الموقع الحالي');
  String get selectedLocation => _t('Selected location', 'الموقع المحدد');
  String get confirmLocation => _t('Confirm location', 'تأكيد الموقع');
  String get updateLocation => _t('Update location', 'تحديث الموقع');
  String get dohaQatar => _t('Doha, Qatar', 'الدوحة، قطر');
  String get alSaddDoha => _t('Al Sadd, Doha', 'السد، الدوحة');
  String get sampleAddress => _t(
    'Jl. Jend. Sudirman, Gowongan, Kec. Jetis, Kota Yogyakarta',
    'شارع جند سوديرمان، غووونغان، جيتيس، يوجياكارتا',
  );

  String get noHomeData =>
      _t('No home data loaded yet.', 'لم يتم تحميل بيانات الرئيسية بعد.');
  String get homePromoTitle => _t(
    'Connecting homes\nwith trusted workers',
    'نصل المنازل\nبعمال موثوقين',
  );
  String get homePromoSubtitle =>
      _t('*Early bird discounts available', '*خصومات الحجز المبكر متاحة');
  String get services => _t('Services', 'الخدمات');
  String serviceTitle(String id, String fallback) {
    return switch (id) {
      'housemaids' => _t('Housemaids', 'عاملات منزلية'),
      'housemaids-local' => _t('Housemaids Local', 'عاملات محليات'),
      'hajj-umrah' => _t('Hajj & Umrah', 'الحج والعمرة'),
      'events' => _t('Event Services', 'خدمات الفعاليات'),
      'advertisements' => _t('Advertisements', 'الإعلانات'),
      'services' => _t('Services', 'الخدمات'),
      'home-projects' => _t('Home Projects', 'مشاريع المنزل'),
      'laundry' => _t('Laundry', 'المغسلة'),
      'car-service' => _t('Car Service', 'خدمة السيارات'),
      _ => fallback,
    };
  }

  String get browse => _t('Browse', 'تصفح');
  String get browseSubtitle => _t(
    'Explore categories and recommended providers.',
    'استكشف الفئات ومزودي الخدمة الموصى بهم.',
  );
  String get noBrowseData =>
      _t('No browse data loaded yet.', 'لم يتم تحميل بيانات التصفح بعد.');
  String get noCategoriesLoaded =>
      _t('No categories loaded yet.', 'لم يتم تحميل الفئات بعد.');
  String get searchServicesHint => _t(
    'Search services, agencies, ads',
    'ابحث عن خدمات أو وكالات أو إعلانات',
  );
  String get filtersSubtitle => _t(
    'Availability, rating, location, and price.',
    'التوفر والتقييم والموقع والسعر.',
  );
  String get searchTitle => _t('Search', 'بحث');
  String get searchSubtitle => _t(
    'Search across providers, ads, and categories.',
    'ابحث بين مزودي الخدمة والإعلانات والفئات.',
  );
  String get searchHint =>
      _t('Try housemaid or laundry', 'جرّب عاملة منزلية أو مغسلة');
  String get recentSearch => _t('Recent search', 'بحث حديث');
  String get recentSearchSubtitle =>
      _t('Housemaids near West Bay', 'عاملات منزليات بالقرب من الخليج الغربي');
  String get suggestedSearch => _t('Suggested search', 'بحث مقترح');
  String get suggestedSearchSubtitle =>
      _t('Event staff available today', 'طاقم فعاليات متاح اليوم');
  String get searchResults => _t('Search results', 'نتائج البحث');
  String get allResults => _t('All results', 'كل النتائج');
  String resultsFor(String query) =>
      _t('Results for "$query"', 'نتائج "$query"');
  String get noMatchingResults =>
      _t('No matching results.', 'لا توجد نتائج مطابقة.');
  String get filterResults => _t('Filter results', 'تصفية النتائج');
  String get filterResultsSubtitle =>
      _t('Refine your marketplace search.', 'حسّن بحثك في السوق.');
  String get filtersPageSubtitle => _t(
    'Tune browse results without mixing filter state into browse UI.',
    'عدّل نتائج التصفح دون خلط حالة الفلاتر مع واجهة التصفح.',
  );
  String get applyFilters => _t('Apply filters', 'تطبيق الفلاتر');
  String browseCategoryTitle(String id, String fallback) {
    return switch (id) {
      'housemaids' => _t('Housemaids', 'عاملات منزلية'),
      'travel' => _t('Travel', 'السفر'),
      'events' => _t('Events', 'الفعاليات'),
      'services' => _t('Services', 'الخدمات'),
      _ => fallback,
    };
  }

  String browseCategorySubtitle(String id, String fallback) {
    return switch (id) {
      'housemaids' => _t(
        'Local and agency workers',
        'عاملات محليات ومن وكالات',
      ),
      'travel' => _t('Tours, tickets, and transport', 'رحلات وتذاكر وتنقلات'),
      'events' => _t('Staffing and event services', 'طاقم وخدمات الفعاليات'),
      'services' => _t(
        'Laundry, car, and home services',
        'مغسلة وسيارات وخدمات منزلية',
      ),
      _ => fallback,
    };
  }

  String filterOption(String id, String fallback) {
    return switch (id) {
      'nearby' => _t('Nearby', 'قريب'),
      'verified' => _t('Verified', 'موثق'),
      'available' => _t('Available today', 'متاح اليوم'),
      'top-rated' => _t('Top rated', 'الأعلى تقييماً'),
      'with-offers' => _t('With offers', 'مع عروض'),
      _ => fallback,
    };
  }

  String get booking => _t('Booking', 'الحجز');
  String get bookingSubtitle => _t(
    'Confirm the provider, service window, and payment.',
    'أكد مزود الخدمة ووقت الخدمة والدفع.',
  );
  String get selectedBookingDates =>
      _t('Selected booking dates', 'تواريخ الحجز المحددة');
  String get estimatedTotal => _t('Estimated total', 'الإجمالي المتوقع');
  String get continueToPayment =>
      _t('Continue to payment', 'المتابعة إلى الدفع');
  String get paymentComplete => _t('Payment complete', 'اكتمل الدفع');
  String get checkout => _t('Checkout', 'الدفع');
  String get paymentSubtitle => _t(
    'Payment summary and saved methods.',
    'ملخص الدفع وطرق الدفع المحفوظة.',
  );
  String get totalDueIncludingFee => _t(
    'Total due including service fee.',
    'الإجمالي المستحق شامل رسوم الخدمة.',
  );
  String get serviceAmount => _t('Service amount', 'مبلغ الخدمة');
  String get marnServiceFee => _t('Marn service fee', 'رسوم خدمة مرن');
  String get payNow => _t('Pay now', 'ادفع الآن');
  String get paid => _t('Paid', 'تم الدفع');
  String payAmount(String amount) => _t('Pay $amount', 'ادفع $amount');
  String paymentMethodTitle(String id, String fallback) {
    return switch (id) {
      'card' => _t('Visa ending 4242', 'فيزا تنتهي بـ 4242'),
      'apple-pay' => _t('Apple Pay', 'Apple Pay'),
      _ => fallback,
    };
  }

  String paymentMethodSubtitle(String id, String fallback) {
    return switch (id) {
      'card' => _t('Default card', 'البطاقة الافتراضية'),
      'apple-pay' => _t('Pay securely with wallet', 'ادفع بأمان عبر المحفظة'),
      _ => fallback,
    };
  }

  String get notifications => _t('Notifications', 'الإشعارات');
  String get notificationsSubtitle => _t(
    'Request updates, payment receipts, and account activity.',
    'تحديثات الطلبات وإيصالات الدفع ونشاط الحساب.',
  );
  String get noNotifications =>
      _t('No notifications yet.', 'لا توجد إشعارات بعد.');
  String get individualProfile => _t('Individual profile', 'ملف فردي');
  String get loadingProfileDetails =>
      _t('Loading profile details.', 'جار تحميل تفاصيل الملف.');
  String get profileNotFound => _t('Profile not found.', 'الملف غير موجود.');
  String get requestBooking => _t('Request booking', 'طلب حجز');
  String get readReviews => _t('Read reviews', 'قراءة التقييمات');
  String get agencyProfile => _t('Agency profile', 'ملف الوكالة');
  String get loadingAgencyDetails =>
      _t('Loading agency details.', 'جار تحميل تفاصيل الوكالة.');
  String get agencyNotFound => _t('Agency not found.', 'الوكالة غير موجودة.');
  String get sendRequest => _t('Send request', 'إرسال طلب');
  String get advertisement => _t('Advertisement', 'إعلان');
  String get loadingAdDetails =>
      _t('Loading ad details.', 'جار تحميل تفاصيل الإعلان.');
  String get adNotFound => _t('Ad not found.', 'الإعلان غير موجود.');
  String get contactAdvertiser => _t('Contact advertiser', 'تواصل مع المعلن');
  String get contactAdvertiserSubtitle => _t(
    'Open chat and ask for availability.',
    'افتح المحادثة واسأل عن التوفر.',
  );
  String get reserveAndPay => _t('Reserve and pay', 'احجز وادفع');
  String get reserveAndPaySubtitle => _t(
    'Continue to checkout for this service.',
    'تابع إلى الدفع لهذه الخدمة.',
  );

  String get postAd => _t('Post an ad', 'أضف إعلان');
  String get postAdSubtitle => _t(
    'Create a marketplace ad with its own draft state.',
    'أنشئ إعلاناً في السوق مع حفظ المسودة.',
  );
  String get category => _t('Category', 'الفئة');
  String get title => _t('Title', 'العنوان');
  String get description => _t('Description', 'الوصف');
  String get price => _t('Price', 'السعر');

  String get profile => _t('Profile', 'الملف الشخصي');
  String get manageAccount =>
      _t('Manage your account and activity.', 'إدارة حسابك ونشاطك.');
  String get profileNotLoaded =>
      _t('Profile not loaded.', 'لم يتم تحميل الملف الشخصي.');
  String get editProfile => _t('Edit profile', 'تعديل الملف الشخصي');
  String get editProfileSubtitle => _t(
    'Name, contact details, and media.',
    'الاسم وبيانات التواصل والوسائط.',
  );
  String get myAds => _t('My ads', 'إعلاناتي');
  String get myAdsSubtitle =>
      _t('Manage active and pending ads.', 'إدارة الإعلانات النشطة والمعلقة.');
  String get myAdsPageSubtitle => _t(
    'Create, renew, and manage marketplace ads.',
    'أنشئ وجدد وأدر إعلانات السوق.',
  );
  String get payments => _t('Payments', 'المدفوعات');
  String get paymentsSubtitle =>
      _t('Receipts and package purchases.', 'الإيصالات وشراء الباقات.');
  String get settings => _t('Settings', 'الإعدادات');
  String get settingsSubtitle =>
      _t('Notifications, security, and language.', 'الإشعارات والأمان واللغة.');
  String get settingsPageSubtitle => _t(
    'Security, notifications, language, and account controls.',
    'الأمان والإشعارات واللغة وإعدادات الحساب.',
  );
  String get notificationSettings =>
      _t('Notification settings', 'إعدادات الإشعارات');
  String get notificationSettingsSubtitle => _t(
    'Push, email, and request updates.',
    'التنبيهات والبريد وتحديثات الطلبات.',
  );
  String get changePassword => _t('Change password', 'تغيير كلمة المرور');
  String get changePasswordSubtitle =>
      _t('Update account credentials.', 'حدّث بيانات الدخول.');
  String get deleteAccount => _t('Delete account', 'حذف الحساب');
  String get deleteAccountSubtitle => _t(
    'Remove account and personal data.',
    'إزالة الحساب والبيانات الشخصية.',
  );
  String get editProfilePageSubtitle => _t(
    'Keep profile logic out of the profile dashboard.',
    'تعديل بياناتك الأساسية بعيداً عن لوحة الملف.',
  );
  String get phone => _t('Phone', 'الهاتف');
  String get saveChanges => _t('Save changes', 'حفظ التغييرات');
  String get noAdsYet => _t('No ads yet.', 'لا توجد إعلانات بعد.');
  String get paymentHistory => _t('Payment history', 'سجل المدفوعات');
  String get paymentHistorySubtitle => _t(
    'Receipts, subscriptions, and checkout activity.',
    'الإيصالات والاشتراكات ونشاط الدفع.',
  );
  String get noPaymentsYet => _t('No payments yet.', 'لا توجد مدفوعات بعد.');
  String adViews(String status, int views) {
    return _t('$status • $views views', '$status • $views مشاهدة');
  }

  String get requestPreview => _t('Request preview', 'معاينة الطلب');
  String get reviewRequestDetails =>
      _t('Review request details.', 'راجع تفاصيل الطلب.');
  String get requestPreviewNotFound =>
      _t('Request preview not found.', 'معاينة الطلب غير موجودة.');
  String get reserveProviderSubtitle => _t(
    'Reserve the provider and confirm the request.',
    'احجز مزود الخدمة وأكد الطلب.',
  );
  String get requestSubmitted => _t('Request submitted', 'تم إرسال الطلب');
  String get requestSubmittedSubtitle => _t(
    'Your request is now visible to matching providers.',
    'أصبح طلبك ظاهراً لمزودي الخدمة المناسبين.',
  );
  String get matchingProviders =>
      _t('We are matching providers', 'نبحث عن مزودي خدمة مناسبين');
  String get matchingProvidersSubtitle => _t(
    'You will receive updates in notifications and requests.',
    'ستصلك التحديثات في الإشعارات والطلبات.',
  );
  String get backToRequests => _t('Back to requests', 'العودة إلى الطلبات');
  String get requestsSubtitle => _t(
    'Track active, pending, and completed requests.',
    'تابع الطلبات النشطة والمعلقة والمكتملة.',
  );
  String get noRequestsYet => _t('No requests yet.', 'لا توجد طلبات بعد.');
  String get submitRequest => _t('Submit request', 'إرسال الطلب');
  String get submitRequestSubtitle => _t(
    'Tell agencies what you need and where you need it.',
    'أخبر الوكالات بما تحتاجه وأين تحتاجه.',
  );
  String get requestTitle => _t('Request title', 'عنوان الطلب');
  String get requestCategory => _t('Request category', 'فئة الطلب');
  String get preferredDate => _t('Preferred date', 'التاريخ المفضل');
  String get requestNotes => _t('Notes', 'ملاحظات');

  String get reviews => _t('Reviews', 'التقييمات');
  String get reviewsSubtitle => _t(
    'Provider feedback from completed requests.',
    'آراء العملاء بعد الطلبات المكتملة.',
  );
  String get noReviewsYet => _t('No reviews yet.', 'لا توجد تقييمات بعد.');
  String get writeReview => _t('Write review', 'اكتب تقييماً');
  String get writeReviewSubtitle => _t(
    'Rate your completed service experience.',
    'قيّم تجربة الخدمة المكتملة.',
  );
  String get ratingLabel => _t('Rating', 'التقييم');
  String stars(int count) => count == 1
      ? _t('1 star', 'نجمة واحدة')
      : _t('$count stars', '$count نجوم');
  String get review => _t('Review', 'التقييم');
  String get submitReview => _t('Submit review', 'إرسال التقييم');

  String get wishlist => _t('Wishlist', 'المفضلة');
  String get wishlistSubtitle =>
      _t('Saved providers and ads.', 'مزودو الخدمة والإعلانات المحفوظة.');
  String get noWishlistYet =>
      _t('No saved items yet.', 'لا توجد عناصر محفوظة بعد.');
  String get savedItem => _t('Saved item', 'عنصر محفوظ');
  String get loadingSavedItem =>
      _t('Loading saved item.', 'جار تحميل العنصر المحفوظ.');
  String get savedItemNotFound =>
      _t('Saved item not found.', 'العنصر المحفوظ غير موجود.');
  String get openDetails => _t('Open details', 'فتح التفاصيل');
  String get openDetailsSubtitle => _t(
    'View the full profile and availability.',
    'اعرض الملف الكامل والتوفر.',
  );
  String get startChat => _t('Start chat', 'بدء محادثة');
  String get startChatSubtitle =>
      _t('Ask questions before booking.', 'اطرح الأسئلة قبل الحجز.');

  String get chatbotOnline => _t('Online', 'متصل');
  String get today => _t('Today', 'اليوم');
  String get writeYourMessage => _t('write your message', 'اكتب رسالتك');
  String get askMarn => _t('Ask Marn', 'اسأل مرن');
}

extension AppStringsX on BuildContext {
  AppStrings get strings => AppStrings.of(this);
}
