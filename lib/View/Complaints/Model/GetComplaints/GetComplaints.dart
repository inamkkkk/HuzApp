class GetComplaintsModel {
  var count;
  var next;
  var previous;
  List<Results>? results;


  GetComplaintsModel({this.count, this.next, this.previous, this.results});

  GetComplaintsModel.fromJson(Map<String, dynamic> json) {
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
  var complaintId;
  var complaintTicket;
  var complaintTitle;
  var complaintMessage;
  var audioMessage;
  var complaintStatus;
  var complaintTime;
  var responseMessage;
  var userFullName;
  var userPhoto;
  var userAddressDetail;
  var packageType;
  var packageName;
  var packageCost;
  var bookingNumber;
  PartnerContactDetail? partnerContactDetail;

  Results(
      {this.complaintId,
        this.complaintTicket,
        this.complaintTitle,
        this.complaintMessage,
        this.audioMessage,
        this.complaintStatus,
        this.complaintTime,
        this.responseMessage,
        this.userFullName,
        this.userPhoto,
        this.userAddressDetail,
        this.packageType,
        this.packageName,
        this.packageCost,
        this.bookingNumber,
        this.partnerContactDetail});

  Results.fromJson(Map<String, dynamic> json) {
    complaintId = json['complaint_id'];
    complaintTicket = json['complaint_ticket'];
    complaintTitle = json['complaint_title'];
    complaintMessage = json['complaint_message'];
    audioMessage = json['audio_message'];
    complaintStatus = json['complaint_status'];
    complaintTime = json['complaint_time'];
    responseMessage = json['response_message'];
    userFullName = json['user_fullName'];
    userPhoto = json['user_photo'];
    userAddressDetail = json['user_address_detail'];
    packageType = json['package_type'];
    packageName = json['package_name'];
    packageCost = json['package_cost'];
    bookingNumber = json['booking_number'];
    partnerContactDetail = json['partner_contact_detail'] != null
        ? new PartnerContactDetail.fromJson(json['partner_contact_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['complaint_id'] = this.complaintId;
    data['complaint_ticket'] = this.complaintTicket;
    data['complaint_title'] = this.complaintTitle;
    data['complaint_message'] = this.complaintMessage;
    data['audio_message'] = this.audioMessage;
    data['complaint_status'] = this.complaintStatus;
    data['complaint_time'] = this.complaintTime;
    data['response_message'] = this.responseMessage;
    data['user_fullName'] = this.userFullName;
    data['user_photo'] = this.userPhoto;
    data['user_address_detail'] = this.userAddressDetail;
    data['package_type'] = this.packageType;
    data['package_name'] = this.packageName;
    data['package_cost'] = this.packageCost;
    data['booking_number'] = this.bookingNumber;
    if (this.partnerContactDetail != null) {
      data['partner_contact_detail'] = this.partnerContactDetail!.toJson();
    }
    return data;
  }
}

class PartnerContactDetail {
  var companyName;
  var contactName;
  var contactNumber;

  PartnerContactDetail(
      {this.companyName, this.contactName, this.contactNumber});

  PartnerContactDetail.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    contactName = json['contact_name'];
    contactNumber = json['contact_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.companyName;
    data['contact_name'] = this.contactName;
    data['contact_number'] = this.contactNumber;
    return data;
  }
}
