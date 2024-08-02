import '../constants.dart';

class Group {
  final int? id;
  final String name;
  final List<int> persons;

  Group({
    this.id,
    required this.name,
    required this.persons,
  });

  Group copy({
    int? id,
    String? name,
    List<int>? persons,
  }) =>
      Group(
        id: id ?? this.id,
        name: name ?? this.name,
        persons: persons ?? this.persons,
      );

  static Group fromJson(Map<String, Object?> json) {
    final personsString = json[GroupFields.persons] as String?;

    final persons = personsString == null || personsString.isEmpty
        ? <int>[]
        : personsString.split(',').map((id) => int.parse(id)).toList();

    return Group(
      id: json[GroupFields.id] as int?,
      name: json[GroupFields.name] as String,
      persons: persons,
    );
  }

  Map<String, Object?> toJson() =>
      {
        GroupFields.id: id,
        GroupFields.name: name,
        GroupFields.persons: persons.join(','),
      };
}