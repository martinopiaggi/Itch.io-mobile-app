import 'package:flutter/material.dart';
import '../models/filter.dart';
import 'filter_row_widget.dart';

class FilterPopup extends StatelessWidget {
  final List<Filter> selectedFilters;

  const FilterPopup({
    super.key,
    required this.selectedFilters
  });

  List<Filter> updateFilters(Filter filter) {
    return selectedFilters.map((f) {
      if(f.name == filter.name){
        return filter;
      } else {
        return f;
      }
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    final filterRows = selectedFilters.map((filter) => FilterRowWidget(
          filter: filter,
          onFiltersChanged: (selectedOptions) {
            filter.options.forEach((option) {
              option.isSelected = selectedOptions.contains(option.name);
            });
            updateFilters(filter);
          }
      )).toList();


  return AlertDialog(
      title: const Text('Filter'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: filterRows,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Confirm'),
          onPressed: () {
            Navigator.of(context).pop(selectedFilters);
          },
        ),
        ElevatedButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
