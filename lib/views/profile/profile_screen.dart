import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/token.dart';
import 'package:halo_smoothie/providers/list_office_provider.dart';
import 'package:halo_smoothie/providers/list_product_provider.dart';
import 'package:halo_smoothie/services/auth_service.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * .35,
            height: MediaQuery.of(context).size.width * .35,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60'))),
          ),
          Text('Tran Ngoc Hai',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('+84123456789'),
          Builder(
            builder: (accountContext) => Center(
              child: GestureDetector(
                onTap: () async {
                  var listProductsProvider = Provider.of<ListProductsProvider>(
                      accountContext,
                      listen: false);
                  var tokenModelProvider =
                      Provider.of<TokenModel>(accountContext, listen: false);
                  listProductsProvider.listProducts =
                      []; // Reset list products to empty
                  var listOfficesProvider = Provider.of<ListOfficesProvider>(
                      accountContext,
                      listen: false);

                  tokenModelProvider
                      .updateAccessToken(''); // Reset accessToken to empty
                  listOfficesProvider
                      .updateListOffice([]); // Reset list offices
                  print(
                      'listProducts after signout = ${listProductsProvider.listProducts.length}');
                  print(
                      'accessToken after signout = ${tokenModelProvider.accessToken}');
                  AuthService().signOut();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * .8,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
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
