import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/list_coupon.dart';
import 'package:halo_smoothie/models/list_order_material.dart';
import 'package:halo_smoothie/models/office.dart';
import 'package:halo_smoothie/providers/final_color_provider.dart';
import 'package:halo_smoothie/providers/list_orders_provider.dart';
import 'package:halo_smoothie/services/local_notification_service.dart';

import 'package:halo_smoothie/views/cart/payment.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import '../../format/format_price.dart';
import '../../models/list_products_intime.dart';
import '../../models/profile.dart';
import '../../models/token.dart';
import '../../providers/total_price_provider.dart';

// ignore: must_be_immutable
class CartPage extends StatefulWidget {
  double totalPrice;
  double couponDiscount = 1;
  int? coupon;
  double priceAfterUseCoupon = 0.0;
  double stablePrice = 0.0;
  int paymentId = 1;
  String paymentMethod = '';
  int couponPercentage = 0;

  CartPage({required this.totalPrice});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<ListOrdersProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Row(children: <Widget>[
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/left-arrow.png'),
                              ),
                            ),
                          ),
                          onTap: () => Navigator.pop(context),
                        ),
                        Spacer(),
                        Text(
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 0.1,
                              fontWeight: FontWeight.w400),
                          'CART',
                        ),
                      ]),
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .55,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    orderProvider.orderDetails.length,
                    (index) => Column(
                      children: [
                        CartProductItem(
                          name: orderProvider.orderDetails[index].name,
                          price: orderProvider.orderDetails[index].price,
                          salePrice:
                              orderProvider.orderDetails[index].salePrice,
                          img: orderProvider.orderDetails[index].img,
                          quantity: orderProvider.orderDetails[index].quantity,
                          priceAfterUseCoupon: widget.priceAfterUseCoupon,
                          index: index,
                          totalPriceContext: context,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Payment method',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          ' ${widget.paymentMethod}',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: ListView(children: [
                            OutlinedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                side: MaterialStateProperty.all(
                                  BorderSide(style: BorderStyle.none),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  widget.paymentId = 1;
                                  widget.paymentMethod = 'Cash';
                                });
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.attach_money,
                                      size: 40, color: Colors.green),
                                  Text(
                                    'Cash',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                side: MaterialStateProperty.all(
                                  BorderSide(style: BorderStyle.none),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  widget.paymentId = 3;
                                  widget.paymentMethod = 'VNPay';
                                });
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                'https://play-lh.googleusercontent.com/o-_z132f10zwrco4NXk4sFqmGylqXBjfcwR8-wK0lO1Wk4gzRXi4IZJdhwVlEAtpyQ=w600-h300-pc0xffffff-pd'))),
                                  ),
                                  Text(
                                    ' VNPay',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        );
                      },
                    );
                  },
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Coupon ',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${widget.couponPercentage != 0 ? '${widget.couponPercentage}%' : ''}',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  onTap: () async {
                    await http.get(
                        Uri.parse(
                            'https://api-halosmoothie.azurewebsites.net/user/coupon'),
                        headers: {
                          "Authorization":
                              "Bearer ${Provider.of<TokenModel>(context, listen: false).accessToken}",
                        }).then((couponResponse) {
                      print("couponResponse = ${couponResponse.body}");
                      ListCoupon listCoupon =
                          ListCoupon.fromJSON(jsonDecode(couponResponse.body));
                      print("listCoupons = ${listCoupon.data.length}");
                      Provider.of<ListCoupon>(context, listen: false).data =
                          listCoupon.data;
                    });
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  Provider.of<ListCoupon>(context,
                                          listen: false)
                                      .data
                                      .length,
                                  (index) => Container(
                                    margin: EdgeInsets.only(
                                        top: index == 0 ? 20 : 0, bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                            alignment:
                                                AlignmentDirectional.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .25,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .25,
                                                decoration: BoxDecoration(
                                                    color: index % 2 == 0
                                                        ? Colors.orange
                                                        : Colors.orange
                                                            .withOpacity(.5)),
                                              ),
                                              Text(
                                                '${Provider.of<ListCoupon>(context, listen: false).data[index].discount}%',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              )
                                            ]),
                                        Stack(children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .65,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .25,
                                            decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(.2)),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .65,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .25,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10, top: 10),
                                                  child: Text(
                                                    Provider.of<ListCoupon>(
                                                            context,
                                                            listen: false)
                                                        .data[index]
                                                        .code, // Coupon name
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: Text(
                                                            'Expire: ${Provider.of<ListCoupon>(context, listen: false).data[index].exp.split('T')[0]}'), // Exp date
                                                      ),
                                                      Spacer(),
                                                      GestureDetector(
                                                        onTap: () {
                                                          widget.couponDiscount =
                                                              Provider.of<ListCoupon>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .data[
                                                                          index]
                                                                      .discount *
                                                                  0.01;
                                                          widget.priceAfterUseCoupon =
                                                              0.0;
                                                          widget
                                                              .coupon = Provider.of<
                                                                      ListCoupon>(
                                                                  context,
                                                                  listen: false)
                                                              .data[index]
                                                              .id; // current coupon id
                                                          setState(
                                                            () {
                                                              widget.couponPercentage =
                                                                  Provider.of<ListCoupon>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .data[
                                                                          index]
                                                                      .discount;
                                                              var totalPriceProvider =
                                                                  Provider.of<
                                                                          TotalPriceProvider>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              var currentTotalPrice =
                                                                  totalPriceProvider
                                                                      .totalPrice;

                                                              widget.priceAfterUseCoupon =
                                                                  currentTotalPrice -
                                                                      currentTotalPrice *
                                                                          widget
                                                                              .couponDiscount; // Calculate price after use coupon
                                                              // Handle this price
                                                              totalPriceProvider
                                                                  .updatePriceAfterUseCoupon(
                                                                      widget
                                                                          .priceAfterUseCoupon);
                                                            },
                                                          );

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 15),
                                                          alignment:
                                                              Alignment.center,
                                                          width: 70,
                                                          height: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all()),
                                                          child:
                                                              Text('Use Now'),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
            Spacer(),
            Column(children: <Widget>[
              Text('Total price:'),
              Text(
                // '${widget.couponDiscount == 1 ? oCcy.format(widget.totalPrice.toInt()) : oCcy.format(widget.priceAfterUseCoupon.toInt())} vnđ', // Show total price in cart
                '${oCcy.format(Provider.of<TotalPriceProvider>(context, listen: true).totalPrice)}', // Show totalPrice
                style: TextStyle(fontSize: 40),
              ),
            ]),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20, bottom: 20),
                width: MediaQuery.of(context).size.width * .93,
                height: 50,
                decoration: BoxDecoration(
                    color:
                        Provider.of<ListOrdersProvider>(context, listen: false)
                                    .orderDetails
                                    .length >
                                0
                            ? Colors.orange.withOpacity(.6)
                            : Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Pay',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
              onTap: Provider.of<ListOrdersProvider>(context, listen: false)
                          .orderDetails
                          .length <=
                      0
                  ? null
                  : () async {
                      List<Map<String, dynamic>> orders = [];
                      Provider.of<ListOrdersProvider>(context, listen: false)
                          .orderDetails
                          .forEach((element) {
                        orders.add(element.toMap());
                      });

                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return Center(child: CircularProgressIndicator());
                          });
                      Map<String, dynamic> requestBody = {
                        "customerId":
                            "${Provider.of<ProfileRes>(context, listen: false).data.id}",
                        "officeId":
                            Provider.of<OfficeModel>(context, listen: false).id,
                        "couponId": widget.coupon,
                        "menuId": Provider.of<ListProductsInTime>(context,
                                listen: false)
                            .id,
                        "dateOrder": DateTime.now().toIso8601String(),
                        "comment": "order juice",
                        "payment": {
                          "createTime": DateTime.now().toIso8601String(),
                          "paymentTime": DateTime.now().toIso8601String(),
                          "content":
                              "Payment by ${widget.paymentId == 1 ? 'Cash' : 'VNPay'}",
                          "paymentTypeId":
                              widget.paymentId // Hiện tại chỉ để tiền mặt
                        },
                        "orderDetails": orders
                      };

                      print("ORDER");
                      print(requestBody);
                      final client = HttpClient()
                        ..badCertificateCallback =
                            ((X509Certificate cert, String host, int port) =>
                                true);
                      final ioClient = IOClient(client);
                      await ioClient.post(
                        Uri.parse(
                            "https://api-halosmoothie.azurewebsites.net/api/orders"),
                        body: jsonEncode(requestBody),
                        headers: {
                          "Content-Type": "application/json; charset=UTF-8",
                          "Authorization":
                              "Bearer ${Provider.of<TokenModel>(context, listen: false).accessToken}"
                        },
                      ).then((response) {
                        print(response.body);
                        final data = jsonDecode(response.body);
                        if (widget.paymentId == 1) {
                          Provider.of<ListOrdersProvider>(context,
                                  listen: false)
                              .orderDetails = []; // Reset cart
                          Provider.of<ListOrderMaterials>(context,
                                      listen: false)
                                  .listOrderDetailMaterials =
                              []; // Reset list order materials
                          Provider.of<FinalColorProvider>(context,
                                  listen: false)
                              .color = Color(0xFFFFFF);
                          NotificationApi.showNotification(
                              id: data['orderId'],
                              title: 'Order successfully',
                              body: 'Thank you for your buying');
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } else {
                          print(data['paymentUrl']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => PaymentScreen(
                                url: data['paymentUrl'],
                                onShowNotification: () =>
                                    NotificationApi.showNotification(
                                        id: data['orderId'],
                                        title: 'Order successfully',
                                        body: 'Thank you for your buying'),
                              ),
                            ),
                          );
                        }

                        // print(
                        //     '======= order status code = ${response.statusCode}');
                        // print('======= order body ${response.body}');
                        // Provider.of<ListOrdersProvider>(context, listen: false)
                        //     .orderDetails = []; // Reset cart
                        // Provider.of<ListOrderMaterials>(context, listen: false)
                        //         .listOrderDetailMaterials =
                        //     []; // Reset list order materials
                        // Provider.of<FinalColorProvider>(context, listen: false)
                        //     .color = Color(0xFFFFFF);
                        // if (response.statusCode == 200) {
                        //   NotificationApi.showNotification(
                        //       title: 'Order successfully',
                        //       body: 'Thank you for your buying');
                        // }
                        // Navigator.pop(context);
                      });
                    },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CartProductItem extends StatefulWidget {
  String name;
  double price;
  double salePrice;
  String img;
  int quantity;
  int index;
  double priceAfterUseCoupon;
  BuildContext totalPriceContext;
  CartProductItem({
    required this.img,
    required this.price,
    required this.salePrice,
    required this.name,
    required this.quantity,
    required this.index,
    required this.priceAfterUseCoupon,
    required this.totalPriceContext,
  });

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .2,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * .35,
            height: MediaQuery.of(context).size.height * .2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.img),
              ),
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              Provider.of<ListOrdersProvider>(context,
                                      listen: false)
                                  .removeProduct(widget.index);
                              double newTotalPrice = 0.0;
                              for (var e in Provider.of<ListOrdersProvider>(
                                      context,
                                      listen: false)
                                  .orderDetails) {
                                newTotalPrice +=
                                    ((e.salePrice > 0 ? e.salePrice : e.price) *
                                        e.quantity);
                              }
                              Provider.of<TotalPriceProvider>(
                                      widget.totalPriceContext,
                                      listen: false)
                                  .updateTotalPrice(newTotalPrice);
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/trash-bin.png'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    widget.name,
                    maxLines: 2,
                  ),
                  Spacer(),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "${widget.salePrice > 0 ? oCcy.format(widget.salePrice.toInt() * widget.quantity).split('VND')[0] : oCcy.format(widget.price.toInt() * widget.quantity).split('VND')[0]}đ",
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: Provider.of<ListOrdersProvider>(context,
                                              listen: false)
                                          .orderDetails[widget.index]
                                          .quantity <=
                                      1
                                  ? null
                                  : () {
                                      setState(() {
                                        Provider.of<ListOrdersProvider>(context,
                                                listen: false)
                                            .orderDetails[widget.index]
                                            .changeQuantity(-1);
                                        widget.quantity =
                                            Provider.of<ListOrdersProvider>(
                                                    context,
                                                    listen: false)
                                                .orderDetails[widget.index]
                                                .quantity;
                                        double newTotalPrice = 0.0;
                                        for (var e
                                            in Provider.of<ListOrdersProvider>(
                                                    context,
                                                    listen: false)
                                                .orderDetails) {
                                          newTotalPrice += ((e.salePrice > 0
                                                  ? e.salePrice
                                                  : e.price) *
                                              e.quantity);
                                        }
                                        Provider.of<TotalPriceProvider>(
                                                widget.totalPriceContext,
                                                listen: false)
                                            .updateTotalPrice(newTotalPrice);
                                      });
                                    },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                  ),
                                  Icon(Icons.remove, size: 15),
                                ],
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text('${widget.quantity}')),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Provider.of<ListOrdersProvider>(context,
                                          listen: false)
                                      .orderDetails[widget.index]
                                      .changeQuantity(1);
                                  widget.quantity =
                                      Provider.of<ListOrdersProvider>(context,
                                              listen: false)
                                          .orderDetails[widget.index]
                                          .quantity; // change product quantity
                                  double newTotalPrice = 0.0;
                                  for (var e in Provider.of<ListOrdersProvider>(
                                          context,
                                          listen: false)
                                      .orderDetails) {
                                    newTotalPrice += ((e.salePrice > 0
                                            ? e.salePrice
                                            : e.price) *
                                        e.quantity);
                                  }
                                  Provider.of<TotalPriceProvider>(context,
                                          listen: false)
                                      .updateTotalPrice(newTotalPrice);
                                });
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.grey)),
                                  ),
                                  Icon(Icons.add, size: 15),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
