import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class Place {
  var streetNumber;
  var street;
  var city;
  var zipCode;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyDOzVw2I4r8J98ji7L2iEy_GRbZ7AHjnnM';

  final apiKey =  androidKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    try {
      final request =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$lang&key=$apiKey&sessiontoken=$sessionToken';
      final response = await client.get(Uri.parse(request));

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'OK') {
          print(response.body);
          // compose suggestions in a list
          return result['predictions']
              .map<Suggestion>(
                  (p) => Suggestion(p['place_id'], p['description']))
              .toList();
        }
        if (result['status'] == 'ZERO_RESULTS') {
          print('aii tera de kral');
          return [];
        }
        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (result['status'] == 'OK') {
        final components =
        result['result']['address_components'] as List<dynamic>;
        print(components);
        // build result
        final place = Place();
        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}