class createbooking {
  var bookingId;
  var bookingNumber;
  var adults;
  var child;
  var infants;
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
  PartnerAddressDetail? partnerAddressDetail;
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
  var meccaNights;
  var madinahNights;
  var isVisaIncluded;
  var isAirportReceptionIncluded;
  var isTourGuideIncluded;
  var isInsuranceIncluded;
  var isBreakfastIncluded;
  var isLunchIncluded;
  var isDinnerIncluded;
  List<PaymentDetail>? paymentDetail;
  List<BookingObjections>? bookingObjections;
  List<BookingDocumentsStatus>? bookingDocumentsStatus;
  List<UserDocuments>? userDocuments;
  List<BookingDocuments>? bookingDocuments;
  List<BookingAirlineDetails>? bookingAirlineDetails;
  List<BookingHotelAndTransportDetails>? bookingHotelAndTransportDetails;
  List<BookingRating>? bookingRating;

  createbooking(
      {this.bookingId,
        this.bookingNumber,
        this.adults,
        this.child,
        this.infants,
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
        this.partnerAddressDetail,
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
        this.bookingObjections,
        this.bookingDocumentsStatus,
        this.userDocuments,
        this.bookingDocuments,
        this.bookingAirlineDetails,
        this.bookingHotelAndTransportDetails,
        this.bookingRating});

