class StoreInfo {
  late final String schedule;
  late final String title;

  //StoreInfo({required this.schedule, required this.title});

  StoreInfo.fromJson(Map<String, dynamic> json) {
    schedule = json['schedule'];
    title = json['title'];
  }
}
