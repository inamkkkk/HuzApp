class BookingsList {
  var bookingId;
  var bookingNumber;
  var adults;
  var child;
  var startDate;
  var endDate;
  var totalPrice;
  var specialRequest;
  var bookingStatus;
  var orderTime;
  var paymentType;
  var isPaymentReceived;
  var partnerSessionToken;
  var userSessionToken;
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
  List<dynamic>? paymentDetail;

  BookingsList(
      {this.bookingId,
        this.bookingNumber,
        this.adults,
        this.child,
        this.startDate,
        this.endDate,
        this.totalPrice,
        this.specialRequest,
        this.bookingStatus,
        this.orderTime,
        this.paymentType,
        this.isPaymentReceived,
        this.partnerSessionToken,
        this.userSessionToken,
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
        this.paymentDetail});

  BookingsList.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    bookingNumber = json['booking_number'];
    adults = json['adults'];
    child = json['child'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    totalPrice = json['total_price'];
    specialRequest = json['special_request'];
    bookingStatus = json['booking_status'];
    orderTime = json['order_time'];
    paymentType = json['payment_type'];
    isPaymentReceived = json['is_payment_received'];
    partnerSessionToken = json['partner_session_token'];
    userSessionToken = json['user_session_token'];
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
    // if (json['payment_detail'] != null) {
    //   paymentDetail = <dynamic>[];
    //   json['payment_detail'].forEach((v) {
    //     paymentDetail!.add(new dynamic.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['booking_number'] = this.bookingNumber;
    data['adults'] = this.adults;
    data['child'] = this.child;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['total_price'] = this.totalPrice;
    data['special_request'] = this.specialRequest;
    data['booking_status'] = this.bookingStatus;
    data['order_time'] = this.orderTime;
    data['payment_type'] = this.paymentType;
    data['is_payment_received'] = this.isPaymentReceived;
    data['partner_session_token'] = this.partnerSessionToken;
    data['user_session_token'] = this.userSessionToken;
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
    if (this.paymentDetail != null) {
      data['payment_detail'] =
          this.paymentDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
