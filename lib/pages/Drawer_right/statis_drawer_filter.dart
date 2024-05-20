// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:Tems/config/data.dart';

import '../widget/toast.dart';

class StaticticDrawerFilter extends StatefulWidget {
  final Function(String, String, int) onFilterSelected;
  const StaticticDrawerFilter({super.key, required this.onFilterSelected});

  @override
  State<StaticticDrawerFilter> createState() => _StaticticDrawerFilterState();
}

class _StaticticDrawerFilterState extends State<StaticticDrawerFilter> {
  final MultiSelectController _controller = MultiSelectController();
  final MultiSelectController _paracontroller = MultiSelectController();
  final TextEditingController _firstDate = TextEditingController();
  final TextEditingController _SecondDate = TextEditingController();
  String? SelectedStation;
  List<ValueItem>? selectedStation;
  List<ValueItem>? selectedParameter;
  List<String> parameter = [
    'Water Temprature',
    'Specific Conductance',
    'Salinity',
    'pH',
    'Dissolved Oxygen Saturation',
    'Turbidity',
    'Dissolved Oxygen',
    'tds',
    'Chlorophyll',
    'Depth',
    'Oxygen Reduction Potential',
    'External Voltage'
  ];
  List<ValueItem> iTems = Data.stationNameswithId
      .map((e) => ValueItem(label: e['name'], value: e['id'].toString()))
      .toList();
  List<ValueItem> iTems2 =
      Data.parameter.map((e) => ValueItem(label: e, value: e)).toList();

  DateTime? _selectedDateTime;
  TimeOfDay? pickedTime;
  Future<void> _selectDateTime(BuildContext context, String find) async {
    final DateTime now = DateTime.now();
    final DateTime firstSelectableDate = now.subtract(const Duration(days: 31));
    final DateTime lastSelectableDate = now;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate:
          Data.role == 'ROLE_ADMIN' ? DateTime(2000) : firstSelectableDate,
      lastDate: lastSelectableDate,
      selectableDayPredicate: (DateTime date) {
        return
            // date.isAfter(firstSelectableDate)
            // &&
            date.isBefore(lastSelectableDate);
      },
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      );
      // ignore: unnecessary_null_comparison
      if (pickedDate != null) {
        setState(() {
          _selectedDateTime = DateTime(pickedDate.year, pickedDate.month,
              pickedDate.day, pickedTime!.hour, pickedTime.minute);
          if (find == 'one') {
            _firstDate.text =
                "${_selectedDateTime!.year}-${_selectedDateTime!.month.toString().padLeft(2, '0')}-${_selectedDateTime!.day.toString().padLeft(2, '0')}T${_selectedDateTime!.hour}:${_selectedDateTime!.minute}:50";
          } else if (find == 'two') {
            _SecondDate.text =
                "${_selectedDateTime!.year}-${_selectedDateTime!.month.toString().padLeft(2, '0')}-${_selectedDateTime!.day.toString().padLeft(2, '0')}T${_selectedDateTime!.hour}:${_selectedDateTime!.minute}:50";
          }
          // Format the selected date as a string with only the date part
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    selectedStation = [iTems.first];
    selectedParameter = [iTems2.first];
  }

  bool istick = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // physics: const NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                    title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Advance Filtering'),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Stations*'),
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
                      selectedOptions: istick ? iTems : [],
                      showChipInSingleSelectMode: true,
                      selectedOptionIcon: const Icon(Icons.check_circle),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          istick = !istick;
                        });
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: istick ? Colors.blue : Colors.grey,
                                strokeAlign: 1)),
                        child: Center(
                          child: istick
                              ? const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.blue,
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'All Station',
                      style: GoogleFonts.ubuntu(fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Select Start Date",
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                      size: 20,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.2),
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.3))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.lightBlue),
                    ),
                  ),
                  controller: _firstDate,
                  onTap: () => _selectDateTime(context, 'one'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Select To Date",
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                      size: 20,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.2),
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.3))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.lightBlue),
                    ),
                  ),
                  controller: _SecondDate,
                  onTap: () => _selectDateTime(context, 'two'),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Parameters*'),
                      MultiSelectDropDown(
                        showClearIcon: true,
                        controller: _paracontroller,
                        onOptionSelected: (options) {
                          debugPrint(options.toString());
                        },
                        options: iTems2,
                        backgroundColor: Colors.white10,
                        selectionType: SelectionType.multi,
                        chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                        dropdownHeight: 300,
                        optionTextStyle: GoogleFonts.ubuntu(fontSize: 16),
                        showChipInSingleSelectMode: true,
                        selectedOptionIcon: const Icon(Icons.check_circle),
                        selectedOptions: selectedParameter!,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
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
                            border:
                                Border.all(color: Colors.blue, strokeAlign: 1),
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
                            _firstDate.text.isNotEmpty &&
                            _SecondDate.text.isNotEmpty) {
                          int id = int.parse(SelectedStation!);
                          widget.onFilterSelected(
                              _firstDate.text, _SecondDate.text, id);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
