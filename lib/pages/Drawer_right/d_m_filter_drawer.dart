// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DMFDrawer extends StatefulWidget {
  const DMFDrawer({super.key});

  @override
  State<DMFDrawer> createState() => _DMFDrawerState();
}

class _DMFDrawerState extends State<DMFDrawer> {
  final TextEditingController _firstDate = TextEditingController();
  final TextEditingController _SecondDate = TextEditingController();
  String Station = 'WQ 1';
  final List<String> _items = ['WQ 1', 'Bhitarkanika Nation Park'];

  DateTime? _selectedDateTime;
  Future<void> _selectDateTime(BuildContext context, String find) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      );
      setState(() {
        _selectedDateTime = DateTime(pickedDate.year, pickedDate.month,
            pickedDate.day, pickedTime!.hour, pickedTime.minute);
        if (find == 'one') {
          _firstDate.text =
              "${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year}  ${_selectedDateTime!.hour}:${_selectedDateTime!.minute}";
        } else if (find == 'two') {
          _SecondDate.text =
              "${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year}  ${_selectedDateTime!.hour}:${_selectedDateTime!.minute}";
        }
        // Format the selected date as a string with only the date part
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: ListView(
                  children: [
                    ListTile(
                        title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Data QA'),
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
                    Drop('Station', Station, _items, (p0) {
                      setState(() {
                        Station = p0!;
                      });
                    }),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('From Date*'),
                        TextField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            // labelText: 'From Date*',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          controller: _firstDate,
                          onTap: () => _selectDateTime(context, 'one'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('To Date*'),
                        TextField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            // labelText: 'To Date*',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          controller: _SecondDate,
                          onTap: () => _selectDateTime(context, 'two'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
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
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
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

  Widget Drop(
    String title,
    String? selectedValue,
    List<String> list,
    void Function(String?)? onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        DropdownButtonFormField<String>(
          value: selectedValue,
          items: list.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          isExpanded: true,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
            ),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ],
    );
  }
}
