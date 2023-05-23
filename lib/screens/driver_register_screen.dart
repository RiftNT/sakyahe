import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:sakyahe/widgets/custom_button.dart';
import 'package:sakyahe/screens/driver_register_screen_2.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DriverRegisterScreen extends StatefulWidget {
  const DriverRegisterScreen({Key? key}) : super(key: key);

  @override
  State<DriverRegisterScreen> createState() => _DriverRegisterScreenState();
}

class _DriverRegisterScreenState extends State<DriverRegisterScreen> {
  var _value = "-1";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController _date = TextEditingController();
  String selectedGender = "-1";

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
          const SizedBox(height: 20),
          const Text(
            'TELL US ABOUT YOURSELF',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                TextFormField(
                  controller: firstNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "First Name",
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: middleNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your middle name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Middle Name",
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: lastNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Last Name",
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
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
                      phoneController.value = phoneController.value.copyWith(
                        text: value,
                        selection:
                            TextSelection.collapsed(offset: value.length),
                      );
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your phone number",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.only(top: 12, right: 10),
                      child: InkWell(
                        child: Text(
                          "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    suffixIcon: phoneController.text.length > 9
                        ? Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        birthDateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: birthDateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Birth date is required';
                        }

                        DateTime birthDate =
                            DateFormat('yyyy-MM-dd').parse(value);
                        DateTime today = DateTime.now();
                        int age = today.year - birthDate.year;

                        if (today.month < birthDate.month ||
                            (today.month == birthDate.month &&
                                today.day < birthDate.day)) {
                          age--;
                        }

                        if (age < 21) {
                          return 'You must be at least 21 years old to register as a driver';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Birth Date',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                        suffixIcon: Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.black54,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  value: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value.toString();
                    });
                  },
                  validator: (value) {
                    if (value == "-1") {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                  items: const [
                    DropdownMenuItem(
                      value: "-1",
                      child: Text(
                        "Select Gender",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Male",
                      child: Text(
                        "Male",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Female",
                      child: Text(
                        "Female",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: CustomButton(
                    bgColor: Colors.blue,
                    textColor: Colors.white,
                    text: "Next",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DriverRegisterScreen2(
                              firstName: firstNameController.text,
                              middleName: middleNameController.text,
                              lastName: lastNameController.text,
                              phoneNumber: "+63${phoneController.text}",
                              birthDate: birthDateController.text,
                              gender: selectedGender,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Registration'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [AboutDriver],
        ),
      ),
    );
  }
}
