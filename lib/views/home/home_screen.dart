import 'package:flutter/material.dart';
import 'package:halo_smoothie/views/product/list_products.dart';
import 'package:halo_smoothie/views/product/product_detail.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../providers/list_product_provider.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final String topOfficeBackground;
  var isLoading = true;

  HomePage({required this.topOfficeBackground});

  var _icons = <String>[
    'store',
    'material',
    'bestseller',
    'coupon',
    'history',
    'payment'
  ];
  var _iconsName = <String>[
    'Store',
    'Material',
    'Bestseller',
    'Coupon',
    'History',
    'Payment'
  ];

  @override
  Widget build(BuildContext mainContext) {
    final topBackgroundHeight = MediaQuery.of(mainContext).size.height * .25;
    final screenWidth = MediaQuery.of(mainContext).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: screenWidth,
                height: topBackgroundHeight,
                decoration: BoxDecoration(
                  color: Colors.red[400],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(topOfficeBackground),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child: Container(
                    margin: EdgeInsets.only(top: 40), // Need modifying
                    child: Column(children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: (screenWidth - screenWidth * .9) * .5,
                                right: 10),
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/pin.png'),
                              ),
                            ),
                          ),
                          Text(
                            'Location: FPT University, Long Thanh My Ward, HCM City ',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30, bottom: 15),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: new List.generate(
                              _icons.length,
                              (index) => GestureDetector(
                                onTap: () => print('Pressed Icon'),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/${_icons[index]}.png'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(_iconsName[index],
                                        style: TextStyle(fontSize: 10))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                            ListMenuProduct(),
                            ListMenuProduct(),
                            ListMenuProduct(),
                          ]),
                        ),
                      )
                    ]),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: topBackgroundHeight - topBackgroundHeight * 0.2 * 0.5,
            left: (screenWidth - screenWidth * .9) * .5,
            child: Container(
              width: screenWidth * .9,
              height: topBackgroundHeight * .2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  )
                ],
              ),
              child: Row(children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.search)),
                Text('Search your product')
              ]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(mainContext).size.height * .08,
                left: MediaQuery.of(mainContext).size.width * .05),
            child: Row(children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(mainContext),
                child: Container(
                  width: 40,
                  height: 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/left-arrow.png'),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      mainContext, MaterialPageRoute(builder: (_) => Center()));
                },
                child: Container(
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white38, shape: BoxShape.circle),
                  child: Image.asset('assets/images/shopping-cart.png'),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ListMenuProduct extends StatelessWidget {
  var isLoading = true;

  ListMenuProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var listProductProvider =
        Provider.of<ListProductsProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Morning Product 🤩',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Enjoy your morning smoothie',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ListProductPage())),
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 15),
                width: 80,
                height: 30,
                child: Text(
                  'See More',
                  style: TextStyle(color: Colors.amber[900], fontSize: 11),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.orange[200]?.withOpacity(.3)),
              ),
            ),
          ]),
          listProductProvider.listProducts.length > 0
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: new List.generate(
                      listProductProvider.listProducts.length,
                      (index) => Container(
                        margin: EdgeInsets.only(top: 15, left: 30),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProductDetailPage(
                                          id: 0,
                                          img: '',
                                          name: '',
                                          price: 0,
                                          salePrice: 0,
                                          desc: '',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .55,
                                    height: MediaQuery.of(context).size.height *
                                        .15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          listProductProvider
                                              .listProducts[index].img,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  listProductProvider.listProducts[index].name,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  '15 minutes for making',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w200),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: new List.generate(
                      2,
                      (index) => Container(
                        margin: EdgeInsets.only(top: 15, left: 30),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[],
                            ),
                            Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(.9),
                                highlightColor: Colors.grey.withOpacity(.4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .55,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(.4),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .25,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.4),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.4),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
