class BookingsList {
  var bookingNumber;
  var adults;
  var child;
  var infants;
  var startDate;
  var endDate;
  var roomType;
  var totalPrice;
  var specialRequest;
  var bookingStatus;
  var orderTime;
  var paymentType;
  var isPaymentReceived;
  var partnerSessionToken;
  var userSessionToken;
  var userFullname;
  var userCountryCode;
  var userPhoneNumber;
  var userEmail;
  var userPhoto;
  var userAddressDetail;
  var huzToken;
  var packageType;
  var packageName;
  var packageCost;
  var meccaNights;
  var madinahNights;
  var isVisaIncluded;
  var isAirportReceptionIncluded;
  var isTourGuideIncluded;
  var isInsuranceIncluded;
  var isBreakfastIncluded;
  var isLunchIncluded;
  var isDinnerIncluded;
  var paymentDetail;
  var orderBy;
  var orderTo;
  var packageToken;

  BookingsList(
      {this.bookingNumber,
        this.adults,
        this.child,
        this.infants,
        this.startDate,
        this.endDate,
        this.roomType,
        this.totalPrice,
        this.specialRequest,
        this.bookingStatus,
        this.orderTime,
        this.paymentType,
        this.isPaymentReceived,
        this.partnerSessionToken,
        this.userSessionToken,
        this.userFullname,
        this.userCountryCode,
        this.userPhoneNumber,
        this.userEmail,
        this.userPhoto,
        this.userAddressDetail,
        this.huzToken,
        this.packageType,
        this.packageName,
        this.packageCost,
        this.meccaNights,
        this.madinahNights,
        this.isVisaIncluded,
        this.isAirportReceptionIncluded,
        this.isTourGuideIncluded,
        this.isInsuranceIncluded,
        this.isBreakfastIncluded,
        this.isLunchIncluded,
        this.isDinnerIncluded,
        this.paymentDetail,
        this.orderBy,
        this.orderTo,
        this.packageToken});

  BookingsList.fromJson(Map<String, dynamic> json) {
    bookingNumber = json['booking_number'];
    adults = json['adults'];
    child = json['child'];
    infants = json['infants'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    roomType = json['room_type'];
    totalPrice = json['total_price'];
    specialRequest = json['special_request'];
    bookingStatus = json['booking_status'];
    orderTime = json['order_time'];
    paymentType = json['payment_type'];
    isPaymentReceived = json['is_payment_received'];
    partnerSessionToken = json['partner_session_token'];
    userSessionToken = json['user_session_token'];
    userFullname = json['user_fullname'];
    userCountryCode = json['user_country_code'];
    userPhoneNumber = json['user_phone_number'];
    userEmail = json['user_email'];
    userPhoto = json['user_photo'];
    userAddressDetail = json['user_address_detail'];
    huzToken = json['huz_token'];
    packageType = json['package_type'];
    packageName = json['package_name'];
    packageCost = json['package_cost'];
    meccaNights = json['mecca_nights'];
    madinahNights = json['madinah_nights'];
    isVisaIncluded = json['is_visa_included'];
    isAirportReceptionIncluded = json['is_airport_reception_included'];
    isTourGuideIncluded = json['is_tour_guide_included'];
    isInsuranceIncluded = json['is_insurance_included'];
    isBreakfastIncluded = json['is_breakfast_included'];
    isLunchIncluded = json['is_lunch_included'];
    isDinnerIncluded = json['is_dinner_included'];
    paymentDetail = json['payment_detail'];
    orderBy = json['order_by'];
    orderTo = json['order_to'];
    packageToken = json['package_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_number'] = this.bookingNumber;
    data['adults'] = this.adults;
    data['child'] = this.child;
    data['infants'] = this.infants;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['room_type'] = this.roomType;
    data['total_price'] = this.totalPrice;
    data['special_request'] = this.specialRequest;
    data['booking_status'] = this.bookingStatus;
    data['order_time'] = this.orderTime;
    data['payment_type'] = this.paymentType;
    data['is_payment_received'] = this.isPaymentReceived;
    data['partner_session_token'] = this.partnerSessionToken;
    data['user_session_token'] = this.userSessionToken;
    data['user_fullname'] = this.userFullname;
    data['user_country_code'] = this.userCountryCode;
    data['user_phone_number'] = this.userPhoneNumber;
    data['user_email'] = this.userEmail;
    data['user_photo'] = this.userPhoto;
    data['user_address_detail'] = this.userAddressDetail;
    data['huz_token'] = this.huzToken;
    data['package_type'] = this.packageType;
    data['package_name'] = this.packageName;
    data['package_cost'] = this.packageCost;
    data['mecca_nights'] = this.meccaNights;
    data['madinah_nights'] = this.madinahNights;
    data['is_visa_included'] = this.isVisaIncluded;
    data['is_airport_reception_included'] = this.isAirportReceptionIncluded;
    data['is_tour_guide_included'] = this.isTourGuideIncluded;
    data['is_insurance_included'] = this.isInsuranceIncluded;
    data['is_breakfast_included'] = this.isBreakfastIncluded;
    data['is_lunch_included'] = this.isLunchIncluded;
    data['is_dinner_included'] = this.isDinnerIncluded;
    data['payment_detail'] = this.paymentDetail;
    data['order_by'] = this.orderBy;
    data['order_to'] = this.orderTo;
    data['package_token'] = this.packageToken;
    return data;
  }
}
