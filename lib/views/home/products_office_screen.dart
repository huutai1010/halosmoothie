import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:halo_smoothie/main.dart';
import 'package:halo_smoothie/models/list_materials.dart';
import 'package:halo_smoothie/models/product.dart';
import 'package:halo_smoothie/providers/list_orders_provider.dart';
import 'package:halo_smoothie/providers/total_price_provider.dart';
import 'package:halo_smoothie/views/cart/cart.dart';
import 'package:halo_smoothie/views/custom_product_screen.dart';
import 'package:halo_smoothie/views/product/product_detail.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../format/format_price.dart';
import '../../models/material.dart';
import '../../models/office.dart';
import '../../models/token.dart';

class ProductsOfficeScreen extends StatelessWidget {
  List<ProductModel> listProductsInTimeDuration;
  List<ProductModel> listRestOfProducts;
  String name;
  String office;

  ProductsOfficeScreen({
    required this.name,
    required this.office,
    required this.listProductsInTimeDuration,
    required this.listRestOfProducts,
  });

  @override
  Widget build(BuildContext context) {
    var officeProvider = Provider.of<OfficeModel>(context, listen: false);
    var _icons = <String>[
      'store',
      'bestseller',
      'coupon',
      'history',
      'payment'
    ];
    var _iconsName = <String>[
      'Store',
      'Bestseller',
      'Coupon',
      'History',
      'Payment'
    ];
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    TopNavigationBar(
                      reRenderBackContext: context,
                    ),
                    SearchBar(),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(officeProvider.img),
                            ),
                          ),
                        ),
                        MenuIcon(icons: _icons, iconsName: _iconsName),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 10,
                          color: Colors.grey.withOpacity(.2),
                        ),
                        ListMenuProductsInTime(
                            name: name,
                            listProductsInTimeDuration:
                                listProductsInTimeDuration),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 10,
                          color: Colors.grey.withOpacity(.2),
                        ),
                        ListRestOfProducts(
                          office: office,
                          listRestOfProducts: listRestOfProducts,
                        ),
                      ]),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'Custom',
            backgroundColor: Colors.brown[200],
            child: Container(
              child: Image.asset('assets/images/customize.png'),
              padding: EdgeInsets.all(10),
            ),
            onPressed: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) {
                    return Center(child: CircularProgressIndicator());
                  });
              List<MaterialModel> listMaterials = [];
              await http.get(
                  Uri.parse(
                      'https://api-halosmoothie.azurewebsites.net/api/materials'),
                  headers: {
                    "Authorization":
                        "Bearer ${Provider.of<TokenModel>(context, listen: false).accessToken}"
                  }).then((materialRepsonse) {
                print("materialResponse = ${materialRepsonse.body}");
                listMaterials =
                    ListMaterials.fromJson(jsonDecode(materialRepsonse.body))
                        .data;
                print('listMaterail = ${listMaterials.length}');
              });
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CustomProductScreen(
                    listMaterials: listMaterials,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 15),
          FloatingActionButton(
            heroTag: 'Cart',
            backgroundColor: Colors.brown[200],
            child: Container(
              child: Image.asset('assets/images/trolley.png'),
              padding: EdgeInsets.all(10),
            ),
            onPressed: () {
              double totalPrice = 0.0;
              for (var e
                  in Provider.of<ListOrdersProvider>(context, listen: false)
                      .orderDetails) {
                totalPrice +=
                    ((e.salePrice > 0 ? e.salePrice : e.price) * e.quantity);
              }
              Provider.of<TotalPriceProvider>(context, listen: false)
                  .totalPrice = totalPrice;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartPage(totalPrice: totalPrice),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MenuIcon extends StatelessWidget {
  MenuIcon(
      {super.key,
      required List<String> icons,
      required List<String> iconsName,
      required})
      : _icons = icons,
        _iconsName = iconsName;

  final List<String> _icons;
  final List<String> _iconsName;
  List<MaterialModel> listMaterials = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: new List.generate(
            _icons.length,
            (index) => GestureDetector(
              onTap: () async {
                // if (index == 0) {
                //   await http.get(
                //       Uri.parse(
                //           'https://api-halosmoothie.azurewebsites.net/api/materials'),
                //       headers: {
                //         "Authorization":
                //             "Bearer ${Provider.of<TokenModel>(context, listen: false).accessToken}"
                //       }).then((materialRepsonse) {
                //     print("materialResponse = ${materialRepsonse.body}");
                //     listMaterials = ListMaterials.fromJson(
                //             jsonDecode(materialRepsonse.body))
                //         .data;
                //     print('listMaterail = ${listMaterials.length}');
                //   });
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (_) => CustomProductScreen(
                //                 listMaterials: listMaterials,
                //               )));
                // }
              },
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/${_icons[index]}.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(_iconsName[index], style: TextStyle(fontSize: 10))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopNavigationBar extends StatelessWidget {
  BuildContext reRenderBackContext;
  TopNavigationBar({required this.reRenderBackContext});

  @override
  Widget build(BuildContext topNavBarContext) {
    var officeProvider =
        Provider.of<OfficeModel>(topNavBarContext, listen: false);
    return Container(
      width: MediaQuery.of(topNavBarContext).size.width,
      height: MediaQuery.of(topNavBarContext).size.height * .06,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  onTap: () => Navigator.popUntil(reRenderBackContext,
                      (route) => route.settings.name == Routes.firstPage),
                  child: Container(
                    width: MediaQuery.of(topNavBarContext).size.width * .08,
                    height: MediaQuery.of(topNavBarContext).size.width * .08,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/back-arrow.png'),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Location', style: TextStyle(fontSize: 13)),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/pin.png'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(topNavBarContext).size.width * .8,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          '${officeProvider.address}',
                          style: TextStyle(fontSize: 13),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext searchBarContext) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: MediaQuery.of(searchBarContext).size.width * .95,
            height: MediaQuery.of(searchBarContext).size.width * .1,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(5)),
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey.withOpacity(.6),
                ),
                Text('Search product',
                    style: TextStyle(color: Colors.grey.withOpacity(.6)))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ListMenuProductsInTime extends StatelessWidget {
  String name;
  List<ProductModel> listProductsInTimeDuration;
  ListMenuProductsInTime({
    required this.name,
    required this.listProductsInTimeDuration,
  });
  @override
  Widget build(BuildContext listMenuProductsInTimeContext) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(listMenuProductsInTimeContext).size.width,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 10),
                child: Text(
                  'SALE PRODUCT IN TIME 🤩',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.red[400],
                      fontSize: 13),
                ),
              ),
              Spacer()
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                listProductsInTimeDuration.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.02),
                    color: Colors.grey.withOpacity(.05),
                  ),
                  child: GestureDetector(
                      onTap: () {
                        ProductModel productInfo =
                            listProductsInTimeDuration[index];
                        Navigator.push(
                          listMenuProductsInTimeContext,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(
                                id: productInfo.id,
                                img: productInfo.img,
                                name: productInfo.name,
                                price: productInfo.price,
                                salePrice: productInfo.salePrice,
                                desc: productInfo.descs),
                          ),
                        );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(
                                              listMenuProductsInTimeContext)
                                          .size
                                          .height *
                                      .15,
                                  height: MediaQuery.of(
                                              listMenuProductsInTimeContext)
                                          .size
                                          .height *
                                      .15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          listProductsInTimeDuration[index]
                                              .img),
                                    ),
                                  ),
                                ),
                                (listProductsInTimeDuration[index].salePrice >
                                        0)
                                    ? Container(
                                        width: 40,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10))),
                                        child: Text(
                                          'Sale',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 5),
                              child: Text(
                                listProductsInTimeDuration[index].name,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                '${listProductsInTimeDuration[index].salePrice > 0 ? oCcy.format(listProductsInTimeDuration[index].salePrice.toInt()).split('VND')[0] : oCcy.format(listProductsInTimeDuration[index].price.truncate()).split('VND')[0]}đ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red[400],
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListRestOfProducts extends StatelessWidget {
  String office;
  List<ProductModel> listRestOfProducts;
  ListRestOfProducts({
    required this.office,
    required this.listRestOfProducts,
  });

  @override
  Widget build(BuildContext listRestOfProductContext) {
    // var restProductProvider =
    //     Provider.of<ListRestProduct>(listRestOfProductContext, listen: false);
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15.0),
                child: Container(
                  child: Text(
                    'ALL PRODUCTS IN OFFICE 😆',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red[400],
                        fontSize: 13),
                  ),
                ),
              ),
              Spacer()
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: List.generate(
                listRestOfProducts.length,
                (index) => GestureDetector(
                  onTap: () {
                    ProductModel productInfo = listRestOfProducts[index];

                    Navigator.push(
                      listRestOfProductContext,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(
                          id: productInfo.id,
                          img: productInfo.img,
                          name: productInfo.name,
                          price: productInfo.price,
                          salePrice: productInfo.salePrice,
                          desc: productInfo.descs,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                    ),
                    width: MediaQuery.of(listRestOfProductContext).size.width,
                    height:
                        MediaQuery.of(listRestOfProductContext).size.height *
                            .13,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Stack(
                              alignment: AlignmentDirectional.topStart,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 15,
                                  ),
                                  width: MediaQuery.of(listRestOfProductContext)
                                          .size
                                          .height *
                                      .11,
                                  height:
                                      MediaQuery.of(listRestOfProductContext)
                                              .size
                                              .height *
                                          .11,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          listRestOfProducts[index].img),
                                    ),
                                  ),
                                ),
                                (listRestOfProducts[index].salePrice > 0)
                                    ? Container(
                                        alignment: Alignment.center,
                                        margin:
                                            EdgeInsets.only(left: 10, top: 5),
                                        width: 33,
                                        height: 20,
                                        child: Text(
                                          'Sale',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            )),
                                      )
                                    : Container()
                              ]),
                          Container(
                            margin:
                                EdgeInsets.only(left: 15, top: 5, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(listRestOfProductContext)
                                          .size
                                          .width *
                                      .65,
                                  height:
                                      MediaQuery.of(listRestOfProductContext)
                                              .size
                                              .height *
                                          .05,
                                  child: Text(
                                    '⭐️${listRestOfProducts[index].name}',
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange[300],
                                      size: 14,
                                    ),
                                    Text('4.7',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12)),
                                    VerticalDivider(
                                      color: Colors.grey, //color of divider
                                      width: 10, //width space of divider
                                      thickness: 3, //thickness of divier line
                                      indent:
                                          10, //Spacing at the top of divider.
                                      endIndent:
                                          10, //Spacing at the bottom of divider.
                                    ),
                                    Text(
                                      office,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                    '${listRestOfProducts[index].salePrice > 0 ? oCcy.format(listRestOfProducts[index].salePrice.toInt()).split('VND')[0] : oCcy.format(listRestOfProducts[index].price.truncate()).split('VND')[0]}đ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red[400],
                                        fontSize: 14))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
