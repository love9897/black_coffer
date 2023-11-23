import 'package:flutter/material.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../provider/login_provider.dart';

// import 'package:provider/provider.dart';

// import '../provider/login_provider.dart';

class Myphone extends StatefulWidget {
  const Myphone({super.key});

  @override
  State<Myphone> createState() => _MyphoneState();
}

class _MyphoneState extends State<Myphone> {
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    dynamic phonenumber;

    final otp = Provider.of<OtpProvider>(context);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('images/img1.gif', width: 150, height: 150),
                const SizedBox(height: 45),
                const Text("Login",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 25),
                Form(
                  key: formkey,
                  child: IntlPhoneField(
                    autovalidateMode: AutovalidateMode.disabled,
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      formkey.currentState!.validate();
                      phonenumber = phone.completeNumber;
                    },
                    decoration: InputDecoration(
                      labelText: "Phone",
                      hintText: "Phone Number",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      otp.verifyPhone(phonenumber);
                      // Navigator.pushNamed(context, 'otp',
                      //     arguments: phonenumber);
                    }
                  },
                  child: Container(
                    width: 120,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 38),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25)),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
