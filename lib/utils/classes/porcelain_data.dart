class PorcelainData {
  final String date;
  final int id;
  final int weekOf;
  final int totalEntries;
  final PictureList pictureList;

  PorcelainData({
    required this.id,
    required this.date,
    required this.weekOf,
    required this.totalEntries,
    required this.pictureList,
  });

  factory PorcelainData.fromJson(Map<String, dynamic> json) {
    return PorcelainData(
      id: json['id'],
      date: json['date'],
      weekOf: json['week_of'],
      totalEntries: json['total_entries'],
      pictureList: PictureList.fromJson(json['picture_list']),
    );
  }
}

class PictureList {
  final String sizeOfPhoto;
  final String complete;
  final String initials;
  final int productionOcPictureId;
  final int orderId;

  PictureList({
    required this.sizeOfPhoto,
    required this.complete,
    required this.initials,
    required this.productionOcPictureId,
    required this.orderId,
  });

  factory PictureList.fromJson(Map<String, dynamic> json) {
    return PictureList(
      sizeOfPhoto: json['size_of_photo'],
      complete: json['complete'],
      initials: json['initials'],
      productionOcPictureId: json['production_oc_picture_id'],
      orderId: json['order_id'],
    );
  }
}
