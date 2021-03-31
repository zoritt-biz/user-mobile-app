const GET_ALL_CATEGORIES = r"""
query{
  categoryMany{
    _id
    name
    parent
    autocompleteTerm
  }
}
""";
