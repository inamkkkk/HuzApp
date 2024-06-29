class Pakages {
  var count;
  var next;
  var previous;
  List<Results>? results;

  Pakages({this.count, this.next, this.previous, this.results});

  Pakages.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  var huzToken;
  var packageType;
  var packageName;
  var packageCost;
  var meccaNights;
  var madinahNights;
  var startDate;
  var endDate;
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
  var partnerSessionToken;
  List<HotelInfoDetail>? hotelInfoDetail;
  CompanyDetail? companyDetail;
  RatingCount? ratingCount;

  Results(
      {this.huzToken,
        this.packageType,
        this.packageName,
        this.packageCost,
        this.meccaNights,
        this.madinahNights,
        this.startDate,
        this.endDate,
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
        this.partnerSessionToken,
        this.hotelInfoDetail,
        this.companyDetail,
        this.ratingCount});

  Results.fromJson(Map<String, dynamic> json) {
    huzToken = json['huz_token'];
    packageType = json['package_type'];
    packageName = json['package_name'];
    packageCost = json['package_cost'];
    meccaNights = json['mecca_nights'];
    madinahNights = json['madinah_nights'];
    startDate = json['start_date'];
    endDate = json['end_date'];
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
    partnerSessionToken = json['partner_session_token'];
    if (json['hotel_info_detail'] != null) {
      hotelInfoDetail = <HotelInfoDetail>[];
      json['hotel_info_detail'].forEach((v) {
        hotelInfoDetail!.add(new HotelInfoDetail.fromJson(v));
      });
    }
    companyDetail = json['company_detail'] != null
        ? new CompanyDetail.fromJson(json['company_detail'])
        : null;
    ratingCount = json['rating_count'] != null
        ? new RatingCount.fromJson(json['rating_count'])
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
    data['partner_session_token'] = this.partnerSessionToken;
    if (this.hotelInfoDetail != null) {
      data['hotel_info_detail'] =
          this.hotelInfoDetail!.map((v) => v.toJson()).toList();
    }
    if (this.companyDetail != null) {
      data['company_detail'] = this.companyDetail!.toJson();
    }
    if (this.ratingCount != null) {
      data['rating_count'] = this.ratingCount!.toJson();
    }
    return data;
  }
}

class HotelInfoDetail {
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
  List<Null>? hotelPhotos;

  HotelInfoDetail(
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

  HotelInfoDetail.fromJson(Map<String, dynamic> json) {
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

    return data;
  }
}

class CompanyDetail {
  var companyName;
  var totalExperience;
  var companyBio;
  var companyLogo;

  CompanyDetail(
      {this.companyName,
        this.totalExperience,
        this.companyBio,
        this.companyLogo});

  CompanyDetail.fromJson(Map<String, dynamic> json) {
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
