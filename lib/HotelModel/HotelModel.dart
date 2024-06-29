class madinaModel {
  var hotelName;
  var rating;
  var location;
  var description;
  var distanceFromMadinah;
  var category;
  var image1;
  var image2;
  var image3;
  var image4;
  var hotelId;

  madinaModel(
      {this.hotelName,
        this.rating,
        this.location,
        this.description,
        this.distanceFromMadinah,
        this.category,
        this.image1,
        this.image2,
        this.image3,
        this.image4,
        this.hotelId});

  madinaModel.fromJson(Map<String, dynamic> json) {
    hotelName = json['hotel_Name'];
    rating = json['rating'];
    location = json['location'];
    description = json['description'];
    distanceFromMadinah = json['distance_from_Madinah'];
    category = json['category'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    image4 = json['image4'];
    hotelId = json['hotel_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotel_Name'] = this.hotelName;
    data['rating'] = this.rating;
    data['location'] = this.location;
    data['description'] = this.description;
    data['distance_from_Madinah'] = this.distanceFromMadinah;
    data['category'] = this.category;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['hotel_id'] = this.hotelId;
    return data;
  }
}
