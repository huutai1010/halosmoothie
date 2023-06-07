import 'package:flutter/material.dart';
import 'package:halo_smoothie/providers/list_office_provider.dart';
import 'package:halo_smoothie/views/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class StoresScreen extends StatelessWidget {
  var _listStores = [
    'https://tiendulight.com/media/files/hoan-thanh-hang-muc-cong-trinh-logo-fpt-ha-noi-5(1).png',
    'https://hcmuni.fpt.edu.vn/Data/Sites/1/media/2020-campus/10campusdhfpttphcm.jpg',
    'https://fastly.4sqi.net/img/general/600x600/70605700_5jnJohcdXxpk5iHHq0VWmlHdhRnrrmiX2WPN3sI8fJM.jpg',
    'https://i.ytimg.com/vi/JbxduTppsuI/maxresdefault.jpg',
  ];
  StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var listOfficesProvider =
        Provider.of<ListOfficesProvider>(context, listen: false);
    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .05,
                    top: 15,
                    bottom: 15),
                child: Text(
                  'Offices',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
            ],
          ),
          Provider.of<ListOfficesProvider>(context, listen: false)
                      .listOffice
                      .length >
                  0
              ? Flexible(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          listOfficesProvider.listOffice.length,
                          (index) => GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                          topOfficeBackground:
                                              listOfficesProvider
                                                  .listOffice[index].img,
                                        ))),
                            child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  width: MediaQuery.of(context).size.width * .9,
                                  height:
                                      MediaQuery.of(context).size.height * .2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              listOfficesProvider
                                                  .listOffice[index].img))),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    listOfficesProvider.listOffice[index].name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                          color: Colors.grey.withOpacity(.5),
                                          blurStyle: BlurStyle.solid,
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Flexible(
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: List.generate(
                        4,
                        (index) => Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(.9),
                          highlightColor: Colors.grey.withOpacity(.4),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: MediaQuery.of(context).size.width * .9,
                                height: MediaQuery.of(context).size.height * .2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(.4),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15, bottom: 20),
                                width: MediaQuery.of(context).size.width * .4,
                                height:
                                    MediaQuery.of(context).size.height * .03,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey.withOpacity(.2)),
                              )
                            ],
                          ),
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