  createbooking.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    bookingNumber = json['booking_number'];
    adults = json['adults'];
    child = json['child'];
    infants = json['infants'];
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
    partnerAddressDetail = json['partner_address_detail'] != null
        ? new PartnerAddressDetail.fromJson(json['partner_address_detail'])
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
    meccaNights = json['mecca_nights'];
    madinahNights = json['madinah_nights'];
    isVisaIncluded = json['is_visa_included'];
    isAirportReceptionIncluded = json['is_airport_reception_included'];
    isTourGuideIncluded = json['is_tour_guide_included'];
    isInsuranceIncluded = json['is_insurance_included'];
    isBreakfastIncluded = json['is_breakfast_included'];
    isLunchIncluded = json['is_lunch_included'];
    isDinnerIncluded = json['is_dinner_included'];
    if (json['payment_detail'] != null) {
      paymentDetail = <PaymentDetail>[];
      json['payment_detail'].forEach((v) {
        paymentDetail!.add(new PaymentDetail.fromJson(v));
      });
    }
    if (json['booking_objections'] != null) {
      bookingObjections = <BookingObjections>[];
      json['booking_objections'].forEach((v) {
        bookingObjections!.add(new BookingObjections.fromJson(v));
      });
    }
    if (json['booking_documents_status'] != null) {
      bookingDocumentsStatus = <BookingDocumentsStatus>[];
      json['booking_documents_status'].forEach((v) {
        bookingDocumentsStatus!.add(new BookingDocumentsStatus.fromJson(v));
      });
    }
    if (json['user_documents'] != null) {
      userDocuments = <UserDocuments>[];
      json['user_documents'].forEach((v) {
        userDocuments!.add(new UserDocuments.fromJson(v));
      });
    }
    if (json['booking_documents'] != null) {
      bookingDocuments = <BookingDocuments>[];
      json['booking_documents'].forEach((v) {
        bookingDocuments!.add(new BookingDocuments.fromJson(v));
      });
    }
    if (json['booking_airline_details'] != null) {
      bookingAirlineDetails = <BookingAirlineDetails>[];
      json['booking_airline_details'].forEach((v) {
        bookingAirlineDetails!.add(new BookingAirlineDetails.fromJson(v));
      });
    }
    if (json['booking_hotel_and_transport_details'] != null) {
      bookingHotelAndTransportDetails = <BookingHotelAndTransportDetails>[];
      json['booking_hotel_and_transport_details'].forEach((v) {
        bookingHotelAndTransportDetails!
            .add(new BookingHotelAndTransportDetails.fromJson(v));
      });
    }
    if (json['booking_rating'] != null) {
      bookingRating = <BookingRating>[];
      json['booking_rating'].forEach((v) {
        bookingRating!.add(new BookingRating.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['booking_number'] = this.bookingNumber;
    data['adults'] = this.adults;
    data['child'] = this.child;
    data['infants'] = this.infants;
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
    if (this.partnerAddressDetail != null) {
      data['partner_address_detail'] = this.partnerAddressDetail!.toJson();
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
    if (this.bookingObjections != null) {
      data['booking_objections'] =
          this.bookingObjections!.map((v) => v.toJson()).toList();
    }
    if (this.bookingDocumentsStatus != null) {
      data['booking_documents_status'] =
          this.bookingDocumentsStatus!.map((v) => v.toJson()).toList();
    }
    if (this.userDocuments != null) {
      data['user_documents'] =
          this.userDocuments!.map((v) => v.toJson()).toList();
    }
    if (this.bookingDocuments != null) {
      data['booking_documents'] =
          this.bookingDocuments!.map((v) => v.toJson()).toList();
    }
    if (this.bookingAirlineDetails != null) {
      data['booking_airline_details'] =
          this.bookingAirlineDetails!.map((v) => v.toJson()).toList();
    }
    if (this.bookingHotelAndTransportDetails != null) {
      data['booking_hotel_and_transport_details'] =
          this.bookingHotelAndTransportDetails!.map((v) => v.toJson()).toList();
    }
    if (this.bookingRating != null) {
      data['booking_rating'] =
          this.bookingRating!.map((v) => v.toJson()).toList();
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

class PartnerAddressDetail {
  var addressId;
  var streetAddress;
  var addressLine2;
  var city;
  var state;
  var country;
  var postalCode;
  var lat;
  var long;

  PartnerAddressDetail(
      {this.addressId,
        this.streetAddress,
        this.addressLine2,
        this.city,
        this.state,
        this.country,
        this.postalCode,
        this.lat,
        this.long});

  PartnerAddressDetail.fromJson(Map<String, dynamic> json) {
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
  var fullAddress;

  UserAddressDetail(
      {this.addressId,
        this.streetAddress,
        this.addressLine2,
        this.city,
        this.state,
        this.country,
        this.postalCode,
        this.lat,
        this.long,
        this.fullAddress});

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
    fullAddress = json['full_address'];
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
    data['full_address'] = this.fullAddress;
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

class UserDocuments {
  var userDocumentId;
  var comment;
  var userDocument;
  var documentType;
  var userDocumentForBookingToken;

  UserDocuments(
      {this.userDocumentId,
        this.comment,
        this.userDocument,
        this.documentType,
        this.userDocumentForBookingToken});

  UserDocuments.fromJson(Map<String, dynamic> json) {
    userDocumentId = json['user_document_id'];
    comment = json['comment'];
    userDocument = json['user_document'];
    documentType = json['document_type'];
    userDocumentForBookingToken = json['user_document_for_booking_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_document_id'] = this.userDocumentId;
    data['comment'] = this.comment;
    data['user_document'] = this.userDocument;
    data['document_type'] = this.documentType;
    data['user_document_for_booking_token'] = this.userDocumentForBookingToken;
    return data;
  }
}

class BookingDocuments {
  var documentId;
  var documentFor;
  var documentLink;

  BookingDocuments({this.documentId, this.documentFor, this.documentLink});

  BookingDocuments.fromJson(Map<String, dynamic> json) {
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

class BookingAirlineDetails {
  var bookingAirlineId;
  var flightDate;
  var flightTime;
  var flightFrom;
  var flightTo;

  BookingAirlineDetails(
      {this.bookingAirlineId,
        this.flightDate,
        this.flightTime,
        this.flightFrom,
        this.flightTo});

  BookingAirlineDetails.fromJson(Map<String, dynamic> json) {
    bookingAirlineId = json['booking_airline_id'];
    flightDate = json['flight_date'];
    flightTime = json['flight_time'];
    flightFrom = json['flight_from'];
    flightTo = json['flight_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_airline_id'] = this.bookingAirlineId;
    data['flight_date'] = this.flightDate;
    data['flight_time'] = this.flightTime;
    data['flight_from'] = this.flightFrom;
    data['flight_to'] = this.flightTo;
    return data;
  }
}

class BookingHotelAndTransportDetails {
  var hotelOrTransportId;
  var detailFor;
  var jeddahName;
  var jeddahNumber;
  var meccaName;
  var meccaNumber;
  var madinahName;
  var madinahNumber;
  var comment1;
  var comment2;
  var sharedTime;

  BookingHotelAndTransportDetails(
      {this.hotelOrTransportId,
        this.detailFor,
        this.jeddahName,
        this.jeddahNumber,
        this.meccaName,
        this.meccaNumber,
        this.madinahName,
        this.madinahNumber,
        this.comment1,
        this.comment2,
        this.sharedTime});

  BookingHotelAndTransportDetails.fromJson(Map<String, dynamic> json) {
    hotelOrTransportId = json['hotel_or_transport_id'];
    detailFor = json['detail_for'];
    jeddahName = json['jeddah_name'];
    jeddahNumber = json['jeddah_number'];
    meccaName = json['mecca_name'];
    meccaNumber = json['mecca_number'];
    madinahName = json['madinah_name'];
    madinahNumber = json['madinah_number'];
    comment1 = json['comment_1'];
    comment2 = json['comment_2'];
    sharedTime = json['shared_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotel_or_transport_id'] = this.hotelOrTransportId;
    data['detail_for'] = this.detailFor;
    data['jeddah_name'] = this.jeddahName;
    data['jeddah_number'] = this.jeddahNumber;
    data['mecca_name'] = this.meccaName;
    data['mecca_number'] = this.meccaNumber;
    data['madinah_name'] = this.madinahName;
    data['madinah_number'] = this.madinahNumber;
    data['comment_1'] = this.comment1;
    data['comment_2'] = this.comment2;
    data['shared_time'] = this.sharedTime;
    return data;
  }
}

class BookingRating {
  var huzConcierge;
  var huzSupport;
  var huzPlatform;
  var huzServiceQuality;
  var huzResponseTime;
  var huzComment;
  var partnerTotalStars;
  var partnerComment;
  var ratingTime;

  BookingRating(
      {this.huzConcierge,
        this.huzSupport,
        this.huzPlatform,
        this.huzServiceQuality,
        this.huzResponseTime,
        this.huzComment,
        this.partnerTotalStars,
        this.partnerComment,
        this.ratingTime});

  BookingRating.fromJson(Map<String, dynamic> json) {
    huzConcierge = json['huz_concierge'];
    huzSupport = json['huz_support'];
    huzPlatform = json['huz_platform'];
    huzServiceQuality = json['huz_service_quality'];
    huzResponseTime = json['huz_response_time'];
    huzComment = json['huz_comment'];
    partnerTotalStars = json['partner_total_stars'];
    partnerComment = json['partner_comment'];
    ratingTime = json['rating_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['huz_concierge'] = this.huzConcierge;
    data['huz_support'] = this.huzSupport;
    data['huz_platform'] = this.huzPlatform;
    data['huz_service_quality'] = this.huzServiceQuality;
    data['huz_response_time'] = this.huzResponseTime;
    data['huz_comment'] = this.huzComment;
    data['partner_total_stars'] = this.partnerTotalStars;
    data['partner_comment'] = this.partnerComment;
    data['rating_time'] = this.ratingTime;
    return data;
  }
}
class BookingObjections {
  String? objectionId;
  String? remarksOrReason;
 var clientRemarks;
  var requiredDocumentForObjection;
  String? createTime;

  BookingObjections(
      {this.objectionId,
        this.remarksOrReason,
        this.clientRemarks,
        this.requiredDocumentForObjection,
        this.createTime});

  BookingObjections.fromJson(Map<String, dynamic> json) {
    objectionId = json['objection_id'];
    remarksOrReason = json['remarks_or_reason'];
    clientRemarks = json['client_remarks'];
    requiredDocumentForObjection = json['required_document_for_objection'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objection_id'] = this.objectionId;
    data['remarks_or_reason'] = this.remarksOrReason;
    data['client_remarks'] = this.clientRemarks;
    data['required_document_for_objection'] = this.requiredDocumentForObjection;
    data['create_time'] = this.createTime;
    return data;
  }
}