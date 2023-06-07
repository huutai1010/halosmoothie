// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/list_products_intime.dart';
import 'package:halo_smoothie/models/list_rest_products.dart';
import 'package:halo_smoothie/models/product.dart';
import 'package:halo_smoothie/models/token.dart';
import 'package:halo_smoothie/views/home/products_office_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../models/office.dart';

class OfficeScannerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OfficeScannerPageState();
  dynamic result = {
    "id": 0,
    "name": "",
    "address": "",
    "phone": "",
    "img": "",
    "status": 0
  };
}

class _OfficeScannerPageState extends State<OfficeScannerPage> {
  @override
  Widget build(BuildContext officeScannerPageContext) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Mobile Scanner')),
      body: Stack(children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .6,
                height: MediaQuery.of(context).size.width * .6,
                child: Lottie.network(
                    'https://assets7.lottiefiles.com/packages/lf20_jr1k17sk.json'),
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * .5,
                  height: MediaQuery.of(context).size.height * .05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orange.withOpacity(.6),
                  ),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Flexible(child: QRCodeScanner()),
                        Text(
                          'Scan qrcode',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  //scanQRCode(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => QRCodeScanner(),
                          settings: RouteSettings(name: '/scan')));
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class QRCodeScanner extends StatelessWidget {
  MobileScannerController cameraController = MobileScannerController();
  List<ProductModel> listProductsInTimeDuration = [];
  List<ProductModel> listRestOfProduct = [];
  String name = '';
  String office = '';

  @override
  Widget build(BuildContext context) {
    var officeProvider = Provider.of<OfficeModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Mobile Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (capture) async {
          officeProvider.resetOfficeProvider();
          final List<Barcode> barcodes = capture.barcodes;
          //final Uint8List? image = capture.image;
          print('=====>barcode size = ${barcodes.length}');
          for (final barcode in barcodes) {
            debugPrint('Barcode found! ${barcode.rawValue}');
            var officeModel =
                OfficeModel.fromJson(jsonDecode(barcode.rawValue!));
            office = officeModel.name;
            officeProvider.changeOfficeData(
              officeModel.id,
              officeModel.name,
              officeModel.address,
              officeModel.phone,
              officeModel.img,
              officeModel.status,
            );
            print("officeModel Id = ${officeModel.id}");

            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return Center(child: CircularProgressIndicator());
                });
            //Get list product in time duration
            late int menuId;
            await http.get(
                Uri.parse(
                    'https://api-halosmoothie.azurewebsites.net/api/menus/offices/${officeProvider.id}'),
                headers: {
                  "Authorization":
                      "Bearer ${Provider.of<TokenModel>(context, listen: false).accessToken}"
                }).then((productsInTimeResonse) {
              print('productInTimeResponse = ${productsInTimeResonse.body}');
              ListProductsInTime list = ListProductsInTime.fromJSON(
                  jsonDecode(productsInTimeResonse.body));
              this.name = list.name;
              listProductsInTimeDuration = list.products;
              //----Set up data for list products in time provider
              Provider.of<ListProductsInTime>(context, listen: false)
                  .updateListProducts(list.id, list.products);
              menuId =
                  Provider.of<ListProductsInTime>(context, listen: false).id;
              print(
                  'products in time size = ${listProductsInTimeDuration.length}');
            }); // Wait time for loading data

            //Get list rest of products
            await http.get(
                Uri.parse(
                    'https://api-halosmoothie.azurewebsites.net/api/products/menus/$menuId?inMenu=false'),
                headers: {
                  "Authorization":
                      "Bearer ${Provider.of<TokenModel>(context, listen: false).accessToken}"
                }).then((restProductResponse) {
              print('restProductResponse = ${restProductResponse.body}');
              ListRestProduct list = ListRestProduct.fromJSON(
                jsonDecode(restProductResponse.body),
              );
              listRestOfProduct = list.data;

              print('rest products size= ${listRestOfProduct.length}');
            }); // Wait time for loading data
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductsOfficeScreen(
                  name: name,
                  office: office,
                  listProductsInTimeDuration: listProductsInTimeDuration,
                  listRestOfProducts: listRestOfProduct,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
