// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, non_constant_identifier_names, duplicate_ignore, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:Tems/config/data.dart';
import 'package:Tems/pages/Drawer_right/widget/date_widg.dart';
import 'package:Tems/pages/widget/toast.dart';

class FilterDrawer extends StatefulWidget {
  final Function(String, String, int) onFilterSelected;
  const FilterDrawer({Key? key, required this.onFilterSelected})
      : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  String selectedUnit = 'Date Range';
  String? yearStart;
  String? yearEnd;
  String? selectedYear;
  String? selectedMonth;
  bool isTick = false;
  List<String> Categories5 = ['Date Range', 'Weekly', 'Monthly', 'Yearly'];
  List<String> Categories6 = ['Date Range'];
  // ignore: non_constant_identifier_names
  final DateDAta _DAteController = Get.put(DateDAta());
  final MultiSelectController _controller = MultiSelectController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _daterangef = TextEditingController();
  final TextEditingController _daterangel = TextEditingController();

  void submit(String unit) {
    if (unit == 'Date Range') {}
  }

  final bool _selectAll = false;
  void _selectWeek(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime date) {
        // Allow selection only if the day is Monday (1) to Sunday (7)
        return date.weekday >= DateTime.monday &&
            date.weekday <= DateTime.sunday;
      },
    );

    if (pickedDate != null) {
      // Calculate the start and end dates of the selected week
      DateTime startDate =
          pickedDate.subtract(Duration(days: pickedDate.weekday - 1));
      DateTime endDate =
          pickedDate.add(Duration(days: DateTime.sunday - pickedDate.weekday));

      // Update the text field with the selected week range
      setState(() {
        _daterangef.text =
            '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}T12:12:50';
        _daterangel.text =
            '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}T12:12:50';

        _dateController.text =
            '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')} to ${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';
      });
    }
  }

  DateTime? _selectedDateTime;

  Future<void> _selectDateTime(BuildContext context, String find) async {
    final DateTime now = DateTime.now();
    final DateTime oneMinuteBeforeNow =
        now.subtract(const Duration(minutes: 1));
    final DateTime firstSelectableDate = now.subtract(const Duration(days: 31));
    final DateTime lastSelectableDate = now;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? now,
      firstDate:
          Data.role == 'ROLE_ADMIN' ? DateTime(2000) : firstSelectableDate,
      lastDate: lastSelectableDate,
      selectableDayPredicate: (DateTime date) {
        return date.isBefore(lastSelectableDate);
      },
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime;
      bool validTime = false;

      while (!validTime) {
        pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? now),
        );

        if (pickedTime != null) {
          final DateTime selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          if (selectedDateTime.isBefore(oneMinuteBeforeNow)) {
            validTime = true;
          } else {
            toaster().showsToast(
                'Please select a time at least 1 minute before the current time.',
                Colors.red,
                Colors.white);
          }
        } else {
          // User cancelled the time picker
          break;
        }
      }

      if (pickedTime != null && validTime) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime!.hour,
            pickedTime.minute,
          );

          if (find == 'one') {
            _daterangef.text =
                "${_selectedDateTime!.year}-${_selectedDateTime!.month.toString().padLeft(2, '0')}-${_selectedDateTime!.day.toString().padLeft(2, '0')}T${_selectedDateTime!.hour}:${_selectedDateTime!.minute.toString().padLeft(2, '0')}:50";
          } else if (find == 'two') {
            _daterangel.text =
                "${_selectedDateTime!.year}-${_selectedDateTime!.month.toString().padLeft(2, '0')}-${_selectedDateTime!.day.toString().padLeft(2, '0')}T${_selectedDateTime!.hour}:${_selectedDateTime!.minute.toString().padLeft(2, '0')}:50";
          }
        });
      }
    }
  }

  // String selectedYear = '';

  List<String> years = [];

  void generateYearDropdown() {
    int currentYear = DateTime.now().year;
    for (int year = 2023; year <= currentYear && year <= 2024; year++) {
      years.add(year.toString());
    }
    selectedYear = years.first;
  }

  @override
  void initState() {
    super.initState();
    generateYearDropdown();

    selectedStation = [iTems.first];
  }

  List<ValueItem>? selectedStation;

  List<ValueItem> iTems = Data.stationNameswithId
      .map((e) => ValueItem(label: e['name'], value: e['id'].toString()))
      .toList();

  String? SelectedStation;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // padding: EdgeInsets.zero,
            children: [
              ListTile(
                  title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Advance Filtering'),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  )
                ],
              )),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                title: const Text('Station*'),
                onTap: () {}, // Add functionality as needed
              ),
              MultiSelectDropDown(
                showClearIcon: true,
                controller: _controller,
                onOptionSelected: (options) {
                  for (var item in options) {
                    SelectedStation = item.value;
                    // Replace 'item' with the property containing the value
                  }
                },
                options: iTems,
                backgroundColor: Colors.white10,
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: 300,
                optionTextStyle: GoogleFonts.ubuntu(fontSize: 16),
                showChipInSingleSelectMode: true,
                selectedOptionIcon: const Icon(Icons.check_circle),
                selectedOptions: isTick ? iTems : [],
              ),
              // ListTile(
              //   title:
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _selectAll,
                    onChanged: (value) {
                      setState(() {
                        isTick = !isTick;
                      });
                    },
                  ),
                  const Text('Select All'),
                ],
              ),
              // ),
              const SizedBox(
                height: 20,
              ),
              // ListTile(
              //   title:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedUnit,
                    items: Data.role == 'ROLE_ADMIN'
                        ? Categories5.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList()
                        : Categories6.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.lightBlue),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedUnit = value!;
                      });
                    },
                  ),
                  if (selectedUnit == 'Date Range')
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Select from date",
                            suffixIcon: const Icon(
                              Icons.calendar_today,
                              size: 20,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.2),
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.3))),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                          controller: _daterangef,
                          onTap: () => _selectDateTime(context, 'one'),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Select to date",
                            suffixIcon: const Icon(
                              Icons.calendar_today,
                              size: 20,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.2),
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.3))),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                          controller: _daterangel,
                          onTap: () => _selectDateTime(context, 'two'),
                        ),
                        // Include your date range selection fields here
                      ],
                    ),
                  if (selectedUnit == 'Yearly')
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedYear,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedYear = newValue!;
                              _daterangef.text = "$newValue-01-01T12:12:50";
                              _daterangel.text = "$newValue-12-31T12:12:50";
                              // Regenerate months when year changes
                            });
                          },
                          items: years
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: '--Choose Role--',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),
                        // Include your yearly selection field here
                      ],
                    ),
                  if (selectedUnit == 'Weekly')
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        TextField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: () {
                            _selectWeek(context);
                          },
                          decoration: InputDecoration(
                            hintText: "select Week",
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.2),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        )
                        // Include your weekly selection field here
                      ],
                    ),
                  if (selectedUnit == 'Monthly')
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: selectedYear,
                          hint: const Text('Select Year'),
                          onChanged: (newValue) {
                            setState(() {
                              selectedYear = newValue;
                              // Reset the selected month when the year changes
                              selectedMonth = null;
                            });
                          },
                          items: years.map((year) {
                            return DropdownMenuItem<String>(
                              value: year,
                              child: Text(year),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: '--Choose Role--',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<int>(
                          value: selectedMonth != null
                              ? int.parse(selectedMonth!)
                              : null,
                          hint: const Text('Select Month'),
                          onChanged: (newValue) {
                            setState(() {
                              selectedMonth =
                                  newValue.toString().padLeft(2, '0');
                            });
                            if (selectedMonth == '01' ||
                                selectedMonth == '03' ||
                                selectedMonth == '05' ||
                                selectedMonth == '07' ||
                                selectedMonth == '08' ||
                                selectedMonth == '10' ||
                                selectedMonth == '12') {
                              _daterangef.text =
                                  '$selectedYear-$selectedMonth-01T12:12:50';
                              _daterangel.text =
                                  '$selectedYear-$selectedMonth-31T12:12:50';
                            } else if (selectedMonth == '04' ||
                                selectedMonth == '06' ||
                                selectedMonth == '09' ||
                                selectedMonth == '11') {
                              _daterangef.text =
                                  '$selectedYear-$selectedMonth-01T12:12:50';
                              _daterangel.text =
                                  '$selectedYear-$selectedMonth-30T12:12:50';
                            } else if (selectedMonth == '02') {
                              // Adjust for leap year for February
                              final daysInFebruary = DateTime(
                                      int.parse(selectedYear!), 2)
                                  .difference(
                                      DateTime(int.parse(selectedYear!), 2, 1))
                                  .inDays;
                              _daterangef.text =
                                  '$selectedYear-$selectedMonth-01T12:12:50';
                              _daterangel.text =
                                  '$selectedYear-$selectedMonth-${daysInFebruary}T12:12:50';
                            }
                          },
                          items: _DAteController.months.where((month) {
                            // Show only months up to the current month if the selected year is the current year
                            if (selectedYear ==
                                DateTime.now().year.toString()) {
                              final currentMonth = DateTime.now().month;
                              final monthIndex =
                                  _DAteController.months.indexOf(month) + 1;
                              return monthIndex <= currentMonth;
                            }
                            return true; // Show all months for previous years
                          }).map((month) {
                            final monthIndex =
                                _DAteController.months.indexOf(month) + 1;
                            return DropdownMenuItem<int>(
                              value: monthIndex,
                              child: Text(month),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: '--Choose Role--',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),
                        // Include your monthly selection fields here
                      ],
                    ),
                ],
              ),

              const Spacer(),
              SizedBox(
                height: 70,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blue, strokeAlign: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.ubuntu(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (SelectedStation != null &&
                              _daterangef.text.isNotEmpty &&
                              _daterangel.text.isNotEmpty) {
                            int id = int.parse(SelectedStation!);

                            widget.onFilterSelected(
                                _daterangef.text, _daterangel.text, id);
                            Navigator.pop(context);
                          } else {
                            toaster().showsToast('Please fill all fields',
                                Colors.red, Colors.white);
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              'Search',
                              style: GoogleFonts.ubuntu(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
