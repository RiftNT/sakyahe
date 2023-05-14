import 'package:flutter/material.dart';
import 'package:sakyahe/widgets/custom_button.dart';
import 'package:sakyahe/screens/driver_register_screen_3.dart';

class DriverRegisterScreen2 extends StatefulWidget {
  const DriverRegisterScreen2({super.key});

  @override
  State<DriverRegisterScreen2> createState() => _DriverRegisterScreen2State();
}

class _DriverRegisterScreen2State extends State<DriverRegisterScreen2> {
  var _value = "-1";
  @override
  Widget build(BuildContext context) {
    Widget VehicleInfo = Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'VEHICLE REGISTRATION',
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
              hintText: "Car Make",
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
          DropdownButtonFormField(
            value: _value,
            decoration: InputDecoration(
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
                  "Select Car Type",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "-1",
              ),
              DropdownMenuItem(
                child: Text(
                  "SUV",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "1",
              ),
              DropdownMenuItem(
                child: Text(
                  "Sedan",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "2",
              ),
              DropdownMenuItem(
                child: Text(
                  "Minivan",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "3",
              ),
              DropdownMenuItem(
                child: Text(
                  "Van",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "4",
              ),
              DropdownMenuItem(
                child: Text(
                  "Micro",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "5",
              ),
              DropdownMenuItem(
                child: Text(
                  "Hatchback",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "6",
              ),
              DropdownMenuItem(
                child: Text(
                  "Pickup",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "7",
              ),
            ],
            onChanged: (v) {},
          ),
          const SizedBox(height: 10),
          TextFormField(
            // controller: textController,
            decoration: InputDecoration(
              hintText: "Car Plate No.",
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
              hintText: "Car Color",
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
              hintText: "Car Capacity",
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
          const SizedBox(height: 15),
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const UploadVehicleRegister(),
              //   ),
              // );
            },
            child: const ListTile(
              leading: Icon(
                Icons.camera_alt_rounded,
                size: 27,
                color: Colors.black26,
              ),
              title: Text(
                'Upload Photo of Vehicle Registration',
                style: TextStyle(fontSize: 13.4, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              textColor: Colors.black54,
              trailing: Icon(
                Icons.check_circle,
                size: 27,
                color: Colors.black26,
              ),
            ),
          ),
          const SizedBox(height: 20),
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
                        const DriverRegisterScreen3(), //temp only
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
        title: const Text('Driver Registration Page 2'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [VehicleInfo],
        ),
      ),
    );
  }
}
