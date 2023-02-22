import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:logger/logger.dart';
import 'package:siddikbhai_c/Constants.dart';

import '../NetworkCall/model/emergency.dart';
import '../NetworkCall/remote_service.dart';

class EmergencySingle extends StatefulWidget {

  String? id;
  String? name;
  String? image;

  EmergencySingle(this.id,this.name,this.image);

  @override
  State<EmergencySingle> createState() => _EmergencySingleState();
}

class _EmergencySingleState extends State<EmergencySingle> {

  List<Emergency>? allItems =[];
  bool isLoaded = false;




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
    allItems = await RemoteService().getEmergency();
    setState(() {
      // print all elements from allItems
      isLoaded = true;
    });
  }
  _callNumber() async{
    const number = '085921195555'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          int? length = allItems?.length;
          String? content = "";
          for(int i = 0; i < length!; i++)
            {

              if(allItems?.elementAt(i).catid == widget.id)
                {
                  String name = allItems?.elementAt(i).name.toString() ?? "";
                  String phone = allItems?.elementAt(i).mobile.toString() ?? "";
                 content = content! + name + "\n" + phone + "\n\n";
                }
            }
          AwesomeDialog(
            context: context,
            dialogType: DialogType.noHeader,
            // animType: AnimType.BOTTOMSLIDE,
            title: widget.name,
            autoDismiss: true,
            desc: content,
             btnCancelOnPress: () {

                    },
            // btnOkIcon: Icons.check_circle,
          ).show();
          //_callNumber();
        },
        child:
        Container(
          height: 120,
          width: MediaQuery.of(context).size.width*0.30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 3,
                blurRadius: 2.0,
                offset: Offset(2.0, 2.0),
              ),

            ],
          ),
          child: Container(
            padding: EdgeInsets.all(2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 40,
                    width: 40,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.network(
                              widget.image!).image,
                        )
                    )
                ),
                Align(
                  alignment: Alignment.center,
                  child:  Text(
                    widget.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,

                      color: Constants.PRIMARYCOLOR,
                      fontFamily: Constants.BANGLAFONT,
                    ),
                  ),
                )

              ],
            ),
          ),
        )
    );
  }
}
