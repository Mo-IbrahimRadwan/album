class Album {
  final int id;
  final String title;
  int qty;
  final int price;
  final String albumCover;
  final List<dynamic> images;

  Album(
      {required this.id,
      required this.title,
      required this.qty,
      required this.price,
      required this.albumCover,
      required this.images});
}
