import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/list_order_material.dart';
import 'package:halo_smoothie/models/material.dart';
import 'package:halo_smoothie/models/order_detail_material.dart';
import 'package:halo_smoothie/views/custom_glass.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomProductScreen extends StatelessWidget {
  List<MaterialModel> listMaterials;
  CustomProductScreen({required this.listMaterials});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .12,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(.5),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05,
                  left: MediaQuery.of(context).size.width * .05,
                ),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        //Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/images/left-arrow.png'),
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .25,
                height: MediaQuery.of(context).size.height * .88,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      listMaterials.length,
                      (index) => GestureDetector(
                        onTap: () {
                          var listOrderMaterials =
                              Provider.of<ListOrderMaterials>(context,
                                  listen: false);

                          var newOrderDetailMaterial = OrderDetailMaterial(
                            materialId: listMaterials[index].id,
                            price: listMaterials[index].price,
                            quantity: 1,
                            note: '',
                            color: listMaterials[index].color,
                            img: listMaterials[index].img,
                            name: listMaterials[index].name,
                          );
                          var check = false;
                          for (var item
                              in listOrderMaterials.listOrderDetailMaterials) {
                            if (item.materialId ==
                                newOrderDetailMaterial.materialId) {
                              item.changeQuantity(1);
                              check = false;
                              return;
                            } else {
                              check = true;
                            }
                          }

                          listOrderMaterials
                              .updateListOrderMaterials(newOrderDetailMaterial);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: MediaQuery.of(context).size.width * .25,
                          height: MediaQuery.of(context).size.width * .25,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(1, 1),
                                  spreadRadius: 1,
                                  blurRadius: 1)
                            ],
                            //color: Colors.grey,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(listMaterials[index].img),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * .72,
                height: MediaQuery.of(context).size.height * .88,
                child: GlassPage(),
              )
            ],
          )
        ],
      ),
    );
  }
}
