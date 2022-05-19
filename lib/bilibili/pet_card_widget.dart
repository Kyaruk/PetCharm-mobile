import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'pet.dart';

class PetCardWidget extends StatelessWidget{
  final Pet pet;
  PetCardWidget({required this.pet});
  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      height: 200.0,
      margin: EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 12.0,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 50.0,
            left: 0,
            right: 0,
            bottom: 15.0,
            child: Card(
              elevation: 7.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(170.0, 10.0, 10.0, 10.0),
                padding: EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pet.name,
                          overflow: TextOverflow.ellipsis,
                          style:kTitleStyle,
                        ),
                        pet.isMale == "true"? Icon(FontAwesomeIcons.mars, color: kText2Color,): Icon(FontAwesomeIcons.venus, color: kText2Color,)
                      ],
                    ),
                    Text(pet.type,style:  kSubtitleStyle,),
                    Text("${pet.datetime} years old", style: kSubtitle2Style),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.mapMarkedAlt,
                          color: kPrimaryColor,
                          size: 15.0,
                        ),
                        SizedBox(width: 5.0,),
                        Text("Distance", style: kSubtitle2Style,)
                      ],
                    ),
                    SizedBox(height: 10.0,)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            left: 0,
            right: 155.0,
            bottom: 0,
            child: Card(
              elevation: 7.0,
              color: Color.fromRGBO(255,165,170,1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),

              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 20.0,
            right: 160.0,
            bottom: 30.0,
            child: Image.asset(
              "assets/DouDou.jpg",
              fit: BoxFit.fill,
            ),
          ),


        ],
      ),
    );
  }

}
