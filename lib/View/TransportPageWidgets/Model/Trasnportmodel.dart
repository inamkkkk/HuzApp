class TransportModel {
  var count;
  var next;
  var previous;
  List<Results>? results;

  TransportModel({this.count, this.next, this.previous, this.results});

  TransportModel.fromJson(Map<String, dynamic> json) {
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
  var transportPackageProvider;
  var transportToken;
  var packageType;
  var transportType;
  var nameAndModel;
  var plateNo;
  var sittingCapacity;
  var vehiclePhotos;
  var availability;
  var common1;
  var common2;
  var cost;
  var packageStatus;
  var createdTime;

  Results(
      {this.transportPackageProvider,
        this.transportToken,
        this.packageType,
        this.transportType,
        this.nameAndModel,
        this.plateNo,
        this.sittingCapacity,
        this.vehiclePhotos,
        this.availability,
        this.common1,
        this.common2,
        this.cost,
        this.packageStatus,
        this.createdTime});

  Results.fromJson(Map<String, dynamic> json) {
    transportPackageProvider = json['transport_package_provider'];
    transportToken = json['transport_token'];
    packageType = json['package_type'];
    transportType = json['transport_type'];
    nameAndModel = json['name_and_model'];
    plateNo = json['plate_no'];
    sittingCapacity = json['sitting_capacity'];
    vehiclePhotos = json['vehicle_photos'];
    availability = json['availability'];
    common1 = json['common_1'];
    common2 = json['common_2'];
    cost = json['cost'];
    packageStatus = json['package_status'];
    createdTime = json['created_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transport_package_provider'] = this.transportPackageProvider;
    data['transport_token'] = this.transportToken;
    data['package_type'] = this.packageType;
    data['transport_type'] = this.transportType;
    data['name_and_model'] = this.nameAndModel;
    data['plate_no'] = this.plateNo;
    data['sitting_capacity'] = this.sittingCapacity;
    data['vehicle_photos'] = this.vehiclePhotos;
    data['availability'] = this.availability;
    data['common_1'] = this.common1;
    data['common_2'] = this.common2;
    data['cost'] = this.cost;
    data['package_status'] = this.packageStatus;
    data['created_time'] = this.createdTime;
    return data;
  }
}
