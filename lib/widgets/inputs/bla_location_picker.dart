import "package:blabla/dummy_data/dummy_data.dart";
import "package:blabla/model/ride/locations.dart";
import "package:flutter/material.dart";
import 'package:blabla/theme/theme.dart';
import 'package:blabla/widgets/display/bla_divider.dart';

class BlaLocationPicker extends StatefulWidget {
  final Location? selectedLocation;
  final ValueChanged<Location> onLocationSelected;

  const BlaLocationPicker({
    super.key,
    this.selectedLocation,
    required this.onLocationSelected,
  });

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  final TextEditingController _searchController = TextEditingController();
  List<Location> _filteredLocations = fakeLocations;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredLocations = fakeLocations.where((location) {
        return location.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _onLocationTap(Location location) {
    widget.onLocationSelected(location);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: BlaColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search location",
            border: InputBorder.none,
          ),
          onChanged: _onSearchChanged,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: BlaColors.greyLight),
            onPressed: () => _searchController.clear(),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: _filteredLocations.length,
        separatorBuilder: (context, index) => BlaDivider(),
        itemBuilder: (context, index) {
          final location = _filteredLocations[index];
          final isSelected = widget.selectedLocation?.name == location.name;

          return InkWell(
            onTap: () => _onLocationTap(location),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: isSelected ? BlaColors.primary : BlaColors.greyLight,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(location.name, style: BlaTextStyles.heading),
                        Text(location.country.name, style: BlaTextStyles.body),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: BlaColors.greyLight),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}