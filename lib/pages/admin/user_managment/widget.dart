// ignore_for_file: must_be_immutable, non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';

class CustomeField extends StatelessWidget {
  final String Title;
  final bool read;
  // final String lableText;
  final TextEditingController Controller;

  const CustomeField({
    required this.Controller,
    required this.read,
    // required this.lableText,
    required this.Title,
    Key? key,
    // required String? Function(dynamic value) validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 71,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Title),
          const SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextField(
              controller: Controller,
              readOnly: read,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.2),
                    borderSide: const BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.lightBlue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class passwordfield extends StatefulWidget {
  final String Title;

  bool show;

  final TextEditingController Controller;

  passwordfield({
    required this.Controller,
    required this.show,
    required this.Title,
    Key? key,
  }) : super(key: key);

  @override
  State<passwordfield> createState() => _passwordfieldState();
}

class _passwordfieldState extends State<passwordfield> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 71,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.Title),
          const SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextField(
              controller: widget.Controller,
              obscureText: widget.show ? true : false,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.show = !widget.show;
                      });
                    },
                    icon: Icon(
                        widget.show ? Icons.visibility : Icons.visibility_off)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.2),
                    borderSide: const BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.lightBlue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomeField2 extends StatelessWidget {
  final String Title;
  // final String lableText;
  final TextEditingController Controller;

  const CustomeField2({
    required this.Controller,
    // required this.lableText,
    required this.Title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Title),
          const SizedBox(
            height: 3,
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                readOnly: true,
                controller: Controller,
                decoration: const InputDecoration(
                  // labelText: lableText,
                  // hintText: hint,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  border: InputBorder.none,
                  // OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(20)))
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CaliDetaDrop extends StatefulWidget {
  String? valuee;
  final List<String> list;

  CaliDetaDrop({Key? key, required this.valuee, required this.list})
      : super(key: key);

  @override
  State<CaliDetaDrop> createState() => _CaliDetaDropState();
}

class _CaliDetaDropState extends State<CaliDetaDrop> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.valuee;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,
      items: widget.list.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedValue = newValue!;
        });
      },
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
