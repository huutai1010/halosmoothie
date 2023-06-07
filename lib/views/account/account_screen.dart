import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:halo_smoothie/providers/list_orders_provider.dart';
import 'package:provider/provider.dart';
import '../../models/list_order_material.dart';
import '../../models/list_products_intime.dart';
import '../../models/list_rest_products.dart';
import '../../models/profile.dart';
import '../../providers/final_color_provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileRes>(context, listen: false);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .35,
            height: MediaQuery.of(context).size.width * .35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(profileProvider.data.image != ''
                    ? profileProvider.data.image
                    : 'https://cdn-icons-png.flaticon.com/128/3177/3177440.png'),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            '${profileProvider.data.lastName} ${profileProvider.data.firstName}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          Builder(
            builder: (logoutContext) => Center(
              child: GestureDetector(
                onTap: () async {
                  Provider.of<ListProductsInTime>(logoutContext, listen: false)
                      .products = []; // Reset products in time to empty
                  print(
                      'Before signout = ${Provider.of<ListProductsInTime>(logoutContext, listen: false).products.length}');
                  Provider.of<ListRestProduct>(logoutContext, listen: false)
                      .data = [];

                  Provider.of<ListOrdersProvider>(logoutContext, listen: false)
                      .resetListOrders(); // Reset list order in cart
                  Provider.of<ListOrderMaterials>(logoutContext, listen: false)
                          .listOrderDetailMaterials =
                      []; // Reset list order detail materials
                  Provider.of<FinalColorProvider>(logoutContext, listen: false)
                      .color = Color(0xFFFFFF);

                  Provider.of<ProfileRes>(logoutContext, listen: false)
                      .resetProfile();
                  GoogleSignIn().signOut();
                  FirebaseAuth.instance.signOut();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .5,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Sign out',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
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
