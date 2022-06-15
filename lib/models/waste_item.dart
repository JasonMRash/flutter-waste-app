class WasteItem
{
  String? imageURL = '';
  String? date = '';
  double? latitude = 0.0;
  double? longitude = 0.0;
  int? quantity = 0;

  WasteItem({required this.imageURL, required this.date, required this.latitude, required this.longitude, required this.quantity});

  Map<String, dynamic> fromMap() {
    return {
      'imageURL' : imageURL,
      'date' : date,
      'latitude' : latitude,
      'longitude' : longitude,
      'quantity' : quantity,
    };
  }
}