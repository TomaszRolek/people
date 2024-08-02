import '../constants.dart';

class Person {
  final int? id;
  final String firstName;
  final String lastName;
  final String birthDate;
  final String address;
  final List<int> userGroups;

  Person({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.address,
    required this.userGroups,
  });

  Person copy({
    int? id,
    String? firstName,
    String? lastName,
    String? birthDate,
    String? address,
    List<int>? userGroups,
  }) =>
      Person(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        birthDate: birthDate ?? this.birthDate,
        address: address ?? this.address,
        userGroups: userGroups ?? this.userGroups,
      );

  static Person fromJson(Map<String, Object?> json) {
    final userGroupsString = json[PersonFields.userGroups] as String?;

    final userGroups = userGroupsString == null || userGroupsString.isEmpty
        ? <int>[]
        : userGroupsString.split(',').map((id) => int.parse(id)).toList();

    return Person(
      id: json[PersonFields.id] as int?,
      firstName: json[PersonFields.firstName] as String,
      lastName: json[PersonFields.lastName] as String,
      birthDate: json[PersonFields.birthDate] as String,
      address: json[PersonFields.address] as String,
      userGroups: userGroups,
    );
  }

  Map<String, Object?> toJson() => {
        PersonFields.id: id,
        PersonFields.firstName: firstName,
        PersonFields.lastName: lastName,
        PersonFields.birthDate: birthDate,
        PersonFields.address: address,
        PersonFields.userGroups: userGroups.join(','),
      };
}
