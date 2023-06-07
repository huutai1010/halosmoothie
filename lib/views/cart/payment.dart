import 'dart:io';

import 'package:flutter/material.dart';
import 'package:halo_smoothie/views/home/home_screen.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/list_order_material.dart';
import '../../models/token.dart';
import '../../providers/final_color_provider.dart';
import '../../providers/list_orders_provider.dart';
import '../../services/local_notification_service.dart';

class PaymentScreen extends StatefulWidget {
  final String url;
  final Function onShowNotification;
  const PaymentScreen({
    super.key,
    required this.url,
    required this.onShowNotification,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isPayment = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VNPay'),
      ),
      body: Stack(children: [
        WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(NavigationDelegate(
              onPageStarted: (url) {
                if (url.contains("/api/orders")) {
                  setState(() {
                    isPayment = true;
                  });

                  final client = HttpClient()
                    ..badCertificateCallback =
                        ((X509Certificate cert, String host, int port) => true);
                  final ioClient = IOClient(client);

                  ioClient.put(
                    Uri.parse(url.split('?')[0] + '/1'),
                    headers: {
                      "Content-Type": "application/json; charset=UTF-8",
                      "Authorization":
                          "Bearer ${Provider.of<TokenModel>(context, listen: false).accessToken}"
                    },
                  ).then((value) {
                    Provider.of<ListOrdersProvider>(context, listen: false)
                        .orderDetails = []; // Reset cart
                    Provider.of<ListOrderMaterials>(context, listen: false)
                            .listOrderDetailMaterials =
                        []; // Reset list order materials
                    Provider.of<FinalColorProvider>(context, listen: false)
                        .color = Color(0xFFFFFF);
                    widget.onShowNotification();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                }
              },
              onNavigationRequest: (request) {
                return NavigationDecision.navigate;
              },
            ))
            ..loadRequest(
              Uri.parse(widget.url),
            ),
        ),
        isPayment
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Stack(),
      ]),
    );
  }
}
