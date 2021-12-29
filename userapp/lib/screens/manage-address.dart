import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

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
  double _lat = 13.0827;
  double _lng = 80.2707;

  Completer<GoogleMapController> _controller = Completer();

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
    generateAddress(_lat, _lng);
  }

  generateAddress(lat, lng) async {
    List<Placemark> placemarkers = await placemarkFromCoordinates(lat, lng);
    print(placemarkers[0].thoroughfare);

    var addressText =
        "${placemarkers[0].subThoroughfare}, ${placemarkers[0].thoroughfare}, ${placemarkers[0].subLocality}, ${placemarkers[0].locality}";

    _addressCtrl.text = addressText;
    _pinCtrl.text = placemarkers[0].postalCode.toString();
  }

  fetchMyLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      print("Service error");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Permission Error");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Permission deinied forever");
    }

    await Geolocator.getCurrentPosition().then((res) async {
      final GoogleMapController controller = await _controller.future;

      final _position = CameraPosition(
        target: LatLng(res.latitude, res.longitude),
        zoom: 12,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(_position));
      setState(() {
        _lat = res.latitude;
        _lng = res.longitude;
      });
      generateAddress(_lat, _lng);
    });
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
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(_lat, _lng),
                  zoom: 12,
                ),
                onMapCreated: (res) {
                  _controller.complete(res);
                  fetchMyLocation();
                },
                markers: {
                  Marker(
                      markerId: MarkerId("current"),
                      position: LatLng(_lat, _lng),
                      draggable: true,
                      onDragEnd: (latlng) {
                        generateAddress(latlng.latitude, latlng.longitude);
                      })
                },
              ),
              height: 280,
            ),
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
