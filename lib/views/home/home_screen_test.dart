import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/account.dart';
import 'package:provider/provider.dart';

class HomePageV2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountModel>(context, listen: false);
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
            child: Row(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good morning',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.grey),
                  ),
                  Text(
                    accountProvider.firstName,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(FirebaseAuth
                            .instance.currentUser?.photoURL ??
                        'https://cdn-icons-png.flaticon.com/128/4140/4140048.png'),
                  ),
                ),
              ),
            ]),
          ),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Popular product',
                          style: TextStyle(
                              fontFamily: 'LibreCaslonDisplay',
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 250,
                                height: 125,
                                decoration: BoxDecoration(
                                  //borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://cdn.nguyenkimmall.com/images/detailed/709/top-10-loai-nuoc-ep-bo-duong-ho-tro-tang-cuong-suc-khoe-mua-dich-thumbnail.jpg'),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('Orang juice mix',
                                  style: TextStyle(fontWeight: FontWeight.w500))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 250,
                                height: 125,
                                decoration: BoxDecoration(
                                  //borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'http://cdn.tgdd.vn/Files/2019/11/02/1214700/cach-lam-nuoc-ep-dua-hau-don-gian-giai-nhiet-ngay-he-202201141009321411.jpeg'),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('Orang juice mix',
                                  style: TextStyle(fontWeight: FontWeight.w500))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 250,
                                height: 125,
                                decoration: BoxDecoration(
                                  //borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'http://cdn.tgdd.vn/Files/2019/07/14/1179531/nuoc-ep-tao-co-tac-dung-gi-ma-ai-cung-thi-nhau-uong-201907142251530613.jpg'),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('Orang juice mix',
                                  style: TextStyle(fontWeight: FontWeight.w500))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Morning product',
                          style: TextStyle(
                              fontFamily: 'LibreCaslonDisplay',
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'More',
                                style: TextStyle(
                                    fontFamily: 'LibreCaslonDisplay',
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 20,
                                height: 25,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/right-arrow.png'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  MenuFruit(),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Afternoon product',
                          style: TextStyle(
                              fontFamily: 'LibreCaslonDisplay',
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        ),

                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'More',
                                style: TextStyle(
                                    fontFamily: 'LibreCaslonDisplay',
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 20,
                                height: 25,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/right-arrow.png'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                        //ElevatedButton(onPressed: () {}, child: )
                      ],
                    ),
                  ),
                  MenuFruit(),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Evening product',
                          style: TextStyle(
                              fontFamily: 'LibreCaslonDisplay',
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        ),

                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'More',
                                style: TextStyle(
                                    fontFamily: 'LibreCaslonDisplay',
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 20,
                                height: 25,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/right-arrow.png'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                        //ElevatedButton(onPressed: () {}, child: )
                      ],
                    ),
                  ),
                  MenuFruit(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MenuFruit extends StatelessWidget {
  final _imgURL = [
    'https://truejuice.vn/articles/wp-content/uploads/2021/04/nuoc-ep-dau-tay-truejuice.jpg',
    'https://cdn.nguyenkimmall.com/images/companies/_1/tin-tuc/kinh-nghiem-meo-hay/top-10-loai-nuoc-ep-bo-duong-ho-tro-tang-cuong-suc-khoe-mua-dich-h2.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9NVyVJJRC8BIClZrbOiuFAQrEGDeJor79RA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZfXFUKWrEYg2wpIbVBzXaKDvp_BjZrzxyWg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3BlVQ_1333GcG02SlocyTMdoht7cmwnc7mg&usqp=CAU'
  ];

  MenuFruit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: new List.generate(
          _imgURL.length,
          (index) => Container(
            margin: EdgeInsets.only(top: 10, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Center()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .25,
                    height: MediaQuery.of(context).size.height * .2,
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          _imgURL[index],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Orange mix',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
                Text('25.000'),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
