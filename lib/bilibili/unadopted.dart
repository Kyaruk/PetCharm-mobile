import 'pet.dart';

class PetS{
  final List<Pet> unadoptedPets;
  // List<String> images;
  PetS({
    required this.unadoptedPets,
    // required this.userImage,
    // required this.userName,
  });

  PetS.fromJson(Map<String, dynamic> json)
      : unadoptedPets = json["pets_info"] ?? "";

// Map<String, dynamic> toJson() =>
//     <String, dynamic>{
//       "postCover": cover,
//       "postTitle": title,
//       "postAuthor": author,
//       "postContent": content,
//       "postDate": date,
//     };
}
//
// List<Pet> petList = [
//   Pet(
//     name: "MI",
//     type: "Cat",
//     isMale: "false",
//     breed: "aaa",
//     // address: "210 Street",
//     // age: "1",
//     datetime: "Jan 21 2020",
//     // description: "This is description",
//     // distance: "3.1",
//     // userImage: "assets/user2.jpg",
//     // userName: "Dicky",
//     // image: "assets/abys1.png",
//     // images: [
//     //   "assets/abys1.png",
//     //   "assets/abys2.png",
//     //   "assets/abys3.png",
//     // ],
//   ),
//   Pet(
//     name: "Banthan",
//     type: "Cat",
//     isMale: "true",
//     breed: "bbb",
//     // address: "Africa Street",
//     // age: "2",
//     datetime: " 21 2020",
//     // description: "This is description",
//     // distance: "3.1",
//     // userImage: "assets/user2.jpg",
//     // userName: "Dicky",
//     // image: "assets/abys1.png",
//     // images: [
//     //   "assets/abys1.png",
//     //   "assets/abys2.png",
//     //   "assets/abys3.png",
//     // ],
//   ),
//   Pet(
//     name: "Banthan",
//     type: "Cat",
//     isMale: "true",
//     breed: "ccc",
//     // address: "Africa Street",
//     // age: "2",
//     datetime: " 21 2020",
//     // description: "This is description",
//     // distance: "3.1",
//     // userImage: "assets/user2.jpg",
//     // userName: "Dicky",
//     // image: "assets/abys1.png",
//     // images: [
//     //   "assets/abys1.png",
//     //   "assets/abys2.png",
//     //   "assets/abys3.png",
//     // ],
//   )
// ];

