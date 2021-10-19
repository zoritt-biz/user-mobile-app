const LIKE_POST = r"""
mutation($postId: String!){
  postLikeUnLike(postId: $postId){
    description
  }
}
""";

