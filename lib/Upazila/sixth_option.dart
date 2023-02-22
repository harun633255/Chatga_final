import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:siddikbhai_c/Constants.dart';
import 'package:siddikbhai_c/Sobdosomuh/one_single.dart';
import 'package:siddikbhai_c/NetworkCall/model/upazela_cat.dart';
import 'package:siddikbhai_c/Upazila/uttor_chattagram.dart';
import 'package:siddikbhai_c/Upazila/sixth_main_options.dart';
import 'package:siddikbhai_c/Upazila/dokkhin_chattagram.dart';

import '../NetworkCall/remote_service.dart';
import '../loader.dart';




class SixthOption extends StatefulWidget {


  @override
  State<SixthOption> createState() => _SixthOptionState();
}

class _SixthOptionState extends State<SixthOption> {

  List list = [];

  List<UpazelaCat> allItems = [];
  bool isLoaded = false;

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
    allItems = (await RemoteService().getUpaZelaCat())!;
    list.clear();
    setState(() {
      // print all elements from allItems
      for (int i = 0; i < allItems!.length; i++) {
        var logger = Logger();
        print("allItems[i].id: ${allItems![i].id}");
        if (allItems![i].id == 1) {
          list.add(SixthMainOptions(
              "assets/images/uttor.jpg", allItems![i].name ?? ''));
        } else {
          list.add(SixthMainOptions(
              "assets/images/dokkhin.png", allItems![i].name ?? ''));
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
        title: Text("এক নজরে সব উপজেলা",
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
                      itemCount: allItems.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            if(index == 0)
                            {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=> UttorChattagram()));
                            }
                            else if(index == 1)
                            {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=> DokkhinChattagram()));
                            }
                          },
                          child:list.elementAt(index) ,
                        );



                      }
                  )
                  ),
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
