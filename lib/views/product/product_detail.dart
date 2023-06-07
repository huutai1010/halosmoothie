import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/product_order_detail.dart';
import 'package:halo_smoothie/providers/list_orders_provider.dart';
import 'package:provider/provider.dart';

import '../../format/format_price.dart';

class ProductDetailPage extends StatefulWidget {
  int id;
  String img;
  String name;
  double price;
  double salePrice;
  String desc;
  int quantity = 1;
  ProductDetailPage({
    required this.id,
    required this.img,
    required this.name,
    required this.price,
    required this.salePrice,
    required this.desc,
  });
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

// ignore: must_be_immutable
class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext productDetailContext) {
    return Scaffold(
      body: Container(
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(productDetailContext).size.width,
                height: MediaQuery.of(productDetailContext).size.height * .35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.img),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(productDetailContext).size.width,
                height: MediaQuery.of(productDetailContext).size.height * .15,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width:
                            MediaQuery.of(productDetailContext).size.width * .6,
                        child: Text(
                          widget.name,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Text(
                            '${widget.salePrice > 0 ? '${oCcy.format(widget.salePrice.toInt())}' : ''} ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange[400],
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${oCcy.format(widget.price.toInt())}',
                            style: TextStyle(
                              fontWeight: widget.salePrice > 0
                                  ? FontWeight.w500
                                  : FontWeight.w600,
                              decoration: widget.salePrice > 0
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: widget.salePrice > 0
                                  ? Colors.black
                                  : Colors.orange[400],
                              fontSize: widget.salePrice > 0 ? 14 : 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget.quantity > 0) {
                            widget.quantity -= 1;
                          }
                        });
                      },
                      icon: Icon(Icons.remove),
                      color: Colors.orange[400]),
                  SizedBox(width: 10),
                  Text('${widget.quantity}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.quantity += 1;
                        });
                      },
                      icon: Icon(Icons.add),
                      color: Colors.orange[400])
                ],
              ),
              Divider(),
              Container(
                  padding: EdgeInsets.only(top: 15, left: 15),
                  child: Text('Discription',
                      style: TextStyle(fontWeight: FontWeight.w600))),
              Container(
                height: MediaQuery.of(productDetailContext).size.height * .25,
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.desc,
                        style: TextStyle(fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(-1, -2), // changes position of shadow
                    )
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            Text(
                                '${widget.salePrice > 0 ? oCcy.format(widget.salePrice.toInt() * widget.quantity) : oCcy.format(widget.price.toInt() * widget.quantity)}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700)),
                            Text('${widget.quantity} items',
                                style: TextStyle(fontWeight: FontWeight.w200))
                          ])),
                      GestureDetector(
                        onTap: widget.quantity == 0
                            ? null
                            : () {
                                var newOrderDetail = OrderDetail(
                                  productId: widget.id,
                                  name: widget.name,
                                  price: widget.price,
                                  salePrice: widget.salePrice,
                                  img: widget.img,
                                  quantity: widget.quantity,
                                  note: widget.name,
                                  orderDetailMaterials: [],
                                );

                                // Provider.of<ListOrdersProvider>(productDetailContext,
                                //         listen: false)
                                //     .updateListOrders(newOrderDetail);
                                var check = false;

                                for (var orderDetail
                                    in Provider.of<ListOrdersProvider>(
                                            productDetailContext,
                                            listen: false)
                                        .orderDetails) {
                                  if (orderDetail.productId ==
                                      newOrderDetail.productId) {
                                    check = false;
                                    orderDetail.changeQuantity(widget.quantity);
                                    return;
                                  } else {
                                    check = true;
                                  }
                                }

                                Provider.of<ListOrdersProvider>(
                                        productDetailContext,
                                        listen: false)
                                    .updateListOrders(newOrderDetail);
                              },
                        child: Container(
                          width:
                              MediaQuery.of(productDetailContext).size.width *
                                  .5,
                          height:
                              MediaQuery.of(productDetailContext).size.height *
                                  .05,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: widget.quantity == 0
                                ? Colors.grey.withOpacity(.5)
                                : Colors.orange[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Add to cart',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(productDetailContext).size.height * .08,
              left: MediaQuery.of(productDetailContext).size.width * .05,
            ),
            child: Row(children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(productDetailContext),
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
              Spacer()
            ]),
          ),
        ]),
      ),
    );
  }
}
