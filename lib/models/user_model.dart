// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final int point;
  final String rank;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.point,
    required this.rank,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      profileImage,
      point,
      rank,
    ];
  }

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>;
    return User(
      id: userDoc.id,
      name: userData['name'],
      email: userData['email'],
      profileImage: userData['profileImage'],
      point: userData['point'],
      rank: userData['rank'],
    );
  }

  factory User.initialUser() {
    return const User(
      id: "",
      name: "",
      email: "",
      profileImage: "",
      point: -1,
      rank: "",
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    int? point,
    String? rank,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      point: point ?? this.point,
      rank: rank ?? this.rank,
    );
  }

  @override
  String toString() {
    return "User(id:$id, name:$name, email:$email, profileImage:$profileImage, point:$point, rank:$rank)";
  }
}
