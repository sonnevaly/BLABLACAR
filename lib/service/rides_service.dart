import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  //
  //  filter the rides starting from given departure location
  //
  static List<Ride> _filterByDeparture(Location departure) {
    List<Ride> rides = availableRides.where((rides) {
      return rides.departureLocation == departure;
    }).toList();
    return rides;
  }

  //
  //  filter the rides starting for the given requested seat number
  //
  static List<Ride> _filterBySeatRequested(int requestedSeat) {
    if (requestedSeat <= 0) {
      throw Exception("requested Seat Is null");
    }
    List<Ride> rides = availableRides.where((rides) {
      return rides.availableSeats >= requestedSeat;
    }).toList();
    return rides;
  }

  //
  //  filter the rides   with several optional criteria (flexible filter options)
  //
  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    if (departure == null || seatRequested == null) {
      throw Exception("Departure or Seat that Request is not provie");
    }
    List<Ride> filterByDeparture = _filterByDeparture(departure);
    return filterByDeparture.where((rides) {
      return rides.availableSeats >= seatRequested;
    }).toList();
  }
}