import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:sakyahe/widgets/custom_button.dart';
import 'package:sakyahe/screens/driver_register_screen_2.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DriverRegisterScreen extends StatefulWidget {
  const DriverRegisterScreen({super.key});

  @override
  State<DriverRegisterScreen> createState() => _DriverRegisterScreenState();
}

class _DriverRegisterScreenState extends State<DriverRegisterScreen> {
  var _value = "-1";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  TextEditingController _date = TextEditingController();
  Country selectedCountry = Country(
    phoneCode: "63",
    countryCode: "PH",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Philippines",
    example: "Philippines",
    displayName: "Philippines",
    displayNameNoCountryCode: "PH",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    Widget AboutDriver = Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      child: Column(
        children: [
          Align(
            //buggy, dili mu back(?); mu error nig back
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'TELL US ABOUT YOURSELF',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left, //idk ngano di mu left side
          ),
          const SizedBox(height: 20),
          TextFormField(
            // controller: textController,
            decoration: InputDecoration(
              hintText: "First Name",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.grey.shade600),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            // controller: textController,
            decoration: InputDecoration(
              hintText: "Middle Name",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.grey.shade600),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            // controller: textController,
            decoration: InputDecoration(
              hintText: "Last Name",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.grey.shade600),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: TextFormField(
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: phoneController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Phone number cannot be empty";
                } else if (value.length != 10) {
                  return "Phone number must be exactly 10 digits";
                } else {
                  return null;
                }
              },
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (value) {
                setState(() {
                  phoneController.text = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Enter your phone number",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.grey.shade600),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                prefixIcon: Container(
                  padding: const EdgeInsets.all(22.0),
                  child: InkWell(
                    child: Text(
                      "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                      style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                suffixIcon: phoneController.text.length > 9
                    ? Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                        child: const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _date,
            decoration: InputDecoration(
              hintText: "Birth Date",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.grey.shade600),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              suffixIcon: Container(
                height: 30,
                width: 30,
                margin: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: const Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.black54,
                  size: 20,
                ),
              ),
            ),
            onTap: () async {
              DateTime? pickeddate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2101));

              if (pickeddate != null) {
                setState(() {
                  _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                });
              }
            },
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField(
            value: _value,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.grey.shade600),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12),
              ),
            ),
            items: const [
              DropdownMenuItem(
                child: Text(
                  "Select Gender",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "-1",
              ),
              DropdownMenuItem(
                child: Text(
                  "Male",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "1",
              ),
              DropdownMenuItem(
                child: Text(
                  "Female",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "2",
              ),
            ],
            onChanged: (v) {},
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: CustomButton(
              text: "Next",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const DriverRegisterScreen2(), //temp only
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Registration'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [AboutDriver],
        ),
      ),
    );
  }
}
