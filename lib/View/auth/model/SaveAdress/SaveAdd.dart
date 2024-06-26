class SaveAddressModel {
  String? addressId;
  String? streetAddress;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  String? lat;
  String? long;

  SaveAddressModel(
      {this.addressId,
        this.streetAddress,
        this.addressLine2,
        this.city,
        this.state,
        this.country,
        this.postalCode,
        this.lat,
        this.long});

  SaveAddressModel.fromJson(Map<String, dynamic> json) {
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