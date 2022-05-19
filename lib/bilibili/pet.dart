import 'pet.dart';

class Pet{
  final String name;
  final String type;
  final String breed;
  // final String age;
  // final String distance;
  // final String address;
  final String isMale;
  // final String userImage;
  // final String userName;
  final String datetime;
  // final String description;
  // final String image;
  // List<String> images;
  Pet({
    required this.name,
    // required this.address,
    // required this.age,
    required this.datetime,
    required this.breed,
    // required this.description,
    // required this.distance,
    // required this.image,
    // required this.images,
    required this.isMale,
    required this.type,
    // required this.userImage,
    // required this.userName,
  });

  Pet.fromJson(Map<String, dynamic> json)
      : name = json["petName"] ?? "",
        type = json["petType"] ?? "",
        breed = json["petBreed"] ?? "",
        isMale = json["petGender"] ?? "",
        datetime = json["petDateOfBirth"] ?? "";

  // Map<String, dynamic> toJson() =>
  //     <String, dynamic>{
  //       "postCover": cover,
  //       "postTitle": title,
  //       "postAuthor": author,
  //       "postContent": content,
  //       "postDate": date,
  //     };
}

List<Pet> petList = [
  Pet(
    name: "MI",
    type: "Cat",
    isMale: "false",
    breed: "aaa",
    // address: "210 Street",
    // age: "1",
    datetime: "Jan 21 2020",
    // description: "This is description",
    // distance: "3.1",
    // userImage: "assets/user2.jpg",
    // userName: "Dicky",
    // image: "assets/abys1.png",
    // images: [
    //   "assets/abys1.png",
    //   "assets/abys2.png",
    //   "assets/abys3.png",
    // ],
  ),
  Pet(
    name: "Banthan",
    type: "Cat",
    isMale: "true",
    breed: "bbb",
    // address: "Africa Street",
    // age: "2",
    datetime: " 21 2020",
    // description: "This is description",
    // distance: "3.1",
    // userImage: "assets/user2.jpg",
    // userName: "Dicky",
    // image: "assets/abys1.png",
    // images: [
    //   "assets/abys1.png",
    //   "assets/abys2.png",
    //   "assets/abys3.png",
    // ],
  ),
  Pet(
    name: "Banthan",
    type: "Cat",
    isMale: "true",
    breed: "ccc",
    // address: "Africa Street",
    // age: "2",
    datetime: " 21 2020",
    // description: "This is description",
    // distance: "3.1",
    // userImage: "assets/user2.jpg",
    // userName: "Dicky",
    // image: "assets/abys1.png",
    // images: [
    //   "assets/abys1.png",
    //   "assets/abys2.png",
    //   "assets/abys3.png",
    // ],
  )
];

