const GET_POSTS_LOGGED_IN = r"""
query(
  $limit: Int,
  $sort: String,
  $fromDate: String,
  $user_id: String
){
  getPostLoggedIn(
    user_id: $user_id
    limit: $limit
    fromDate: $fromDate
    sort: $sort
  ){
    _id
    description
    photos
    isLiked
    createdAt
    owner {
        businessName
        location
        logoPics
    }
  }
}
""";

const GET_ALL_POSTS = r"""
query(
  $limit: Int,
  $sort: SortFindManyPostInput,
  $filterDate: Date,
  $skip: Int
){
  postMany(
    limit: $limit,
    skip: $skip,
    sort: $sort,
    filter: {
      _operators: {
        createdAt: { gt: $filterDate }
      }, 
   }
  ){
    _id
    description
    photos
    createdAt
    owner {
        businessName
        location
        logoPics
    }
  }
}
""";
