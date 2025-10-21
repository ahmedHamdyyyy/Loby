import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ar'), Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Luby'**
  String get appTitle;

  /// No description provided for @selectLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Select your language'**
  String get selectLanguageTitle;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get commonOpenSettings;

  /// No description provided for @commonErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get commonErrorGeneric;

  /// No description provided for @commonNoItems.
  ///
  /// In en, this message translates to:
  /// **'No Added Items Here...'**
  String get commonNoItems;

  /// No description provided for @commonSelectRole.
  ///
  /// In en, this message translates to:
  /// **'Select Your Role Now!'**
  String get commonSelectRole;

  /// No description provided for @formFillRequired.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get formFillRequired;

  /// No description provided for @messageSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully'**
  String get messageSentSuccessfully;

  /// No description provided for @redirectingToRegistration.
  ///
  /// In en, this message translates to:
  /// **'Redirecting to registration...'**
  String get redirectingToRegistration;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordButton;

  /// No description provided for @verifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmailTitle;

  /// No description provided for @sendVerificationEmailButton.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Email'**
  String get sendVerificationEmailButton;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// Dialog title shown when a permission is required.
  ///
  /// In en, this message translates to:
  /// **'{permission} permission required'**
  String permissionRequiredTitle(String permission);

  /// Dialog body explaining why permission is needed.
  ///
  /// In en, this message translates to:
  /// **'The app needs {permission} {purpose}. Please grant the permission in app settings.'**
  String permissionRequiredBody(String permission, String purpose);

  /// No description provided for @mediaMaxReached.
  ///
  /// In en, this message translates to:
  /// **'Maximum medias allowed is {count}'**
  String mediaMaxReached(int count);

  /// No description provided for @imageSizeTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Image is too large. Must be less than {size} MB'**
  String imageSizeTooLarge(int size);

  /// No description provided for @imagePickFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image'**
  String get imagePickFailed;

  /// No description provided for @mustPickImageBeforeVideo.
  ///
  /// In en, this message translates to:
  /// **'You must pick an image first before adding a video'**
  String get mustPickImageBeforeVideo;

  /// No description provided for @onlyMp4Allowed.
  ///
  /// In en, this message translates to:
  /// **'Only MP4 video is allowed'**
  String get onlyMp4Allowed;

  /// No description provided for @videoPickFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick video'**
  String get videoPickFailed;

  /// No description provided for @atLeastOneImageMustRemain.
  ///
  /// In en, this message translates to:
  /// **'At least one image must remain'**
  String get atLeastOneImageMustRemain;

  /// No description provided for @cannotRemoveFirstImage.
  ///
  /// In en, this message translates to:
  /// **'Cannot remove the first image as it is the only one'**
  String get cannotRemoveFirstImage;

  /// No description provided for @filePickFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick file'**
  String get filePickFailed;

  /// No description provided for @fileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'File is too large. Must be less than {size} MB'**
  String fileTooLarge(int size);

  /// No description provided for @errorPickingImage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while picking the image'**
  String get errorPickingImage;

  /// No description provided for @someImagesIgnoredOver.
  ///
  /// In en, this message translates to:
  /// **'Some images over {size} MB were ignored'**
  String someImagesIgnoredOver(int size);

  /// No description provided for @errorPickingImages.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while picking images'**
  String get errorPickingImages;

  /// No description provided for @errorPickingFile.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while picking the file'**
  String get errorPickingFile;

  /// No description provided for @videoTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Video is too large. Must be less than {size} MB'**
  String videoTooLarge(int size);

  /// No description provided for @errorPickingVideo.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while picking the video'**
  String get errorPickingVideo;

  /// No description provided for @activityUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Activity updated successfully'**
  String get activityUpdatedSuccess;

  /// No description provided for @cardDetailsAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Card details added successfully'**
  String get cardDetailsAddedSuccessfully;

  /// No description provided for @errorWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorWithMessage(String message);

  /// No description provided for @checkInLabel.
  ///
  /// In en, this message translates to:
  /// **'Check in - {date}'**
  String checkInLabel(String date);

  /// No description provided for @checkOutLabel.
  ///
  /// In en, this message translates to:
  /// **'Check out - {date}'**
  String checkOutLabel(String date);

  /// No description provided for @priceWithCurrency.
  ///
  /// In en, this message translates to:
  /// **'Price : {price} {currency}'**
  String priceWithCurrency(num price, String currency);

  /// No description provided for @currencySar.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get currencySar;

  /// No description provided for @pleaseAgreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the terms and conditions'**
  String get pleaseAgreeToTerms;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @onlyJpgOrPngAllowed.
  ///
  /// In en, this message translates to:
  /// **'Please select JPG or PNG image only'**
  String get onlyJpgOrPngAllowed;

  /// No description provided for @conversationTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Conversations'**
  String get conversationTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// No description provided for @deleteConversationTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Conversation'**
  String get deleteConversationTitle;

  /// No description provided for @deleteConversationContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the conversation with {name}?'**
  String deleteConversationContent(String name);

  /// No description provided for @conversationDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Conversation deleted successfully'**
  String get conversationDeletedSuccessfully;

  /// No description provided for @conversationDeleteError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deleting the conversation'**
  String get conversationDeleteError;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @activityDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Activity Deleted Successfully'**
  String get activityDeletedSuccessfully;

  /// No description provided for @deletePropertyTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Property'**
  String get deletePropertyTitle;

  /// No description provided for @deletePropertyContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this property?'**
  String get deletePropertyContent;

  /// No description provided for @guestUser.
  ///
  /// In en, this message translates to:
  /// **'Guest User'**
  String get guestUser;

  /// No description provided for @welcomeToOurApp.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our App'**
  String get welcomeToOurApp;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @yourProperties.
  ///
  /// In en, this message translates to:
  /// **'Your properties'**
  String get yourProperties;

  /// No description provided for @yourActivities.
  ///
  /// In en, this message translates to:
  /// **'Your activities'**
  String get yourActivities;

  /// No description provided for @beVendorNow.
  ///
  /// In en, this message translates to:
  /// **'Be a vendor now !'**
  String get beVendorNow;

  /// No description provided for @appCommission.
  ///
  /// In en, this message translates to:
  /// **'App Commission'**
  String get appCommission;

  /// No description provided for @commissionDetails.
  ///
  /// In en, this message translates to:
  /// **'The first party\'s commission for every reservation made by the second party is 14% of the rent (not including value added tax).'**
  String get commissionDetails;

  /// No description provided for @emailNotVerifiedMsg.
  ///
  /// In en, this message translates to:
  /// **'Your email is not verified please wait until it is verified then try again.'**
  String get emailNotVerifiedMsg;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @accountInfo.
  ///
  /// In en, this message translates to:
  /// **'Account info'**
  String get accountInfo;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @areYouSureDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure about deleting your account?'**
  String get areYouSureDeleteAccount;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @createYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account to continue using the app '**
  String get createYourAccount;

  /// No description provided for @agreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'Agree to the terms and conditions'**
  String get agreeToTerms;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon...'**
  String get comingSoon;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @inviteFriends.
  ///
  /// In en, this message translates to:
  /// **'Invite Friends'**
  String get inviteFriends;

  /// No description provided for @noConversationsYet.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any conversation yet'**
  String get noConversationsYet;

  /// No description provided for @toFunctionProperly.
  ///
  /// In en, this message translates to:
  /// **'to function properly'**
  String get toFunctionProperly;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continueAsGuest;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @loginIntro.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password to sign in to your account.'**
  String get loginIntro;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get continueWithFacebook;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get yourName;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @yourAccount.
  ///
  /// In en, this message translates to:
  /// **'Your Account'**
  String get yourAccount;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @hostWithUs.
  ///
  /// In en, this message translates to:
  /// **'Host With Us'**
  String get hostWithUs;

  /// No description provided for @aboutLoby.
  ///
  /// In en, this message translates to:
  /// **'About Loby'**
  String get aboutLoby;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @pleaseSelectValidAddress.
  ///
  /// In en, this message translates to:
  /// **'Please select a valid address from the Map'**
  String get pleaseSelectValidAddress;

  /// No description provided for @enterActivityInfo.
  ///
  /// In en, this message translates to:
  /// **'Please enter your activity information'**
  String get enterActivityInfo;

  /// No description provided for @nameOfActivity.
  ///
  /// In en, this message translates to:
  /// **'Name of activity'**
  String get nameOfActivity;

  /// No description provided for @enterActivityName.
  ///
  /// In en, this message translates to:
  /// **'Enter your activity name'**
  String get enterActivityName;

  /// No description provided for @uploadStudioPhotosOrVideo.
  ///
  /// In en, this message translates to:
  /// **'Upload studio photos or video'**
  String get uploadStudioPhotosOrVideo;

  /// No description provided for @activityTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Activity time'**
  String get activityTimeLabel;

  /// No description provided for @enterActivityTime.
  ///
  /// In en, this message translates to:
  /// **'Enter Activity time'**
  String get enterActivityTime;

  /// No description provided for @pleaseEnterActivityTime.
  ///
  /// In en, this message translates to:
  /// **'Please enter the Activity time'**
  String get pleaseEnterActivityTime;

  /// No description provided for @hoursHint.
  ///
  /// In en, this message translates to:
  /// **'{count} hours'**
  String hoursHint(String count);

  /// No description provided for @maximumGuests.
  ///
  /// In en, this message translates to:
  /// **'Maximum Guests'**
  String get maximumGuests;

  /// No description provided for @enterMaxGuests.
  ///
  /// In en, this message translates to:
  /// **'Enter Max Guests'**
  String get enterMaxGuests;

  /// No description provided for @pleaseEnterMaxGuests.
  ///
  /// In en, this message translates to:
  /// **'Please enter the maximum guest number'**
  String get pleaseEnterMaxGuests;

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceLabel;

  /// No description provided for @enterPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter Price'**
  String get enterPrice;

  /// No description provided for @pleaseEnterPrice.
  ///
  /// In en, this message translates to:
  /// **'Please enter the Price'**
  String get pleaseEnterPrice;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @propertyUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Property updated successfully'**
  String get propertyUpdatedSuccessfully;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @pleaseCompleteInformation.
  ///
  /// In en, this message translates to:
  /// **'Please complete the following\ninformation'**
  String get pleaseCompleteInformation;

  /// No description provided for @enterPropertyInfo.
  ///
  /// In en, this message translates to:
  /// **'Please enter your property information'**
  String get enterPropertyInfo;

  /// No description provided for @pleaseSelectAddressOnMap.
  ///
  /// In en, this message translates to:
  /// **'Please select the address on the map'**
  String get pleaseSelectAddressOnMap;

  /// No description provided for @pleaseUploadAtLeastOneImage.
  ///
  /// In en, this message translates to:
  /// **'Please upload at least one image'**
  String get pleaseUploadAtLeastOneImage;

  /// No description provided for @propertyCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Property created successfully'**
  String get propertyCreatedSuccessfully;

  /// No description provided for @addSomeDetails.
  ///
  /// In en, this message translates to:
  /// **'Add Some details'**
  String get addSomeDetails;

  /// No description provided for @addDetails.
  ///
  /// In en, this message translates to:
  /// **'Add Details'**
  String get addDetails;

  /// No description provided for @pleaseEnterYourDetails.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Details'**
  String get pleaseEnterYourDetails;

  /// No description provided for @tellGuestsWhatPlaceOffers.
  ///
  /// In en, this message translates to:
  /// **'Tell guests what your place has to offer'**
  String get tellGuestsWhatPlaceOffers;

  /// No description provided for @uploadStudioPhotosOrVideoAlt.
  ///
  /// In en, this message translates to:
  /// **'studio photos or video'**
  String get uploadStudioPhotosOrVideoAlt;

  /// No description provided for @uploadLeaseOrOwnershipContract.
  ///
  /// In en, this message translates to:
  /// **'Upload Lease or ownership contract'**
  String get uploadLeaseOrOwnershipContract;

  /// No description provided for @leaseOrOwnershipContract.
  ///
  /// In en, this message translates to:
  /// **'Lease or ownership contract'**
  String get leaseOrOwnershipContract;

  /// No description provided for @uploadTouristFacilityLicense.
  ///
  /// In en, this message translates to:
  /// **'Upload Tourist hospitality facility license'**
  String get uploadTouristFacilityLicense;

  /// No description provided for @touristFacilityLicense.
  ///
  /// In en, this message translates to:
  /// **'Tourist hospitality facility license'**
  String get touristFacilityLicense;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'( optional )'**
  String get optional;

  /// No description provided for @availableDateRange.
  ///
  /// In en, this message translates to:
  /// **'Available date range'**
  String get availableDateRange;

  /// No description provided for @startDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Date:   {date}'**
  String startDateLabel(String date);

  /// No description provided for @endDateLabel.
  ///
  /// In en, this message translates to:
  /// **'End Date:   {date}'**
  String endDateLabel(String date);

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @lobyPlatformUsageAgreement.
  ///
  /// In en, this message translates to:
  /// **'Loby Platform Usage Agreement'**
  String get lobyPlatformUsageAgreement;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @enterYourAddressOrTapMap.
  ///
  /// In en, this message translates to:
  /// **'Enter your address or tap map icon to select'**
  String get enterYourAddressOrTapMap;

  /// No description provided for @pleaseEnterYourAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter your address'**
  String get pleaseEnterYourAddress;

  /// No description provided for @addSomeDetailsLabel.
  ///
  /// In en, this message translates to:
  /// **'Add Some details'**
  String get addSomeDetailsLabel;

  /// No description provided for @addDetailsHint.
  ///
  /// In en, this message translates to:
  /// **'Add Details'**
  String get addDetailsHint;

  /// No description provided for @pleaseEnterSomeDetails.
  ///
  /// In en, this message translates to:
  /// **'Please enter some details'**
  String get pleaseEnterSomeDetails;

  /// No description provided for @tellGuestsOffers.
  ///
  /// In en, this message translates to:
  /// **'Tell guests what your place has to offer'**
  String get tellGuestsOffers;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeLabel;

  /// No description provided for @yyyyMMdd.
  ///
  /// In en, this message translates to:
  /// **'yyyy-MM-dd'**
  String get yyyyMMdd;

  /// No description provided for @hhmm.
  ///
  /// In en, this message translates to:
  /// **'HH:MM'**
  String get hhmm;

  /// No description provided for @pricePerPersonHint.
  ///
  /// In en, this message translates to:
  /// **'Enter price per person'**
  String get pricePerPersonHint;

  /// No description provided for @pricePerPerson.
  ///
  /// In en, this message translates to:
  /// **'Price per person'**
  String get pricePerPerson;

  /// No description provided for @guestNumber.
  ///
  /// In en, this message translates to:
  /// **'Guest Number'**
  String get guestNumber;

  /// No description provided for @enterMaxGuestNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Maximum Guest Number'**
  String get enterMaxGuestNumber;

  /// No description provided for @pleaseEnterField.
  ///
  /// In en, this message translates to:
  /// **'Please enter {field}'**
  String pleaseEnterField(String field);

  /// No description provided for @enterOtpSentTo.
  ///
  /// In en, this message translates to:
  /// **'Enter the OTP sent to {email}'**
  String enterOtpSentTo(String email);

  /// No description provided for @otp.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otp;

  /// No description provided for @pleaseEnterValidOtp.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid OTP'**
  String get pleaseEnterValidOtp;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @pleaseEnterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter new password'**
  String get pleaseEnterNewPassword;

  /// No description provided for @passwordAtLeastSix.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordAtLeastSix;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @pleaseConfirmYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmYourPassword;

  /// No description provided for @vendorPleaseChoose.
  ///
  /// In en, this message translates to:
  /// **'Please choose'**
  String get vendorPleaseChoose;

  /// No description provided for @vendorPropertyOwner.
  ///
  /// In en, this message translates to:
  /// **'Property owner'**
  String get vendorPropertyOwner;

  /// No description provided for @vendorTouristActivity.
  ///
  /// In en, this message translates to:
  /// **'Tourist activity'**
  String get vendorTouristActivity;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get navBookings;

  /// No description provided for @navMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get navMessages;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @vendorIntroText.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Hendrerit tristique lorem ipsum dolor sit amet.\nDiam habitant.'**
  String get vendorIntroText;

  /// No description provided for @availabilityQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are your {type} available?'**
  String availabilityQuestion(String type);

  /// No description provided for @availableLabel.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get availableLabel;

  /// No description provided for @notAvailableLabel.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailableLabel;

  /// No description provided for @enterPricePerNight.
  ///
  /// In en, this message translates to:
  /// **'Enter price per night'**
  String get enterPricePerNight;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @searchLocation.
  ///
  /// In en, this message translates to:
  /// **'Search location'**
  String get searchLocation;

  /// No description provided for @lobbyOffersTitle.
  ///
  /// In en, this message translates to:
  /// **'Lobby Offers'**
  String get lobbyOffersTitle;

  /// No description provided for @lobbyOffersDescription.
  ///
  /// In en, this message translates to:
  /// **'If you add from one apartment to 10, the percentage is 10% - from 0 to 20, the percentage is 15% - more than 25, the percentage is 20%'**
  String get lobbyOffersDescription;

  /// No description provided for @imageLabel.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get imageLabel;

  /// No description provided for @videoLabel.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get videoLabel;

  /// No description provided for @uploadAtLeastOneImageWithMax.
  ///
  /// In en, this message translates to:
  /// **'Upload at least one image (max {count} medias)'**
  String uploadAtLeastOneImageWithMax(int count);

  /// No description provided for @selectedLocation.
  ///
  /// In en, this message translates to:
  /// **'Selected Location'**
  String get selectedLocation;

  /// No description provided for @gettingAddress.
  ///
  /// In en, this message translates to:
  /// **'Getting address...'**
  String get gettingAddress;

  /// No description provided for @dragToSelectLocation.
  ///
  /// In en, this message translates to:
  /// **'Drag to select location'**
  String get dragToSelectLocation;

  /// No description provided for @useCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Use Current Location'**
  String get useCurrentLocation;

  /// No description provided for @updateAddress.
  ///
  /// In en, this message translates to:
  /// **'Update Address'**
  String get updateAddress;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Location'**
  String get confirmLocation;

  /// No description provided for @shareSomeBasics.
  ///
  /// In en, this message translates to:
  /// **'Share some basics about your place'**
  String get shareSomeBasics;

  /// No description provided for @bedrooms.
  ///
  /// In en, this message translates to:
  /// **'Bedrooms'**
  String get bedrooms;

  /// No description provided for @beds.
  ///
  /// In en, this message translates to:
  /// **'Beds'**
  String get beds;

  /// No description provided for @bathrooms.
  ///
  /// In en, this message translates to:
  /// **'Bathrooms'**
  String get bathrooms;

  /// No description provided for @addNewTagTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a new tag'**
  String get addNewTagTitle;

  /// No description provided for @enterTagNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter tag name'**
  String get enterTagNameHint;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @addOtherThings.
  ///
  /// In en, this message translates to:
  /// **'Add other things'**
  String get addOtherThings;

  /// No description provided for @reservationTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservation'**
  String get reservationTitle;

  /// No description provided for @currentReservations.
  ///
  /// In en, this message translates to:
  /// **'Current Reservations'**
  String get currentReservations;

  /// No description provided for @lastReservations.
  ///
  /// In en, this message translates to:
  /// **'Last Reservations'**
  String get lastReservations;

  /// No description provided for @noReservationsFound.
  ///
  /// In en, this message translates to:
  /// **'No Reservations found'**
  String get noReservationsFound;

  /// No description provided for @dateLabelInline.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabelInline;

  /// No description provided for @checkOutInline.
  ///
  /// In en, this message translates to:
  /// **'Check Out'**
  String get checkOutInline;

  /// No description provided for @viewReservationDetails.
  ///
  /// In en, this message translates to:
  /// **'View Reservation Details'**
  String get viewReservationDetails;

  /// No description provided for @clientName.
  ///
  /// In en, this message translates to:
  /// **'Client Name'**
  String get clientName;

  /// No description provided for @reservationNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Reservation Number {number}'**
  String reservationNumberLabel(String number);

  /// No description provided for @lastNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Number {number}'**
  String lastNumberLabel(String number);

  /// No description provided for @freeCancellationBefore.
  ///
  /// In en, this message translates to:
  /// **'Free cancellation before {date}'**
  String freeCancellationBefore(String date);

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order details'**
  String get orderDetails;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @commonAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get commonAccept;

  /// No description provided for @commonRefuse.
  ///
  /// In en, this message translates to:
  /// **'Refuse'**
  String get commonRefuse;

  /// No description provided for @noteClientPaidFees.
  ///
  /// In en, this message translates to:
  /// **'Note: The client has paid the fees'**
  String get noteClientPaidFees;

  /// No description provided for @viewReservationSummary.
  ///
  /// In en, this message translates to:
  /// **'View reservation summary'**
  String get viewReservationSummary;

  /// No description provided for @personCount.
  ///
  /// In en, this message translates to:
  /// **'{count} person'**
  String personCount(int count);

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get availableBalance;

  /// No description provided for @billCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Bill code : {code}'**
  String billCodeLabel(String code);

  /// No description provided for @totalPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Price :'**
  String get totalPriceLabel;

  /// No description provided for @billDetails.
  ///
  /// In en, this message translates to:
  /// **'Bill Details'**
  String get billDetails;

  /// No description provided for @welcomeToLoby.
  ///
  /// In en, this message translates to:
  /// **'Welcome to LOBY'**
  String get welcomeToLoby;

  /// No description provided for @onboardingWelcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut hendrerit tristique gravida felis, sociis in felis.'**
  String get onboardingWelcomeDescription;

  /// No description provided for @letsStart.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start'**
  String get letsStart;

  /// No description provided for @skipLabel.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipLabel;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessagesYet;

  /// No description provided for @startConversation.
  ///
  /// In en, this message translates to:
  /// **'Start the conversation!'**
  String get startConversation;

  /// No description provided for @typeMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeMessageHint;

  /// No description provided for @messageCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Message can\'t be empty'**
  String get messageCannotBeEmpty;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @yourNotifications.
  ///
  /// In en, this message translates to:
  /// **'Your Notifications'**
  String get yourNotifications;

  /// No description provided for @noNotificationsYet.
  ///
  /// In en, this message translates to:
  /// **"You don't have any notifications right now"**
  String get noNotificationsYet;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notificationTitle;

  /// No description provided for @notificationName.
  ///
  /// In en, this message translates to:
  /// **'Notification Name'**
  String get notificationName;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @reservationCompletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your studio reservation has been successfully completed!'**
  String get reservationCompletedMessage;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
