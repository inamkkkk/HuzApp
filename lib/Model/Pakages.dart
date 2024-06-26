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
        this.companyDetail});

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
    return data;
  }
}

class HotelInfoDetail {
   var hotelId;
   var hotelCity;
   var hotelName;
   var stayType;
   var hotelRating;
   var isShuttleServicesIncluded;
  List<HotelPhotos>? hotelPhotos;

  HotelInfoDetail(
      {this.hotelId,
        this.hotelCity,
        this.hotelName,
        this.stayType,
        this.hotelRating,
        this.isShuttleServicesIncluded,
        this.hotelPhotos});

  HotelInfoDetail.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotel_id'];
    hotelCity = json['hotel_city'];
    hotelName = json['hotel_name'];
    stayType = json['stay_type'];
    hotelRating = json['hotel_rating'];
    isShuttleServicesIncluded = json['is_shuttle_services_included'];
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
    data['stay_type'] = this.stayType;
    data['hotel_rating'] = this.hotelRating;
    data['is_shuttle_services_included'] = this.isShuttleServicesIncluded;
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