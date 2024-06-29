class WishList{
  var id;
  var packageImage;
  var packageName;
  var startDate;
  var endDate;
  var incldues;
  var cost;
  var rating;
  var hotel2;


  WishList({ required this.hotel2,required this.packageImage, this.id,required this.packageName, required this.startDate, required this.endDate, this.incldues,  required this.cost, this.rating,});

  Map<String, dynamic> toJson() {
    return {
      'packageImage' : packageImage,
      'id' : id,
      'hotel2':hotel2,
      'packageName': packageName,
      'startDate': startDate,
      'endDate': endDate,
      'include': incldues,
      'cost': cost,
      'rating': rating,
    };
  }
}