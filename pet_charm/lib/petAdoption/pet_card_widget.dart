import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'package:pet_charm/models/pet.dart';

class PetCardWidget extends StatelessWidget {
  final Pet pet;

  const PetCardWidget({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.0,
      margin: const EdgeInsets.symmetric(
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
                margin: const EdgeInsets.fromLTRB(170.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pet.petName,
                          overflow: TextOverflow.ellipsis,
                          style: kTitleStyle,
                        ),
                        pet.petGender == "male"
                            ? const Icon(
                                FontAwesomeIcons.mars,
                                color: kText2Color,
                              )
                            : const Icon(
                                FontAwesomeIcons.venus,
                                color: kText2Color,
                              )
                      ],
                    ),
                    Text(
                      pet.petType,
                      style: kSubtitleStyle,
                    ),
                    Text(
                        "${DateTime.now().difference(pet.petDateOfBirth).inDays.toString()} 天",
                        style: kSubtitle2Style),
                    Row(
                      children: const [
                        Icon(
                          FontAwesomeIcons.mapMarkedAlt,
                          color: kPrimaryColor,
                          size: 15.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "距离",
                          style: kSubtitle2Style,
                        )
                      ],
                    ),
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
              color: const Color.fromRGBO(255, 165, 170, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: SizedBox(
                // height: Global.deviceSize.height * 0.3,
                // width: Global.deviceSize.width * 0.4,
                child: pet.petIconUrl != ""
                    ? Image.network(pet.petIconUrl)
                    : Image.asset("assets/images/User.jpg"),
              ),
            ),
          ),
          // Positioned(
          //   top: Global.deviceSize.height * 0.08,
          //   left: Global.deviceSize.width * 0.035,
          //   // right: 180.0,
          //   // bottom: 30.0,
          //   child: SizedBox(
          //     // height: Global.deviceSize.height * 0.3,
          //     width: Global.deviceSize.width * 0.45,
          //     child: pet.petIconUrl != ""
          //         ? Image.network(pet.petIconUrl)
          //         : Image.asset("assets/images/User.jpg"),
          //   ),
          // ),
        ],
      ),
    );
  }
}
