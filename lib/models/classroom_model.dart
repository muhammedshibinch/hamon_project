class Room {
  Room({
    required this.id,
    required this.layout,
    required this.name,
    required this.size,
    required this.subject,
  });

  int id;
  String layout;
  String name;
  int size;
  int? subject;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
      id: json["id"],
      layout: json["layout"],
      name: json["name"],
      size: json["size"],
      subject: json["subject"] == "" ? null : json["subject"]);
}
