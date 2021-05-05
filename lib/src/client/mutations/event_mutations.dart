const LIKE_EVENT = r"""
mutation($user_id: String, $event_id: String){
  eventPushToArray(user_id: $user_id, event_id: $event_id){
    _id
  }
}
""";