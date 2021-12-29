import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/address.dart';

class ManageAddressScreen extends StatefulWidget {
  bool canEdit = false;
  var address = {};
  ManageAddressScreen({
    Key? key,
    required this.canEdit,
    required this.address,
  }) : super(key: key);

  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  AddressController _addressController = Get.put(AddressController());

  TextEditingController _tagCtrl = TextEditingController();
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  TextEditingController _addressCtrl = TextEditingController();
  TextEditingController _pinCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.canEdit) {
      _tagCtrl.text = widget.address["tag"];
      _nameCtrl.text = widget.address["name"];
      _mobileCtrl.text = widget.address["mobile"];
      _addressCtrl.text = widget.address["address"];
      _pinCtrl.text = widget.address["pincode"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.canEdit ? 'Edit' : 'Add'} Address"),
        actions: [
          widget.canEdit
              ? IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _addressController.deleteAddress(widget.address["id"]);
                  })
              : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                child: Image.asset(
                  "assets/images/map.png",
                  fit: BoxFit.cover,
                ),
                height: 200,
                width: double.infinity),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(children: [
                TextField(
                  controller: _tagCtrl,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                      labelText: "Tag (Eg. Home, Office)"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                      labelText: "Name"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _mobileCtrl,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                      labelText: "Mobile Number"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _addressCtrl,
                  maxLines: 4,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                      labelText: "Address"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _pinCtrl,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                      labelText: "Pincode"),
                ),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    child: Text("Save Changes"),
                    onPressed: () {
                      widget.canEdit
                          ? _addressController
                              .updateAddress(widget.address["id"], {
                              "tag": _tagCtrl.text,
                              "name": _nameCtrl.text,
                              "mobile": _mobileCtrl.text,
                              "address": _addressCtrl.text,
                              "pincode": _pinCtrl.text
                            })
                          : _addressController.addAddress({
                              "tag": _tagCtrl.text,
                              "name": _nameCtrl.text,
                              "mobile": _mobileCtrl.text,
                              "address": _addressCtrl.text,
                              "pincode": _pinCtrl.text
                            });
                    },
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
