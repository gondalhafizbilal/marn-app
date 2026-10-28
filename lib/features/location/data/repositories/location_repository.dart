import 'package:marn/features/location/data/models/marn_location.dart';

class LocationRepository {
  Future<MarnLocation> useCurrentLocation() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const MarnLocation(
      title: 'current-location',
      address: 'Doha, Qatar',
      latitude: 25.2854,
      longitude: 51.5310,
    );
  }

  Future<MarnLocation> selectManualLocation() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const MarnLocation(
      title: 'selected-location',
      address: 'Al Sadd, Doha',
      latitude: 25.2859,
      longitude: 51.5136,
    );
  }
}
