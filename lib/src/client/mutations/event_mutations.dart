const LIKE_EVENT = r"""
mutation($user_id: String, $event_id: String){
  eventLike(user_id: $user_id, event_id: $event_id){
    _id
  }
}
""";

const UNLIKE_EVENT = r"""
mutation($user_id: String, $event_id: String){
  eventUnlike(user_id: $user_id, event_id: $event_id){
    _id
  }
}
""";
