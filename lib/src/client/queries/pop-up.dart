const GET_POP_UP = r"""
query($category: String){
  popUpOne(filter: {
    category: $category
  }){
    _id
    image
    category
  }
}
""";
