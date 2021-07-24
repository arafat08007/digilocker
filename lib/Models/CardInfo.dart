class CardInfo {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final List<String> images;
  final String personImage;
  final String orgImage;

  CardInfo(
      this.position, {
        this.name,
        this.iconImage,
        this.description,
        this.images,
        this.personImage,
        this.orgImage
      });
}