import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:siddikbhai_c/Constants.dart';
import 'package:siddikbhai_c/Sobdosomuh/one_single.dart';
import 'package:siddikbhai_c/probad/second.dart';
import 'package:siddikbhai_c/probad/second_single.dart';

import '../NetworkCall/model/probad.dart';
import '../NetworkCall/remote_service.dart';
import '../loader.dart';




class SecondOption extends StatefulWidget {

  String? id;
  String? borno;
  SecondOption(this.id,this.borno);


  @override
  State<SecondOption> createState() => _SecondOptionState();
}

class _SecondOptionState extends State<SecondOption> {


  List<Probad>? allIProbad =[];
  List<SecondSingle>? list2 =[];
  bool isLoaded = false;

  BannerAd? bannerAd;

  @override
  initState() {
    super.initState();
    setState(() {
      _getAllProbad();
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

  Future<void> _getAllProbad() async {
    allIProbad = await RemoteService().getProbad();
    setState(() {
      // print all elements from allItems
      for(int i = 0; i < allIProbad!.length; i++)
        {
          if(allIProbad![i].bornoid == widget.id)
            {
              list2!.add(SecondSingle(widget.borno, allIProbad![i].probad,allIProbad![i].onubad , allIProbad![i].mormartho, allIProbad![i].english, allIProbad![i].audio,Constants.PRIMARYCOLOR));
            }
           }
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
        title: Text("প্রবাদ থেকে প্রবচন",
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
        padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom:5),
        child:Container(
          child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Expanded(child: ListView.builder(
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
      )
    );
  }
}
