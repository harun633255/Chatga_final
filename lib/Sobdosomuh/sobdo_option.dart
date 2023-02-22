import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:siddikbhai_c/Constants.dart';
import 'package:siddikbhai_c/EmegencyNumber/emergency_single.dart';
import 'package:siddikbhai_c/Sobdosomuh/one_single.dart';
import 'package:siddikbhai_c/NetworkCall/model/borno.dart';
import 'package:siddikbhai_c/NetworkCall/model/emergency_cat.dart';
import 'package:siddikbhai_c/Sobdosomuh/sobdo_single.dart';
import 'package:siddikbhai_c/probad/sobdo_single.dart';
import 'package:siddikbhai_c/probad/second_single.dart';

import '../NetworkCall/model/probad.dart';
import '../NetworkCall/remote_service.dart';
import '../loader.dart';




class SobdoOption extends StatefulWidget {


  @override
  State<SobdoOption> createState() => _SobdoOptionState();
}

class _SobdoOptionState extends State<SobdoOption> {

  List<Borno>? allItems =[];
  List<SobdoSingle> list = [];
  List<Probad>? allIProbad =[];
  List<SecondSingle>? list2 =[];
  bool isLoaded = false;

  BannerAd? bannerAd;


  @override
  initState() {
    super.initState();
    setState(() {
      var logger = Logger();
      logger.d("fdjflkdjflkd");
      _getAllItems();
      //_getAllProbad();
    });

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Constants.BANNER_ID,
      listener: BannerAdListener(
          onAdLoaded: (ad)
          {
            setState(() {
              isLoaded = true;
            });
            print("Banner ad Loaded");
          },
          onAdFailedToLoad: (ad,error)
          {
            ad.dispose();
          }
      ),
      request: AdRequest(),
    );
    bannerAd!.load();

  }


  Future<void> _getAllItems() async {
    allItems = await RemoteService().getBorno();
    list.clear();
    setState(() {
      // print all elements from allItems
      for (int i = 0; i < allItems!.length; i++) {
        var logger = Logger();
        print("allItems[i].id: ${allItems![i].id}");
        int size = allItems!.length;
        String? id;
        String? name;
        String? image;
        //    EmergencySingle("Metropoliton police", "assets/images/promidtochat.png"),
        list.add(SobdoSingle(allItems![i].id,allItems![i].borno,));
      }
      isLoaded = true;
    });
  }
  Future<void> _getAllProbad() async {
    allIProbad = await RemoteService().getProbad();
    setState(() {
      // print all elements from allItems
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xF3F5F4F4),
      appBar: AppBar(
        backgroundColor: Constants.PRIMARYCOLOR,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("বর্ণ অনুযায়ী শব্দ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
        body: !isLoaded ? Loader():
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
           // padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom:5),
            child:Container(
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Expanded(child:     GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      childAspectRatio:1.0,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(list.length, (index) {
                        return  GestureDetector(
                            onTap: (){
                              var logger = Logger();
                              logger.d("fdjflkdjflkd tapped");
                              print("Tapped!!!.........................");

                            },
                            child:  Center(
                                child: list.elementAt(index)
                            ));
                      }),

                    )),
                    Container(
                      height: 50,
                      child: isLoaded? AdWidget(
                        ad: bannerAd!,):
                      SizedBox(),
                    ),

                  ]
              ),
            )
        )
    );
  }
}
