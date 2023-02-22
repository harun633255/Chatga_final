import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:siddikbhai_c/DorshonioSthan/seventh_option.dart';
import 'package:siddikbhai_c/probad/second.dart';

import 'package:flutter/material.dart';
import 'package:siddikbhai_c/Constants.dart';

class SeventhSingle extends StatefulWidget {

  String? id;
  String? name;
  String? image;
  String? description;


  SeventhSingle(this.id,this.name,this.image,this.description);

  @override
  State<SeventhSingle> createState() => _SeventhSingleState();
}

class _SeventhSingleState extends State<SeventhSingle> {
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          //show awsomedialog
          AwesomeDialog(
            context: context,
            autoDismiss: true,
            dialogType: DialogType.noHeader,
            // animType: AnimType.BOTTOMSLIDE,
            title: widget.name,
            desc: widget.description!,
             btnCancelOnPress: () {
                  // close dialogue
                },
             btnOkIcon: Icons.check_circle,
          ).show();
        },
        child:
        Container(
         // height: MediaQuery.of(context).size.height*0.35,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(15),
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
            //padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height*0.28,
                    //width: MediaQuery.of(context).size.width*0.80,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15),),
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.network(
                              widget.image!).image,
                        )
                    )
                ),
                SizedBox(height: 10,),
                Text(widget.name!,
                  style: TextStyle(
                    fontSize: 25 ,
                    fontWeight: FontWeight.bold,
                    color: Constants.PRIMARYCOLOR,
                    fontFamily: "bangla",
                  ),
                ),
              ],
            ),
          ),
        )
      );
  }
}

