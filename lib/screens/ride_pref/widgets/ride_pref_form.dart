import 'package:blabla/screens/ride_pref/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import 'package:blabla/theme/theme.dart';
import '../../../widgets/display/bla_divider.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  DateTime? departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------
  @override
  void initState() {
    super.initState();
    // TODO
    _initializeValues();
  }

  void _initializeValues() {
    final pref = widget.initRidePref;
    departure = pref?.departure;
    departureDate = pref?.departureDate ?? DateTime.now();
    arrival = pref?.arrival;
    requestedSeats = pref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void _onDeparturePressed() {
    // TODO: Navigate to location selection screen
  }

  void _onArrivalPressed() {
    // TODO: Navigate to location selection screen
  }

  Future<void> _onDatePressed() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: departureDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => departureDate = picked);
    }
  }

  void _onSearchPressed() {
    // TODO: Handle search action
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get _formattedDate {
    if (departureDate == null) return "Select Date";
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${weekdays[departureDate!.weekday - 1]} ${departureDate!.day} ${months[departureDate!.month - 1]}';
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLocationField(
          icon: Icons.radio_button_unchecked,
          text: departure?.name ?? "Leaving From",
          onTap: _onDeparturePressed,
        ),
        BlaDivider(),
        _buildLocationField(
          icon: Icons.radio_button_unchecked,
          text: arrival != null ? "${arrival!.name}, ${arrival!.country.name}" : "Going To",
          onTap: _onArrivalPressed,
        ),
        BlaDivider(),
        _buildDateField(),
        BlaDivider(),
        _buildSeatsField(),
        SizedBox(height: 16),
        BlaButton(
          color: BlaColors.primary,
          label: "Search",
        ),
      ],
    );
  }

  Widget _buildLocationField({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: BlaColors.greyLight, size: 20),
            SizedBox(width: 12),
            Text(
              text,
              style: BlaTextStyles.label.copyWith(
                color: departure != null || arrival != null
                    ? BlaColors.primary
                    : BlaColors.greyLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: _onDatePressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: BlaColors.greyLight, size: 20),
            SizedBox(width: 12),
            Text(
              _formattedDate,
              style: BlaTextStyles.label.copyWith(
                color: departureDate != null ? BlaColors.primary : BlaColors.greyLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatsField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.person_outline, color: BlaColors.greyLight, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "1",
                hintStyle: BlaTextStyles.label.copyWith(color: BlaColors.greyLight),
              ),
              style: BlaTextStyles.label.copyWith(color: BlaColors.primary),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final seats = int.tryParse(value);
                if (seats != null) setState(() => requestedSeats = seats);
              },
            ),
          ),
        ],
      ),
    );
  }
}