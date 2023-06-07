import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:halo_smoothie/models/list_order_material.dart';
import 'package:halo_smoothie/models/product_order_detail.dart';
import 'package:halo_smoothie/providers/final_color_provider.dart';
import 'package:provider/provider.dart';

import '../models/color_converter.dart';
import '../providers/list_orders_provider.dart';

class GlassPage extends StatefulWidget {
  @override
  _GlassPageState createState() => _GlassPageState();
}

class _GlassPageState extends State<GlassPage> with TickerProviderStateMixin {
  late AnimationController firstController;
  late Animation<double> firstAnimation;

  late AnimationController secondController;
  late Animation<double> secondAnimation;

  late AnimationController thirdController;
  late Animation<double> thirdAnimation;

  late AnimationController fourthController;
  late Animation<double> fourthAnimation;

  @override
  void initState() {
    super.initState();

    firstController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    firstAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: firstController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          firstController.forward();
        }
      });

    secondController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    secondAnimation = Tween<double>(begin: 2.6, end: 2.4).animate(
        CurvedAnimation(parent: secondController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          secondController.forward();
        }
      });

    thirdController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    thirdAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: thirdController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          thirdController.forward();
        }
      });

    fourthController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    fourthAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: fourthController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          fourthController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          fourthController.forward();
        }
      });

    Timer(Duration(seconds: 2), () {
      firstController.forward();
    });

    Timer(Duration(milliseconds: 1600), () {
      secondController.forward();
    });

    Timer(Duration(milliseconds: 800), () {
      thirdController.forward();
    });

    fourthController.forward();
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  double materialsPrice = 0.0;
//Color(0xff2B2C56)
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var listOrderDetailMaterial =
        Provider.of<ListOrderMaterials>(context, listen: false)
            .listOrderDetailMaterials;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 3),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  width: 250,
                  height: size.height * 0.5,
                  child: GestureDetector(
                    onTap: () {
                      print('LENGTH = ${listOrderDetailMaterial.length}');
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width * .6,
                              height: MediaQuery.of(context).size.height * .7,
                              child: AlertDialog(
                                content: Stack(
                                  //overflow: Overflow.visible,
                                  children: <Widget>[
                                    // Positioned(
                                    //   //right: -40.0,
                                    //   //top: -40.0,
                                    //   child: InkResponse(
                                    //     onTap: () {
                                    //       Navigator.of(context).pop();
                                    //     },
                                    //     child: CircleAvatar(
                                    //       child: Icon(Icons.close),
                                    //       backgroundColor: Colors.red,
                                    //     ),
                                    //   ),
                                    // ),
                                    Form(
                                      key: _formKey,
                                      child: Container(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .8,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .2,
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  child: Column(
                                                    children: List.generate(
                                                      listOrderDetailMaterial
                                                          .length,
                                                      (index) => OrderMaterialsItem(
                                                          image:
                                                              listOrderDetailMaterial[
                                                                      index]
                                                                  .img,
                                                          name:
                                                              listOrderDetailMaterial[
                                                                      index]
                                                                  .name,
                                                          index: index),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: ElevatedButton(
                                                child: Text("Order"),
                                                onPressed: () {
                                                  for (var material in Provider
                                                          .of<ListOrderMaterials>(
                                                              context,
                                                              listen: false)
                                                      .listOrderDetailMaterials) {
                                                    materialsPrice +=
                                                        (material.price *
                                                            material.quantity);
                                                  }
                                                  Provider.of<ListOrdersProvider>(
                                                          context,
                                                          listen: false)
                                                      .updateListOrders(
                                                    OrderDetail(
                                                      productId: 0,
                                                      name: 'Custom product',
                                                      price:
                                                          materialsPrice, // Total materials price
                                                      img:
                                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa3W2qvZ9w-IOLNPCM-i-VfhmnD_wDwSAwVg&usqp=CAU',
                                                      quantity: 1,
                                                      note: 'Custom product',
                                                      orderDetailMaterials: Provider
                                                              .of<ListOrderMaterials>(
                                                                  context,
                                                                  listen: false)
                                                          .listOrderDetailMaterials
                                                          .map((e) => e.toMap())
                                                          .toList(),
                                                    ),
                                                  );
                                                  Provider.of<ListOrderMaterials>(
                                                          context,
                                                          listen: false)
                                                      .resetListOrderMaterials();
                                                  Provider.of<FinalColorProvider>(
                                                          context,
                                                          listen: false)
                                                      .color = Color(0xFFFFFF);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Stack(
                      children: [
                        Center(
                          child: Text('',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                wordSpacing: 3,
                                color: Colors.white.withOpacity(.7),
                              ),
                              textScaleFactor: 7),
                        ),
                        Builder(builder: (colorContext) {
                          var finalColorProvider =
                              Provider.of<FinalColorProvider>(context,
                                  listen: true);
                          var orderMaterialProvider =
                              Provider.of<ListOrderMaterials>(colorContext,
                                  listen: true);
                          for (var item in orderMaterialProvider
                              .listOrderDetailMaterials) {
                            finalColorProvider.color = finalColorProvider.color
                                .mix(hexToColor(item.color), .25)!;
                          }
                          return CustomPaint(
                            painter: MyPainter(
                              firstAnimation.value,
                              secondAnimation.value,
                              thirdAnimation.value,
                              fourthAnimation.value,
                              color: finalColorProvider.color,
                            ),
                            child: SizedBox(
                              height: size.height,
                              width: size.width,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderMaterialsItem extends StatefulWidget {
  String image;
  String name;
  int index;
  OrderMaterialsItem({
    required this.image,
    required this.name,
    required this.index,
  });
  @override
  State<StatefulWidget> createState() => _OrderMaterialsItemState();
}

class _OrderMaterialsItemState extends State<OrderMaterialsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Image.network(
            widget.image,
            width: 50,
            height: 50,
          ),
          SizedBox(
            width: 15,
          ),
          Container(
              width: MediaQuery.of(context).size.width * .23,
              height: MediaQuery.of(context).size.width * .05,
              child: Text(widget.name)),
          SizedBox(
            width: 15,
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  Provider.of<ListOrderMaterials>(context, listen: false)
                      .listOrderDetailMaterials[widget.index]
                      .changeQuantity(1);
                });
              },
              icon: Icon(Icons.add)),
          Text(
              '${Provider.of<ListOrderMaterials>(context, listen: false).listOrderDetailMaterials[widget.index].quantity}'),
          IconButton(
              onPressed: Provider.of<ListOrderMaterials>(context, listen: false)
                          .listOrderDetailMaterials[widget.index]
                          .quantity <=
                      1
                  ? null
                  : () {
                      setState(() {
                        Provider.of<ListOrderMaterials>(context, listen: false)
                            .listOrderDetailMaterials[widget.index]
                            .changeQuantity(-1);
                      });
                    },
              icon: Icon(Icons.remove))
        ],
      ),
    );
  }
}

class MaterialFruitButton extends StatelessWidget {
  final String materialName;

  const MaterialFruitButton({
    required this.materialName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          //color: Colors.grey.withOpacity(.4),
          image: DecorationImage(
            image: AssetImage('assets/images/$materialName.png'),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;
  Color color;

  MyPainter(
    this.firstValue,
    this.secondValue,
    this.thirdValue,
    this.fourthValue, {
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height / firstValue)
      ..cubicTo(size.width * .4, size.height / secondValue, size.width * .7,
          size.height / thirdValue, size.width, size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
