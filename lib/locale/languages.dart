import 'package:flutter/material.dart';

abstract class BaseLanguage {
  static BaseLanguage of(BuildContext context) => Localizations.of<BaseLanguage>(context, BaseLanguage)!;

  String get hello;

  String get searchHere;

  String get somethingWentWrong;

  String get reload;

  String get file;

  String get taxIncluded;

  String get bookNow;

  String get gallery;

  String get camera;

  String get cancel;

  String get accept;

  String get wouldYouLikeToSetProfilePhotoAsEmployee;

  String get profileUpdatedSuccessfully;

  String get yourOldPasswordDoesnT;

  String get yourNewPasswordDoesnT;

  String get logout;

  String get pressBackAgainToExitApp;

  String get home;

  String get profile;

  String get settings;

  String get language;

  String get changePassword;

  String get deleteAccount;

  String get delete;

  String get deleteAccountConfirmation;

  String get noBookingsFound;

  String get thereAreCurrentlyNo;

  String get customerInformation;

  String get petName;

  String get reason;

  String get paymentStatus;

  String get bookingFor;

  String get appointmentStatus;

  String get dateAndTime;

  String get duration;

  String get location;

  String get cancelBooking;

  String get doYouCancelThisBooking;

  String get confirm;

  String get about;

  String get yourNewPasswordMust;

  String get password;

  String get eG;

  String get newPassword;

  String get confirmNewPassword;

  String get submit;

  String get editProfile;

  String get firstName;

  String get lastName;

  String get email;

  String get contactNumber;

  String get thisFieldIsRequired;

  String get update;

  String get yourInternetIsNotWorking;

  String get forgetPassword;

  String get toResetYourNew;

  String get stayTunedNoNew;

  String get noNewNotificationsAt;

  String get rateApp;

  String get aboutApp;

  String get welcomeBackToThe;

  String get care;

  String get welcomeToThe;

  String get rememberMe;

  String get forgotPassword;

  String get signIn;

  String get yourPasswordHasBeen;

  String get youCanNowLog;

  String get done;

  String get invalidUrl;

  String get demoUserCannotBeGrantedForThis;

  String get viewAll;

  String get doYouWantToLogout;

  String get noDataFound;

  String get employeeInformation;

  String get employeeName;

  String get appointmentInformation;

  String get appLanguages;

  String get appTheme;

  String get doe;

  String get merry;

  String get customerName;

  String get yes;

  String get tokenExpired;

  String get badRequest;

  String get forbidden;

  String get pageNotFound;

  String get tooManyRequests;

  String get internalServerError;

  String get badGateway;

  String get serviceUnavailable;

  String get gatewayTimeout;

  String get myReviews;

  String get thereAreNoRevivew;

  String get bookingStatus;

  String get call;

  String get bookingsList;

  String get bookings;

  String get notifications;

  String get sorryUserCannotSignin;

  String get chooseLanguage;

  String get dayCareTaker;

  String get veterinarian;

  String get date;

  String get time;

  String get address;

  String get aboutSelf;

  String get passionateAndAttentivePet;

  String get expert;

  String get firstAidKnowledgeForPets;

  String get mainStreet;

  String get gender;

  String get zoomVideoCall;

  String get facebookLink;

  String get instagramLink;

  String get twitterLink;

  String get dribbbleLink;

  String get arrivalDate;

  String get arrivalTime;

  String get leaveDate;

  String get leaveTime;

  String get boarder;

  String get groomer;

  String get walker;

  String get trainer;

  String get daycareTaker;

  String get demoAccounts;

  String get daycare;

  String get taker;

  String get bookingInformation;

  String get service;

  String get confirmCashPayment;

  String get paymentConfirmation;

  String get areYouSureWantConfirmPayment;

  String get areYouSureWant;

  String get ohNoAreYouLeaving;

  String get pet;

  String get totalAmount;

  String get favoriteFood;

  String get favoriteActivity;

  String get paymentDetails;

  String get price;

  String get rejected;

  String get reject;

  String get areYouSureWantToRejectBooking;

  String get loading;

  String get areYouSureWantToConfirm;

  String get guest;

  String get newUpdate;

  String get anUpdateTo;

  String get isAvailableGo;

  String get later;

  String get closeApp;

  String get updateNow;

  String get start;

  String get complete;

  String get ohNoYouAreLeaving;

  String get oldPassword;

  String get personalizeYourProfile;

  String get appLanguage;

  String get theme;

  String get deleteAccounts;

  String get showSomeLoveShare;

  String get privacyPolicy;

  String get termsConditions;

  String get securelyLogOutOfAccount;

  String get thereAreNoReview;

  String get pending;

  String get completed;

  String get confirmed;

  String get cancelled;

  String get inProgress;

  String get paid;

  String get addServices;

  String get serviceName;

  String get serviceDuration;

  String get mins;

  String get defaultPrice;

  String get description;

  String get category;

  String get chooseCategory;

  String get searchForCategory;

  String get categoryListIsEmpty;

  String get thereAreNoCategory;

  String get featureImage;

  String get chooseFile;

  String get save;

  String get clearAll;

  String get areYouSureWantToRemoveNotification;

  String get notificationDeleted;

  String get successfully;

  String get areYouSureWantToClearAllNotification;

  String get nutrition;

  String get consultation;

  String get flea;

  String get and;

  String get tick;

  String get bath;

  String get leashTraining;

  String get min;

  String get healthyDogFeedingGuide;

  String get targetedTreatmentToEliminate;

  String get ticks;

  String get teachingPetsToWalk;

  String get videoConsultancy;

  String get bathingAndShampooing;

  String get categoryType;

  String get serviceFiles;

  String get addFiles;

  String get addParticularServices;

  String get newBooking;

  String get completeBooking;

  String get rejectBooking;

  String get acceptBooking;

  String get forgetEmailPassword;

  String get orderPlaced;

  String get orderPending;

  String get orderProcessing;

  String get orderDelivered;

  String get orderCancelled;

  String get noBookingDetailsFound;

  String get thereAreCurrentlyNoDetails;

  String get bookingId;

  String get tryReloadOrCheckingLater;

  String get doYouWantToRemoveNotification;

  String get doYouWantToClearAllNotification;

  String get doYouWantToConfirmPayment;

  String get doYouWantToConfirmBooking;

  String get doYouWantToRejectBooking;

  String get statusListIsEmpty;

  String get thereAreNoStatus;

  String get filters;

  String get clearFilter;

  String get bookingTime;

  String get apply;

  String get searchBookings;

  String get filterBy;

  String get searchForStatus;

  String get chooseFromMap;

  String get useCurrentLocation;

  String get chooseYourLocation;

  String get setAddress;

  String get lblPickAddress;

  String get locationPermissionDenied;

  String get lbl;

  String get enableLocation;

  String get permissionDeniedPermanently;
}
