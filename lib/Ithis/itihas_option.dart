import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:siddikbhai_c/Constants.dart';
import 'package:siddikbhai_c/Gallery/gallery_single.dart';
import 'package:siddikbhai_c/NetworkCall/model/gallery.dart';
import 'package:siddikbhai_c/NetworkCall/model/itihas.dart';
import 'package:siddikbhai_c/Sobdosomuh/one_single.dart';
import 'package:siddikbhai_c/NetworkCall/model/dorniyo_place.dart';
import 'package:siddikbhai_c/probad/second.dart';
import 'package:siddikbhai_c/probad/second_single.dart';
import 'package:siddikbhai_c/Upazila/uttor_chattagram.dart';
import 'package:siddikbhai_c/Upazila/sixth_main_options.dart';
import 'package:siddikbhai_c/Upazila/dokkhin_chattagram.dart';

import '../NetworkCall/remote_service.dart';
import '../loader.dart';




class ItihasOption extends StatefulWidget {


  @override
  State<ItihasOption> createState() => _ItihasOptionState();
}

class _ItihasOptionState extends State<ItihasOption> {

  List<Itihas>? allItems =[];
  //List<Gallery_Single> list = [];
  bool isLoaded = false;
  String itihas = "";


  BannerAd? bannerAd;
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


  @override
  initState() {
    super.initState();
    setState(() {
      var logger = Logger();
      logger.d("fdjflkdjflkd");
      _getAllItems();
    });

  }

  Future<void> _getAllItems() async {
    allItems = await RemoteService().getItihas();
    setState(() {
      // print all elements from allItems
      itihas = allItems![0].value!;
      isLoaded = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.PRIMARYCOLOR,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("চট্টগ্রামের ইতিহাস",
          style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: !isLoaded ? Loader():
      Scrollbar(
        isAlwaysShown: true,
          thickness: 10,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:  Column(
                children: [
                  Expanded(
                      flex: 4,
                      child:
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(itihas,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child:  Container(
                      height: 50,
                      child: isLoaded? AdWidget(
                        ad: bannerAd!,):
                      SizedBox(),
                    ),)

                ],
              ),
            ),
          )

      )
      );
  }
}
