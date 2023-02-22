import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:siddikbhai_c/Constants.dart';
import 'package:siddikbhai_c/Sobdosomuh/one_single.dart';
import 'package:siddikbhai_c/Chatga_to_English/fourth_single.dart';
import 'package:siddikbhai_c/NetworkCall/model/enlish_to_chatga.dart';
import 'package:siddikbhai_c/promitToChatga/third_single.dart';

import '../NetworkCall/remote_service.dart';

import 'package:audioplayers/audioplayers.dart';

import '../loader.dart';
class FourthOption extends StatefulWidget {


  @override
  State<FourthOption> createState() => _FourthOptionState();
}

class _FourthOptionState extends State<FourthOption> {

  List<EnglishToChatga>? allItems =[];
  List<FourthSingle> list = [];
  bool isLoaded = false;
  BannerAd? bannerAd;




  @override
  initState() {
    super.initState();
    setState(() {
      var logger = Logger();
      logger.d("fdjflkdjflkd");
      _getAllItems();
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
    allItems = await RemoteService().getEnglishToChatga();
    list.clear();
    setState(() {
      // print all elements from allItems
      for (int i = 0; i < allItems!.length; i++) {
        var logger = Logger();
        print("allItems[i].id: ${allItems![i].id}");
        int size = allItems!.length;
        list.add(FourthSingle(id:allItems![i].id,english:allItems![i].english,chatga:allItems![i].ctg,audio: allItems![i].audio,size: size,));
      }
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
        title: Text("চাটগাঁ থেকে ইংরেজী",
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
                  Expanded(child:
                  ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context,index){
                        return list.elementAt(index);
                      }
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
      ),
    );
  }
}
