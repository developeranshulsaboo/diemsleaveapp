class Request {
  final String id;
  final String status;
  Request({this.id, this.status});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(id: json['id'], status: json['status']);
  }
}
