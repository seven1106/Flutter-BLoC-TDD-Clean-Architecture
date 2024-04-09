enum BlogCategoryEnum {
  tech('Technology'),
  business('Business'),
  guides('Guides'),
  reviews('Reviews'),
  others('Others');

  const BlogCategoryEnum(this.type);
  final String type;
}

extension ConvertBlogCategory on String {
  BlogCategoryEnum toBlogCategoryEnum() {
    switch (this) {
      case 'Technology':
        return BlogCategoryEnum.tech;
      case 'Business':
        return BlogCategoryEnum.business;
      case 'Guides':
        return BlogCategoryEnum.guides;
      case 'Reviews':
        return BlogCategoryEnum.reviews;
      default:
        return BlogCategoryEnum.others;
    }
  }
}
