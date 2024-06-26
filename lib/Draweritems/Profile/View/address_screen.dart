import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controllers/user_address_controller/user_address_controller.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  UserAddressController userAddressController = UserAddressController();
  @override
  void initState() {
    userAddressController.getUserAddress();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
