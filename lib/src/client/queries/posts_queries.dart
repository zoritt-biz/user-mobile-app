const GET_POSTS = r"""
query(
  $page: Int
  $perPage: Int
  $filterDate: Date
){
  postPagination(
    page: $page
    perPage: $perPage
    filter: {
      _operators: {
        createdAt: { gte: $filterDate }
      }
   }
    sort: CREATEDAT_DESC
  ){
    items{
      _id
      description
      descriptionList{
        field
        value
      }
      photos
      videos
      isLiked
      createdAt
      likeCount
      likeList
      owner {
        _id
        businessName
        location
        logoPics
      }
    }
    count
    pageInfo{
      currentPage
      perPage
      pageCount
      itemCount
      hasNextPage
      hasPreviousPage
    }
  }
}
""";
