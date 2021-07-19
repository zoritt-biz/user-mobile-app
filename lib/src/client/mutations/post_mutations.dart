const LIKE_POST = r"""
mutation($user_id: String, $post_id: String){
  postLike(user_id: $user_id, post_id: $post_id){
    _id
  }
}
""";

const UNLIKE_POST = r"""
mutation($user_id: String, $post_id: String){
  postUnlike(user_id: $user_id, post_id: $post_id){
    _id
  }
}
""";
