// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Luby';

  @override
  String get selectLanguageTitle => 'Select your language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonOpenSettings => 'Open Settings';

  @override
  String get commonErrorGeneric => 'Something went wrong!';

  @override
  String get commonNoItems => 'No Added Items Here...';

  @override
  String get commonSelectRole => 'Select Your Role Now!';

  @override
  String get formFillRequired => 'Please fill all required fields';

  @override
  String get messageSentSuccessfully => 'Message sent successfully';

  @override
  String get redirectingToRegistration => 'Redirecting to registration...';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get resetPasswordButton => 'Reset Password';

  @override
  String get verifyEmailTitle => 'Verify Email';

  @override
  String get sendVerificationEmailButton => 'Send Verification Email';

  @override
  String get confirmButton => 'Confirm';

  @override
  String permissionRequiredTitle(String permission) {
    return '$permission permission required';
  }

  @override
  String permissionRequiredBody(String permission, String purpose) {
    return 'The app needs $permission $purpose. Please grant the permission in app settings.';
  }

  @override
  String mediaMaxReached(int count) {
    return 'Maximum medias allowed is $count';
  }

  @override
  String imageSizeTooLarge(int size) {
    return 'Image is too large. Must be less than $size MB';
  }

  @override
  String get imagePickFailed => 'Failed to pick image';

  @override
  String get mustPickImageBeforeVideo => 'You must pick an image first before adding a video';

  @override
  String get onlyMp4Allowed => 'Only MP4 video is allowed';

  @override
  String get videoPickFailed => 'Failed to pick video';

  @override
  String get atLeastOneImageMustRemain => 'At least one image must remain';

  @override
  String get cannotRemoveFirstImage => 'Cannot remove the first image as it is the only one';

  @override
  String get filePickFailed => 'Failed to pick file';

  @override
  String fileTooLarge(int size) {
    return 'File is too large. Must be less than $size MB';
  }

  @override
  String get errorPickingImage => 'An error occurred while picking the image';

  @override
  String someImagesIgnoredOver(int size) {
    return 'Some images over $size MB were ignored';
  }

  @override
  String get errorPickingImages => 'An error occurred while picking images';

  @override
  String get errorPickingFile => 'An error occurred while picking the file';

  @override
  String videoTooLarge(int size) {
    return 'Video is too large. Must be less than $size MB';
  }

  @override
  String get errorPickingVideo => 'An error occurred while picking the video';

  @override
  String get activityUpdatedSuccess => 'Activity updated successfully';

  @override
  String get cardDetailsAddedSuccessfully => 'Card details added successfully';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String checkInLabel(String date) {
    return 'Check in - $date';
  }

  @override
  String checkOutLabel(String date) {
    return 'Check out - $date';
  }

  @override
  String priceWithCurrency(num price, String currency) {
    return 'Price : $price $currency';
  }

  @override
  String get currencySar => 'SAR';

  @override
  String get pleaseAgreeToTerms => 'Please agree to the terms and conditions';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get onlyJpgOrPngAllowed => 'Please select JPG or PNG image only';

  @override
  String get conversationTitle => 'Your Conversations';

  @override
  String get searchHint => 'Search...';

  @override
  String get deleteConversationTitle => 'Delete Conversation';

  @override
  String deleteConversationContent(String name) {
    return 'Are you sure you want to delete the conversation with $name?';
  }

  @override
  String get conversationDeletedSuccessfully => 'Conversation deleted successfully';

  @override
  String get conversationDeleteError => 'An error occurred while deleting the conversation';

  @override
  String get commonDelete => 'Delete';

  @override
  String get activityDeletedSuccessfully => 'Activity Deleted Successfully';

  @override
  String get deletePropertyTitle => 'Delete Property';

  @override
  String get deletePropertyContent => 'Are you sure you want to delete this property?';

  @override
  String get guestUser => 'Guest User';

  @override
  String get welcomeToOurApp => 'Welcome to our App';

  @override
  String get start => 'Start';

  @override
  String get yourProperties => 'Your properties';

  @override
  String get yourActivities => 'Your activities';

  @override
  String get beVendorNow => 'Be a vendor now !';

  @override
  String get appCommission => 'App Commission';

  @override
  String get commissionDetails =>
      'The first party\'s commission for every reservation made by the second party is 14% of the rent (not including value added tax).';

  @override
  String get emailNotVerifiedMsg => 'Your email is not verified please wait until it is verified then try again.';

  @override
  String get account => 'Account';

  @override
  String get accountInfo => 'Account info';

  @override
  String get save => 'Save';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get areYouSureDeleteAccount => 'Are you sure about deleting your account?';

  @override
  String get yes => 'Yes';

  @override
  String get signUp => 'Sign Up';

  @override
  String get createYourAccount => 'Create your account to continue using the app ';

  @override
  String get agreeToTerms => 'Agree to the terms and conditions';

  @override
  String get comingSoon => 'Coming Soon...';

  @override
  String get rateApp => 'Rate App';

  @override
  String get inviteFriends => 'Invite Friends';

  @override
  String get noConversationsYet => 'You don\'t have any conversation yet';

  @override
  String get toFunctionProperly => 'to function properly';

  @override
  String get continueAsGuest => 'Continue as Guest';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get loginIntro => 'Please enter your email and password to sign in to your account.';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get signIn => 'Sign In';

  @override
  String get createAccount => 'Create Account';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithFacebook => 'Continue with Facebook';

  @override
  String get yourName => 'Your Name';

  @override
  String get language => 'Language';

  @override
  String get yourAccount => 'Your Account';

  @override
  String get wallet => 'Wallet';

  @override
  String get hostWithUs => 'Host With Us';

  @override
  String get aboutLoby => 'About Loby';

  @override
  String get termsAndConditions => 'Terms and Conditions';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get pleaseSelectValidAddress => 'Please select a valid address from the Map';

  @override
  String get enterActivityInfo => 'Please enter your activity information';

  @override
  String get nameOfActivity => 'Name of activity';

  @override
  String get enterActivityName => 'Enter your activity name';

  @override
  String get uploadStudioPhotosOrVideo => 'Upload studio photos or video';

  @override
  String get activityTimeLabel => 'Activity time';

  @override
  String get enterActivityTime => 'Enter Activity time';

  @override
  String get pleaseEnterActivityTime => 'Please enter the Activity time';

  @override
  String hoursHint(String count) {
    return '$count hours';
  }

  @override
  String get maximumGuests => 'Maximum Guests';

  @override
  String get enterMaxGuests => 'Enter Max Guests';

  @override
  String get pleaseEnterMaxGuests => 'Please enter the maximum guest number';

  @override
  String get priceLabel => 'Price';

  @override
  String get enterPrice => 'Enter Price';

  @override
  String get pleaseEnterPrice => 'Please enter the Price';

  @override
  String get update => 'Update';

  @override
  String get propertyUpdatedSuccessfully => 'Property updated successfully';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email';

  @override
  String get email => 'Email';

  @override
  String get pleaseCompleteInformation => 'Please complete the following\ninformation';

  @override
  String get enterPropertyInfo => 'Please enter your property information';

  @override
  String get pleaseSelectAddressOnMap => 'Please select the address on the map';

  @override
  String get pleaseUploadAtLeastOneImage => 'Please upload at least one image';

  @override
  String get propertyCreatedSuccessfully => 'Property created successfully';

  @override
  String get addSomeDetails => 'Add Some details';

  @override
  String get addDetails => 'Add Details';

  @override
  String get pleaseEnterYourDetails => 'Please enter your Details';

  @override
  String get tellGuestsWhatPlaceOffers => 'Tell guests what your place has to offer';

  @override
  String get uploadStudioPhotosOrVideoAlt => 'studio photos or video';

  @override
  String get uploadLeaseOrOwnershipContract => 'Upload Lease or ownership contract';

  @override
  String get leaseOrOwnershipContract => 'Lease or ownership contract';

  @override
  String get uploadTouristFacilityLicense => 'Upload Tourist hospitality facility license';

  @override
  String get touristFacilityLicense => 'Tourist hospitality facility license';

  @override
  String get optional => '( optional )';

  @override
  String get availableDateRange => 'Available date range';

  @override
  String startDateLabel(String date) {
    return 'Start Date:   $date';
  }

  @override
  String endDateLabel(String date) {
    return 'End Date:   $date';
  }

  @override
  String get add => 'Add';

  @override
  String get lobyPlatformUsageAgreement => 'Loby Platform Usage Agreement';

  @override
  String get address => 'Address';

  @override
  String get enterYourAddressOrTapMap => 'Enter your address or tap map icon to select';

  @override
  String get pleaseEnterYourAddress => 'Please enter your address';

  @override
  String get addSomeDetailsLabel => 'Add Some details';

  @override
  String get addDetailsHint => 'Add Details';

  @override
  String get pleaseEnterSomeDetails => 'Please enter some details';

  @override
  String get tellGuestsOffers => 'Tell guests what your place has to offer';

  @override
  String get dateLabel => 'Date';

  @override
  String get timeLabel => 'Time';

  @override
  String get yyyyMMdd => 'yyyy-MM-dd';

  @override
  String get hhmm => 'HH:MM';

  @override
  String get pricePerPersonHint => 'Enter price per person';

  @override
  String get pricePerPerson => 'Price per person';

  @override
  String get guestNumber => 'Guest Number';

  @override
  String get enterMaxGuestNumber => 'Enter Maximum Guest Number';

  @override
  String pleaseEnterField(String field) {
    return 'Please enter $field';
  }

  @override
  String enterOtpSentTo(String email) {
    return 'Enter the OTP sent to $email';
  }

  @override
  String get otp => 'OTP';

  @override
  String get pleaseEnterValidOtp => 'Please enter a valid OTP';

  @override
  String get newPassword => 'New Password';

  @override
  String get pleaseEnterNewPassword => 'Please enter new password';

  @override
  String get passwordAtLeastSix => 'Password must be at least 6 characters';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get pleaseConfirmYourPassword => 'Please confirm your password';

  @override
  String get vendorPleaseChoose => 'Please choose';

  @override
  String get vendorPropertyOwner => 'Property owner';

  @override
  String get vendorTouristActivity => 'Tourist activity';

  @override
  String get navHome => 'Home';

  @override
  String get navBookings => 'Bookings';

  @override
  String get navMessages => 'Messages';

  @override
  String get navProfile => 'Profile';

  @override
  String get vendorIntroText =>
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Hendrerit tristique lorem ipsum dolor sit amet.\nDiam habitant.';

  @override
  String availabilityQuestion(String type) {
    return 'Are your $type available?';
  }

  @override
  String get availableLabel => 'Available';

  @override
  String get notAvailableLabel => 'Not Available';

  @override
  String get enterPricePerNight => 'Enter price per night';

  @override
  String get continueLabel => 'Continue';

  @override
  String get searchLocation => 'Search location';

  @override
  String get lobbyOffersTitle => 'Lobby Offers';

  @override
  String get lobbyOffersDescription =>
      'If you add from one apartment to 10, the percentage is 10% - from 0 to 20, the percentage is 15% - more than 25, the percentage is 20%';

  @override
  String get imageLabel => 'Image';

  @override
  String get videoLabel => 'Video';

  @override
  String uploadAtLeastOneImageWithMax(int count) {
    return 'Upload at least one image (max $count medias)';
  }

  @override
  String get selectedLocation => 'Selected Location';

  @override
  String get gettingAddress => 'Getting address...';

  @override
  String get dragToSelectLocation => 'Drag to select location';

  @override
  String get useCurrentLocation => 'Use Current Location';

  @override
  String get updateAddress => 'Update Address';

  @override
  String get confirmLocation => 'Confirm Location';

  @override
  String get shareSomeBasics => 'Share some basics about your place';

  @override
  String get bedrooms => 'Bedrooms';

  @override
  String get beds => 'Beds';

  @override
  String get bathrooms => 'Bathrooms';

  @override
  String get addNewTagTitle => 'Add a new tag';

  @override
  String get enterTagNameHint => 'Enter tag name';

  @override
  String get commonAdd => 'Add';

  @override
  String get addOtherThings => 'Add other things';

  @override
  String get reservationTitle => 'Reservation';

  @override
  String get currentReservations => 'Current Reservations';

  @override
  String get lastReservations => 'Last Reservations';

  @override
  String get noReservationsFound => 'No Reservations found';

  @override
  String get dateLabelInline => 'Date';

  @override
  String get checkOutInline => 'Check Out';

  @override
  String get viewReservationDetails => 'View Reservation Details';

  @override
  String get clientName => 'Client Name';

  @override
  String reservationNumberLabel(String number) {
    return 'Reservation Number $number';
  }

  @override
  String lastNumberLabel(String number) {
    return 'Last Number $number';
  }

  @override
  String freeCancellationBefore(String date) {
    return 'Free cancellation before $date';
  }

  @override
  String get orderDetails => 'Order details';

  @override
  String get summary => 'Summary';

  @override
  String get commonAccept => 'Accept';

  @override
  String get commonRefuse => 'Refuse';

  @override
  String get noteClientPaidFees => 'Note: The client has paid the fees';

  @override
  String get viewReservationSummary => 'View reservation summary';

  @override
  String personCount(int count) {
    return '$count person';
  }

  @override
  String get availableBalance => 'Available balance';

  @override
  String billCodeLabel(String code) {
    return 'Bill code : $code';
  }

  @override
  String get totalPriceLabel => 'Total Price :';

  @override
  String get billDetails => 'Bill Details';

  @override
  String get welcomeToLoby => 'Welcome to LOBY';

  @override
  String get onboardingWelcomeDescription =>
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut hendrerit tristique gravida felis, sociis in felis.';

  @override
  String get letsStart => 'Let\'s Start';

  @override
  String get skipLabel => 'Skip';

  @override
  String get noMessagesYet => 'No messages yet';

  @override
  String get startConversation => 'Start the conversation!';

  @override
  String get typeMessageHint => 'Type a message...';

  @override
  String get messageCannotBeEmpty => 'Message can\'t be empty';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get yourNotifications => 'Your Notifications';

  @override
  String get noNotificationsYet => 'You don\'t have any notifications right now';

  @override
  String get notificationTitle => 'Notification';

  @override
  String get notificationName => 'Notification Name';

  @override
  String get hello => 'Hello';

  @override
  String get reservationCompletedMessage => 'Your studio reservation has been successfully completed!';
}
