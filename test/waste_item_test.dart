import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/waste_item.dart';

void main() {
  test('post created from WasteItem has appropriate property values', () {
    final date = DateTime.parse('2021-08-05').toString();
    const imageURL = 'FakeURL';
    const quantity = 1;
    const latitude = 1.5;
    const longitude = 1.8;

    final postedWasteItem = WasteItem(
      imageURL: imageURL, 
      date: date, 
      latitude: latitude, 
      longitude: longitude, 
      quantity: quantity);

    expect(postedWasteItem.imageURL, imageURL);
    expect(postedWasteItem.date, date);
    expect(postedWasteItem.latitude, latitude);
    expect(postedWasteItem.longitude, longitude);
    expect(postedWasteItem.quantity, quantity);
  });

  
}
