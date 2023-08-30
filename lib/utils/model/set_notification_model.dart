class SetNotificationModel {
  final String? image;
  bool? isFirstDone;
  bool? isSecondDone;
  final String? title;
  final String? subTitle;

  SetNotificationModel(
      {this.image,
      this.title,
      this.subTitle,
      this.isFirstDone,
      this.isSecondDone});
}
