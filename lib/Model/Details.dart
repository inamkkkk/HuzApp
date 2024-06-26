class Details {
  var huzToken;
  var packageType;
  var packageName;
  var packageCost;
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
  var packageStatus;
  var packageStage;
  var createdTime;
  var partnerSessionToken;
  List<AirlineDetail>? airlineDetail;
  List<TransportDetail>? transportDetail;
  List<HotelDetail>? hotelDetail;
  List<ZiyarahDetail>? ziyarahDetail;
  CompanyDetails? companyDetails;

  Details(
      {this.huzToken,
        this.packageType,
        this.packageName,
        this.packageCost,
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
        this.packageStatus,
        this.packageStage,
        this.createdTime,
        this.partnerSessionToken,
        this.airlineDetail,
        this.transportDetail,
        this.hotelDetail,
        this.ziyarahDetail,
        this.companyDetails});

  Details.fromJson(Map<String, dynamic> json) {
    huzToken = json['huz_token'];
    packageType = json['package_type'];
    packageName = json['package_name'];
    packageCost = json['package_cost'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['huz_token'] = this.huzToken;
    data['package_type'] = this.packageType;
    data['package_name'] = this.packageName;
    data['package_cost'] = this.packageCost;
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
    return data;
  }
}

class AirlineDetail {
  var airlineId;
  var airlineName;
  var ticketType;
  var isReturnFlightIncluded;

  AirlineDetail(
      {this.airlineId,
        this.airlineName,
        this.ticketType,
        this.isReturnFlightIncluded});

  AirlineDetail.fromJson(Map<String, dynamic> json) {
    airlineId = json['airline_id'];
    airlineName = json['airline_name'];
    ticketType = json['ticket_type'];
    isReturnFlightIncluded = json['is_return_flight_included'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['airline_id'] = this.airlineId;
    data['airline_name'] = this.airlineName;
    data['ticket_type'] = this.ticketType;
    data['is_return_flight_included'] = this.isReturnFlightIncluded;
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
  List<HotelPhotos>? hotelPhotos;

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
        this.isLaundry,
        this.hotelPhotos});

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
    isTelevision = json['is_Television'];
    isWifi = json['is_wifi'];
    isElevator = json['is_elevator'];
    isAttachBathroom = json['is_attach_bathroom'];
    isWashroomAmenities = json['is_washroom_amenities'];
    isEnglishToilet = json['is_english_toilet'];
    isIndianToilet = json['is_indian_toilet'];
    isLaundry = json['is_laundry'];
    if (json['hotel_photos'] != null) {
      hotelPhotos = <HotelPhotos>[];
      json['hotel_photos'].forEach((v) {
        hotelPhotos!.add(new HotelPhotos.fromJson(v));
      });
    }
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
    data['is_Television'] = this.isTelevision;
    data['is_wifi'] = this.isWifi;
    data['is_elevator'] = this.isElevator;
    data['is_attach_bathroom'] = this.isAttachBathroom;
    data['is_washroom_amenities'] = this.isWashroomAmenities;
    data['is_english_toilet'] = this.isEnglishToilet;
    data['is_indian_toilet'] = this.isIndianToilet;
    data['is_laundry'] = this.isLaundry;
    if (this.hotelPhotos != null) {
      data['hotel_photos'] = this.hotelPhotos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HotelPhotos {
  var photoId;
  var hotelPhotos;

  HotelPhotos({this.photoId, this.hotelPhotos});

  HotelPhotos.fromJson(Map<String, dynamic> json) {
    photoId = json['photo_id'];
    hotelPhotos = json['hotel_photos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo_id'] = this.photoId;
    data['hotel_photos'] = this.hotelPhotos;
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

  CompanyDetails(
      {this.companyName,
        this.totalExperience,
        this.companyBio,
        this.companyLogo});

  CompanyDetails.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    totalExperience = json['total_experience'];
    companyBio = json['company_bio'];
    companyLogo = json['company_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.companyName;
    data['total_experience'] = this.totalExperience;
    data['company_bio'] = this.companyBio;
    data['company_logo'] = this.companyLogo;
    return data;
  }
}
