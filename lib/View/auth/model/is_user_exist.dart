class IsUserExist {
  var sessionToken;
  var name;
  var countryCode;
  var phoneNumber;
  var email;
  var userGender;
  var userType;
  var firebaseToken;
  var isPhoneVerified;
  var isEmailVerified;
  var isNotificationAllowed;
  var userPhoto;
  var accountStatus;
  var walletAmount;

  IsUserExist(
      {this.sessionToken,
        this.name,
        this.countryCode,
        this.phoneNumber,
        this.email,
        this.userGender,
        this.userType,
        this.firebaseToken,
        this.isPhoneVerified,
        this.isEmailVerified,
        this.isNotificationAllowed,
        this.userPhoto,
        this.accountStatus,
        this.walletAmount});

  IsUserExist.fromJson(Map<String, dynamic> json) {
    sessionToken = json['session_token'];
    name = json['name'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    userGender = json['user_gender'];
    userType = json['user_type'];
    firebaseToken = json['firebase_token'];
    isPhoneVerified = json['is_phone_verified'];
    isEmailVerified = json['is_email_verified'];
    isNotificationAllowed = json['is_notification_allowed'];
    userPhoto = json['user_photo'];
    accountStatus = json['account_status'];
    walletAmount = json['wallet_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_token'] = this.sessionToken;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['user_gender'] = this.userGender;
    data['user_type'] = this.userType;
    data['firebase_token'] = this.firebaseToken;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['is_email_verified'] = this.isEmailVerified;
    data['is_notification_allowed'] = this.isNotificationAllowed;
    data['user_photo'] = this.userPhoto;
    data['account_status'] = this.accountStatus;
    data['wallet_amount'] = this.walletAmount;
    return data;
  }
}
