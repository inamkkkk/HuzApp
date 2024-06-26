class createbooking {
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
  var partnerRemarks;
  var partnerSessionToken;
  var partnerEmail;
  var partnerName;
  var partnerUsername;
  CompanyDetail? companyDetail;
  var userSessionToken;
  var userFullName;
  var userCountryCode;
  var userPhoneNumber;
  var userEmail;
  var userPhoto;
  UserAddressDetail? userAddressDetail;
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
  List<BookingRequiredDocuments>? bookingRequiredDocuments;
  List<BookingDocumentsStatus>? bookingDocumentsStatus;
  List<dynamic>? bookingAirlineDetails;
  List<dynamic>? bookingHotelAndTransportDetails;
  List<dynamic>? bookingRating;
  List<PaymentDetail>? paymentDetail;

  createbooking(
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
        this.partnerRemarks,
        this.partnerSessionToken,
        this.partnerEmail,
        this.partnerName,
        this.partnerUsername,
        this.companyDetail,
        this.userSessionToken,
        this.userFullName,
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
        this.bookingRequiredDocuments,
        this.bookingDocumentsStatus,
        this.bookingAirlineDetails,
        this.bookingHotelAndTransportDetails,
        this.bookingRating,
        this.paymentDetail});

  createbooking.fromJson(Map<String, dynamic> json) {
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
    partnerRemarks = json['partner_remarks'];
    partnerSessionToken = json['partner_session_token'];
    partnerEmail = json['partner_email'];
    partnerName = json['partner_name'];
    partnerUsername = json['partner_username'];
    companyDetail = json['company_detail'] != null
        ? new CompanyDetail.fromJson(json['company_detail'])
        : null;
    userSessionToken = json['user_session_token'];
    userFullName = json['user_fullName'];
    userCountryCode = json['user_country_code'];
    userPhoneNumber = json['user_phone_number'];
    userEmail = json['user_email'];
    userPhoto = json['user_photo'];
    userAddressDetail = json['user_address_detail'] != null
        ? new UserAddressDetail.fromJson(json['user_address_detail'])
        : null;
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
    if (json['booking_required_documents'] != null) {
      bookingRequiredDocuments = <BookingRequiredDocuments>[];
      json['booking_required_documents'].forEach((v) {
        bookingRequiredDocuments!.add(new BookingRequiredDocuments.fromJson(v));
      });
    }
    if (json['booking_documents_status'] != null) {
      bookingDocumentsStatus = <BookingDocumentsStatus>[];
      json['booking_documents_status'].forEach((v) {
        bookingDocumentsStatus!.add(new BookingDocumentsStatus.fromJson(v));
      });
    }
    // if (json['booking_airline_details'] != null) {
    //   bookingAirlineDetails = <Null>[];
    //   json['booking_airline_details'].forEach((v) {
    //     bookingAirlineDetails!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['booking_hotel_and_transport_details'] != null) {
    //   bookingHotelAndTransportDetails = <Null>[];
    //   json['booking_hotel_and_transport_details'].forEach((v) {
    //     bookingHotelAndTransportDetails!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['booking_rating'] != null) {
    //   bookingRating = <Null>[];
    //   json['booking_rating'].forEach((v) {
    //     bookingRating!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['payment_detail'] != null) {
      paymentDetail = <PaymentDetail>[];
      json['payment_detail'].forEach((v) {
        paymentDetail!.add(new PaymentDetail.fromJson(v));
      });
    }
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
    data['partner_remarks'] = this.partnerRemarks;
    data['partner_session_token'] = this.partnerSessionToken;
    data['partner_email'] = this.partnerEmail;
    data['partner_name'] = this.partnerName;
    data['partner_username'] = this.partnerUsername;
    if (this.companyDetail != null) {
      data['company_detail'] = this.companyDetail!.toJson();
    }
    data['user_session_token'] = this.userSessionToken;
    data['user_fullName'] = this.userFullName;
    data['user_country_code'] = this.userCountryCode;
    data['user_phone_number'] = this.userPhoneNumber;
    data['user_email'] = this.userEmail;
    data['user_photo'] = this.userPhoto;
    if (this.userAddressDetail != null) {
      data['user_address_detail'] = this.userAddressDetail!.toJson();
    }
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
    if (this.bookingRequiredDocuments != null) {
      data['booking_required_documents'] =
          this.bookingRequiredDocuments!.map((v) => v.toJson()).toList();
    }
    if (this.bookingDocumentsStatus != null) {
      data['booking_documents_status'] =
          this.bookingDocumentsStatus!.map((v) => v.toJson()).toList();
    }
    // if (this.bookingAirlineDetails != null) {
    //   data['booking_airline_details'] =
    //       this.bookingAirlineDetails!.map((v) => v.toJson()).toList();
    // }
    // if (this.bookingHotelAndTransportDetails != null) {
    //   data['booking_hotel_and_transport_details'] =
    //       this.bookingHotelAndTransportDetails!.map((v) => v.toJson()).toList();
    // }
    // if (this.bookingRating != null) {
    //   data['booking_rating'] =
    //       this.bookingRating!.map((v) => v.toJson()).toList();
    // }
    if (this.paymentDetail != null) {
      data['payment_detail'] =
          this.paymentDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompanyDetail {
  var companyName;
  var totalExperience;
  var companyBio;
  var companyLogo;
  var contactName;
  var contactNumber;

  CompanyDetail(
      {this.companyName,
        this.totalExperience,
        this.companyBio,
        this.companyLogo,
        this.contactName,
        this.contactNumber});

  CompanyDetail.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    totalExperience = json['total_experience'];
    companyBio = json['company_bio'];
    companyLogo = json['company_logo'];
    contactName = json['contact_name'];
    contactNumber = json['contact_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.companyName;
    data['total_experience'] = this.totalExperience;
    data['company_bio'] = this.companyBio;
    data['company_logo'] = this.companyLogo;
    data['contact_name'] = this.contactName;
    data['contact_number'] = this.contactNumber;
    return data;
  }
}

class UserAddressDetail {
  var addressId;
  var streetAddress;
  var addressLine2;
  var city;
  var state;
  var country;
  var postalCode;
  var lat;
  var long;

  UserAddressDetail(
      {this.addressId,
        this.streetAddress,
        this.addressLine2,
        this.city,
        this.state,
        this.country,
        this.postalCode,
        this.lat,
        this.long});

  UserAddressDetail.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    streetAddress = json['street_address'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['street_address'] = this.streetAddress;
    data['address_line2'] = this.addressLine2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}

class BookingRequiredDocuments {
  var documentId;
  var documentFor;
  var documentLink;

  BookingRequiredDocuments(
      {this.documentId, this.documentFor, this.documentLink});

  BookingRequiredDocuments.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'];
    documentFor = json['document_for'];
    documentLink = json['document_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_id'] = this.documentId;
    data['document_for'] = this.documentFor;
    data['document_link'] = this.documentLink;
    return data;
  }
}

class BookingDocumentsStatus {
  var isUserPassportCompleted;
  var isVisaCompleted;
  var isAirlineDetailCompleted;
  var isAirlineCompleted;
  var isHotelCompleted;
  var isTransportCompleted;

  BookingDocumentsStatus(
      {this.isUserPassportCompleted,
        this.isVisaCompleted,
        this.isAirlineDetailCompleted,
        this.isAirlineCompleted,
        this.isHotelCompleted,
        this.isTransportCompleted});

  BookingDocumentsStatus.fromJson(Map<String, dynamic> json) {
    isUserPassportCompleted = json['is_user_passport_completed'];
    isVisaCompleted = json['is_visa_completed'];
    isAirlineDetailCompleted = json['is_airline_detail_completed'];
    isAirlineCompleted = json['is_airline_completed'];
    isHotelCompleted = json['is_hotel_completed'];
    isTransportCompleted = json['is_transport_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_user_passport_completed'] = this.isUserPassportCompleted;
    data['is_visa_completed'] = this.isVisaCompleted;
    data['is_airline_detail_completed'] = this.isAirlineDetailCompleted;
    data['is_airline_completed'] = this.isAirlineCompleted;
    data['is_hotel_completed'] = this.isHotelCompleted;
    data['is_transport_completed'] = this.isTransportCompleted;
    return data;
  }
}

class PaymentDetail {
  var paymentId;
  var transactionNumber;
  var transactionPhoto;
  var transactionAmount;
  var transactionTime;

  PaymentDetail(
      {this.paymentId,
        this.transactionNumber,
        this.transactionPhoto,
        this.transactionAmount,
        this.transactionTime});

  PaymentDetail.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    transactionNumber = json['transaction_number'];
    transactionPhoto = json['transaction_photo'];
    transactionAmount = json['transaction_amount'];
    transactionTime = json['transaction_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_id'] = this.paymentId;
    data['transaction_number'] = this.transactionNumber;
    data['transaction_photo'] = this.transactionPhoto;
    data['transaction_amount'] = this.transactionAmount;
    data['transaction_time'] = this.transactionTime;
    return data;
  }
}
