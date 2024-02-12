class APIEndPoints {
  static const String appConfiguration = 'app-configuration';
  static const String aboutPages = 'page-list';
  //Auth & User
  static const String register = 'register';
  static const String socialLogin = 'social-login';
  static const String login = 'login';
  static const String logout = 'logout';
  static const String changePassword = 'change-password';
  static const String forgotPassword = 'forgot-password';
  static const String userDetail = 'user-detail';
  static const String updateProfile = 'update-profile';
  static const String deleteUserAccount = 'delete-account';
  //Pet
  static const String getPetTypeList = 'pet-types';
  static const String getPetList = 'pet-list';
  static const String deletePet = 'delete-pet';
  static const String addPet = 'pet';
  static const String getNote = 'get-notes';
  static const String addNote = 'save-note';
  static const String deleteNote = 'delete-note';
  //Pet Service
  static const String getFacility = 'facility-list';
  static const String getTraining = 'training-list';
  static const String getDuration = 'duration-list';
  static const String saveBooking = 'save-booking';
  static const String savePayment = 'save-payment';
  static const String getBreed = 'breed-list';
  static const String getService = 'service-list';
  static const String getCategory = 'category-list';
  static const String getEmployeeList = 'employee-list';
  static const String petCenterDetail = 'pet-center-detail';
  //home choose service api
  static const String getDashboard = 'dashboard-detail';
  static const String getNotification = 'notification-list';
  static const String getBlogs = 'blog-list';
  static const String getEvents = 'event-list';

  //booking api-list
  static const String getBooking = 'booking-list';
  static const String bookingUpdate = 'booking-update';
  static const String bookingStatus = 'booking-status';

  //booking detail-api
  static const String getBookingDetail = 'booking-detail';

  //Review
  static const String saveRating = 'save-rating';
  static const String getRating = 'get-rating';
  static const String deleteRating = 'delete-rating';
  static const String addService = 'service';
  static const String addServiceTraining = 'service-training';

  static const String removeNotification = 'notification-remove';
  static const String clearAllNotification = 'notification-deleteall';
}
