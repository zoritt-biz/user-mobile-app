const GET_ALL_CATEGORIES = r"""
query{
  mainCategoryListMany(sort: NAME_ASC){
    name
    image
    sub_categories
  }
}
""";
