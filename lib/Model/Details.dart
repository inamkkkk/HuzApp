class Details {
  var huzToken;
  var packageType;
  var packageName;
  var packageBaseCost;
  var costForChild;
  var costForInfants;
  var costForSharing;
  var costForQuad;
  var costForTriple;
  var costForDouble;
  var costForSingle;
  var meccaNights;
  var madinahNights;
  var startDate;
  var endDate;
  var description;
  var isVisaIncluded;
  var isAirportReceptionIncluded;
  var isTourGuideIncluded;
  var isInsuranceIncluded;
  var isBreakfastIncluded;
  var isLunchIncluded;
  var isDinnerIncluded;
  var isPackageOpenForOtherDate;
  var packageValidity;
  var packageStatus;
  var packageStage;
  var createdTime;
  var partnerSessionToken;
  List<AirlineDetail>? airlineDetail;
  List<TransportDetail>? transportDetail;
  List<HotelDetail>? hotelDetail;
  List<ZiyarahDetail>? ziyarahDetail;
  CompanyDetails? companyDetails;
  var packageProvider;
  RatingCount? ratingCount;

  Details(
      {this.huzToken,
        this.packageType,
        this.packageName,
        this.packageBaseCost,
        this.costForChild,
        this.costForInfants,
        this.costForSharing,
        this.costForQuad,
        this.costForTriple,
        this.costForDouble,
        this.costForSingle,
        this.meccaNights,
        this.madinahNights,
        this.startDate,
        this.endDate,
        this.description,
        this.isVisaIncluded,
        this.isAirportReceptionIncluded,
        this.isTourGuideIncluded,
        this.isInsuranceIncluded,
        this.isBreakfastIncluded,
        this.isLunchIncluded,
        this.isDinnerIncluded,
        this.isPackageOpenForOtherDate,
        this.packageValidity,
        this.packageStatus,
        this.packageStage,
        this.createdTime,
        this.partnerSessionToken,
        this.airlineDetail,
        this.transportDetail,
        this.hotelDetail,
        this.ziyarahDetail,
        this.companyDetails,
        this.packageProvider,
        this.ratingCount});

  Details.fromJson(Map<String, dynamic> json) {
    huzToken = json['huz_token'];
    packageType = json['package_type'];
    packageName = json['package_name'];
    packageBaseCost = json['package_base_cost'];
    costForChild = json['cost_for_child'];
    costForInfants = json['cost_for_infants'];
    costForSharing = json['cost_for_sharing'];
    costForQuad = json['cost_for_quad'];
    costForTriple = json['cost_for_triple'];
    costForDouble = json['cost_for_double'];
    costForSingle = json['cost_for_single'];
    meccaNights = json['mecca_nights'];
    madinahNights = json['madinah_nights'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    isVisaIncluded = json['is_visa_included'];
    isAirportReceptionIncluded = json['is_airport_reception_included'];
    isTourGuideIncluded = json['is_tour_guide_included'];
    isInsuranceIncluded = json['is_insurance_included'];
    isBreakfastIncluded = json['is_breakfast_included'];
    isLunchIncluded = json['is_lunch_included'];
    isDinnerIncluded = json['is_dinner_included'];
    isPackageOpenForOtherDate = json['is_package_open_for_other_date'];
    packageValidity = json['package_validity'];
    packageStatus = json['package_status'];
    packageStage = json['package_stage'];
    createdTime = json['created_time'];
    partnerSessionToken = json['partner_session_token'];
    if (json['airline_detail'] != null) {
      airlineDetail = <AirlineDetail>[];
      json['airline_detail'].forEach((v) {
        airlineDetail!.add(new AirlineDetail.fromJson(v));
      });
    }
    if (json['transport_detail'] != null) {
      transportDetail = <TransportDetail>[];
      json['transport_detail'].forEach((v) {
        transportDetail!.add(new TransportDetail.fromJson(v));
      });
    }
    if (json['hotel_detail'] != null) {
      hotelDetail = <HotelDetail>[];
      json['hotel_detail'].forEach((v) {
        hotelDetail!.add(new HotelDetail.fromJson(v));
      });
    }
    if (json['ziyarah_detail'] != null) {
      ziyarahDetail = <ZiyarahDetail>[];
      json['ziyarah_detail'].forEach((v) {
        ziyarahDetail!.add(new ZiyarahDetail.fromJson(v));
      });
    }
    companyDetails = json['company_details'] != null
        ? new CompanyDetails.fromJson(json['company_details'])
        : null;
    packageProvider = json['package_provider'];
    ratingCount = json['rating_count'] != null
        ? new RatingCount.fromJson(json['rating_count'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['huz_token'] = this.huzToken;
    data['package_type'] = this.packageType;
    data['package_name'] = this.packageName;
    data['package_base_cost'] = this.packageBaseCost;
    data['cost_for_child'] = this.costForChild;
    data['cost_for_infants'] = this.costForInfants;
    data['cost_for_sharing'] = this.costForSharing;
    data['cost_for_quad'] = this.costForQuad;
    data['cost_for_triple'] = this.costForTriple;
    data['cost_for_double'] = this.costForDouble;
    data['cost_for_single'] = this.costForSingle;
    data['mecca_nights'] = this.meccaNights;
    data['madinah_nights'] = this.madinahNights;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['is_visa_included'] = this.isVisaIncluded;
    data['is_airport_reception_included'] = this.isAirportReceptionIncluded;
    data['is_tour_guide_included'] = this.isTourGuideIncluded;
    data['is_insurance_included'] = this.isInsuranceIncluded;
    data['is_breakfast_included'] = this.isBreakfastIncluded;
    data['is_lunch_included'] = this.isLunchIncluded;
    data['is_dinner_included'] = this.isDinnerIncluded;
    data['is_package_open_for_other_date'] = this.isPackageOpenForOtherDate;
    data['package_validity'] = this.packageValidity;
    data['package_status'] = this.packageStatus;
    data['package_stage'] = this.packageStage;
    data['created_time'] = this.createdTime;
    data['partner_session_token'] = this.partnerSessionToken;
    if (this.airlineDetail != null) {
      data['airline_detail'] =
          this.airlineDetail!.map((v) => v.toJson()).toList();
    }
    if (this.transportDetail != null) {
      data['transport_detail'] =
          this.transportDetail!.map((v) => v.toJson()).toList();
    }
    if (this.hotelDetail != null) {
      data['hotel_detail'] = this.hotelDetail!.map((v) => v.toJson()).toList();
    }
    if (this.ziyarahDetail != null) {
      data['ziyarah_detail'] =
          this.ziyarahDetail!.map((v) => v.toJson()).toList();
    }
    if (this.companyDetails != null) {
      data['company_details'] = this.companyDetails!.toJson();
    }
    data['package_provider'] = this.packageProvider;
    if (this.ratingCount != null) {
      data['rating_count'] = this.ratingCount!.toJson();
    }
    return data;
  }
}

class AirlineDetail {
  var airlineId;
  var airlineName;
  var ticketType;
  var flightFrom;
  var flightTo;
  var isReturnFlightIncluded;
  var airlineForPackage;

  AirlineDetail(
      {this.airlineId,
        this.airlineName,
        this.ticketType,
        this.flightFrom,
        this.flightTo,
        this.isReturnFlightIncluded,
        this.airlineForPackage});

  AirlineDetail.fromJson(Map<String, dynamic> json) {
    airlineId = json['airline_id'];
    airlineName = json['airline_name'];
    ticketType = json['ticket_type'];
    flightFrom = json['flight_from'];
    flightTo = json['flight_to'];
    isReturnFlightIncluded = json['is_return_flight_included'];
    airlineForPackage = json['airline_for_package'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['airline_id'] = this.airlineId;
    data['airline_name'] = this.airlineName;
    data['ticket_type'] = this.ticketType;
    data['flight_from'] = this.flightFrom;
    data['flight_to'] = this.flightTo;
    data['is_return_flight_included'] = this.isReturnFlightIncluded;
    data['airline_for_package'] = this.airlineForPackage;
    return data;
  }
}

class TransportDetail {
  var transportId;
  var transportName;
  var transportType;
  var routes;

  TransportDetail(
      {this.transportId, this.transportName, this.transportType, this.routes});

  TransportDetail.fromJson(Map<String, dynamic> json) {
    transportId = json['transport_id'];
    transportName = json['transport_name'];
    transportType = json['transport_type'];
    routes = json['routes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transport_id'] = this.transportId;
    data['transport_name'] = this.transportName;
    data['transport_type'] = this.transportType;
    data['routes'] = this.routes;
    return data;
  }
}

class HotelDetail {
  var hotelId;
  var hotelCity;
  var hotelName;
  var hotelRating;
  var roomSharingType;
  var hotelDistance;
  var distanceType;
  var isShuttleServicesIncluded;
  var isAirCondition;
  var isTelevision;
  var isWifi;
  var isElevator;
  var isAttachBathroom;
  var isWashroomAmenities;
  var isEnglishToilet;
  var isIndianToilet;
  var isLaundry;

  HotelDetail(
      {this.hotelId,
        this.hotelCity,
        this.hotelName,
        this.hotelRating,
        this.roomSharingType,
        this.hotelDistance,
        this.distanceType,
        this.isShuttleServicesIncluded,
        this.isAirCondition,
        this.isTelevision,
        this.isWifi,
        this.isElevator,
        this.isAttachBathroom,
        this.isWashroomAmenities,
        this.isEnglishToilet,
        this.isIndianToilet,
        this.isLaundry});

  HotelDetail.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotel_id'];
    hotelCity = json['hotel_city'];
    hotelName = json['hotel_name'];
    hotelRating = json['hotel_rating'];
    roomSharingType = json['room_sharing_type'];
    hotelDistance = json['hotel_distance'];
    distanceType = json['distance_type'];
    isShuttleServicesIncluded = json['is_shuttle_services_included'];
    isAirCondition = json['is_air_condition'];
    isTelevision = json['is_television'];
    isWifi = json['is_wifi'];
    isElevator = json['is_elevator'];
    isAttachBathroom = json['is_attach_bathroom'];
    isWashroomAmenities = json['is_washroom_amenities'];
    isEnglishToilet = json['is_english_toilet'];
    isIndianToilet = json['is_indian_toilet'];
    isLaundry = json['is_laundry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotel_id'] = this.hotelId;
    data['hotel_city'] = this.hotelCity;
    data['hotel_name'] = this.hotelName;
    data['hotel_rating'] = this.hotelRating;
    data['room_sharing_type'] = this.roomSharingType;
    data['hotel_distance'] = this.hotelDistance;
    data['distance_type'] = this.distanceType;
    data['is_shuttle_services_included'] = this.isShuttleServicesIncluded;
    data['is_air_condition'] = this.isAirCondition;
    data['is_television'] = this.isTelevision;
    data['is_wifi'] = this.isWifi;
    data['is_elevator'] = this.isElevator;
    data['is_attach_bathroom'] = this.isAttachBathroom;
    data['is_washroom_amenities'] = this.isWashroomAmenities;
    data['is_english_toilet'] = this.isEnglishToilet;
    data['is_indian_toilet'] = this.isIndianToilet;
    data['is_laundry'] = this.isLaundry;
    return data;
  }
}

class ZiyarahDetail {
  var ziyarahId;
  var ziyarahList;

  ZiyarahDetail({this.ziyarahId, this.ziyarahList});

  ZiyarahDetail.fromJson(Map<String, dynamic> json) {
    ziyarahId = json['ziyarah_id'];
    ziyarahList = json['ziyarah_list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ziyarah_id'] = this.ziyarahId;
    data['ziyarah_list'] = this.ziyarahList;
    return data;
  }
}

class CompanyDetails {
  var companyName;
  var totalExperience;
  var companyBio;
  var companyLogo;
  var contactName;
  var contactNumber;

  CompanyDetails(
      {this.companyName,
        this.totalExperience,
        this.companyBio,
        this.companyLogo,
        this.contactName,
        this.contactNumber});

  CompanyDetails.fromJson(Map<String, dynamic> json) {
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

class RatingCount {
  var totalStars;
  var ratingCount;
  var averageStars;

  RatingCount({this.totalStars, this.ratingCount, this.averageStars});

  RatingCount.fromJson(Map<String, dynamic> json) {
    totalStars = json['total_stars'];
    ratingCount = json['rating_count'];
    averageStars = json['average_stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_stars'] = this.totalStars;
    data['rating_count'] = this.ratingCount;
    data['average_stars'] = this.averageStars;
    return data;
  }
}
