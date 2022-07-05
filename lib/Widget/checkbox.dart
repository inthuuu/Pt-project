// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'package:drone_for_smart_farming/service/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/Service.dart';

class ServiceState extends StatefulWidget {
  const ServiceState({Key? key}) : super(key: key);

  @override
  State<ServiceState> createState() => _ServiceStateState();
}

class _ServiceStateState extends State<ServiceState> {
  @override
  Widget build(BuildContext context) {
    ManageService provider = Provider.of<ManageService>(context);
    var Service = provider.getService();
    return Consumer(builder: (context, ManageService provider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.23,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 15),
            children: [...Service.map(buildSingleCheckbox).toList()],
          ),
        ),
      );
    });
  }

  Widget buildSingleCheckbox(Service services) {
    return buildCheckbox(
        services: services,
        onClicked: () {
          setState(() {
            services.value = !services.value;
          });
        });
  }

  Widget buildCheckbox(
      {required Service services, required VoidCallback onClicked}) {
    return ListTile(
      onTap: onClicked,
      leading: Checkbox(
          activeColor: Color(0xff2f574b),
          value: services.value,
          onChanged: (value) => onClicked()),
      title: Text(
        services.name,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
