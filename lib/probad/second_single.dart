import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:siddikbhai_c/Constants.dart';
import 'package:siddikbhai_c/probad/second.dart';

import '../play_audio.dart';

class SecondSingle extends StatefulWidget {

  String? firstLater;
  String? probad;
  String? onubad;
  String? mormartho;
  String? english;
  String? audio;
  Color? color;

  SecondSingle(this.firstLater,this.probad,this.onubad,this.mormartho,this.english,this.audio,this.color);

  @override
  State<SecondSingle> createState() => _SecondSingleState();
}

class _SecondSingleState extends State<SecondSingle> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0.5, 0.5), //(x,y)
              blurRadius: 2.0,
            ),
          ],
        ),
        child:Align(
            alignment: Alignment.center,
            child:
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("প্রবাদঃ "+
                              widget.probad!, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: Constants.BANGLAFONT,
                            ),),
                            /*Image.asset("assets/images/transfer.png",
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),*/
                            Divider(color: Colors.grey,),
                            Text("অনুবাদঃ "+widget.onubad!,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: Constants.BANGLAFONT,
                              ),
                            ),
                            Divider(color: Colors.grey,),
                            Text("মর্মার্থ: "+widget.mormartho!,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: Constants.BANGLAFONT,
                              ),
                            ),
                            Divider(color: Colors.grey,),
                            Text("ইংরেজিঃ "+widget.english!,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: Constants.BANGLAFONT,
                              ),
                            ),
                            Divider(color: Colors.grey,),
                            Center(
                              child:  GestureDetector(
                                onTap: (){

                                  String audio = widget.audio!;
                                  String content = widget.probad!+"\n"+widget.onubad!;
                                  // logger.d("content: $audio");
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=> PlayAudio(audio,content)));
                                },
                                behavior: HitTestBehavior.opaque,
                                child:
                                Icon(BootstrapIcons.play_circle, color: Colors.redAccent,size: 50,),),
                            ),

                          ],
                        )),


                      ],
                    ),
                    SizedBox(height: 10,),
                    //Divider(color: Colors.black,thickness: 1,indent: 10,endIndent: 10,),
                  ],
                )

        ),


      );
  }
}

