import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:siddikbhai_c/Constants.dart';
import 'package:siddikbhai_c/NetworkCall/model/sobdo.dart';
import 'package:siddikbhai_c/Sobdosomuh/one_single.dart';
import 'package:siddikbhai_c/probad/second.dart';
import 'package:siddikbhai_c/probad/second_single.dart';

import '../NetworkCall/model/probad.dart';
import '../NetworkCall/remote_service.dart';
import '../loader.dart';




class OptionOnes extends StatefulWidget {

  String? id;

  OptionOnes(this.id);


  @override
  State<OptionOnes> createState() => _OptionOnesState();
}

class _OptionOnesState extends State<OptionOnes> {


  List<Sobdo>? allISobdo =[];
  List<OneSingle>? list2 =[];
  bool isLoaded = false;
  BannerAd? bannerAd;

  @override
  initState() {
    super.initState();
    setState(() {
      _getAllProbad();
    });

  }

  Future<void> _getAllProbad() async {
    allISobdo = await RemoteService().getSobdo();
    setState(() {
      // print all elements from allItems
      for(int i = 0; i < allISobdo!.length; i++)
        {
          if(allISobdo![i].catid == widget.id)
            {
              list2!.add(OneSingle(allISobdo![i].ctg,allISobdo![i].shabdasomuho));
            }
           }
      isLoaded = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.PRIMARYCOLOR,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("চাটগাঁ ও চলিত শব্দ",
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
                        itemCount: list2!.length,
                        itemBuilder: (context,index){
                          return list2!.elementAt(index);
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
