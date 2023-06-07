import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:halo_smoothie/providers/list_product_provider.dart';
import 'package:halo_smoothie/views/product/product_detail.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class ListProductPage extends StatelessWidget {
  ListProductPage({super.key});

  @override
  Widget build(BuildContext listProductsContext) {
    var listProductProvider =
        Provider.of<ListProductsProvider>(listProductsContext, listen: false);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
        child: Column(
          children: <Widget>[
            Stack(alignment: AlignmentDirectional.center, children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(listProductsContext).size.height * .08,
                    left: MediaQuery.of(listProductsContext).size.width * .05),
                child: Row(children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pop(listProductsContext),
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
                  Spacer()
                ]),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(listProductsContext).size.height * .08,
                ),
                child: Text(
                  'Morning Products',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
            listProductProvider.listProducts.length > 0
                ? Expanded(
                    child: Container(
                      child: MasonryGridView.builder(
                        gridDelegate:
                            SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: Provider.of<ListProductsProvider>(
                                listProductsContext)
                            .listProducts
                            .length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProductDetailPage(
                                          id: 0,
                                          img: listProductProvider
                                              .listProducts[index].img,
                                          name: listProductProvider
                                              .listProducts[index].name,
                                          price: 0,
                                          salePrice: 0,
                                          desc: listProductProvider
                                              .listProducts[index].descs,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: DropShadowImage(
                                          image: Image.network(
                                              Provider.of<ListProductsProvider>(
                                                      listProductsContext)
                                                  .listProducts[index]
                                                  .img)),
                                    ),
                                  ),
                                ),
                                Row(children: <Widget>[
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          Provider.of<ListProductsProvider>(
                                                  listProductsContext)
                                              .listProducts[index]
                                              .name,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '${Provider.of<ListProductsProvider>(listProductsContext).listProducts[index].salePrice}',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w200),
                                        ),
                                      ]),
                                  Spacer(),
                                  IconButton(
                                      iconSize: 20,
                                      onPressed: () {},
                                      icon: LineIcon.heart())
                                ]),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Expanded(
                    child: Center(
                    child: Text(
                      'Products not found',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
