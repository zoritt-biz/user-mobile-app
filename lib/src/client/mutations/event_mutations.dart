const LIKE_EVENT = r"""
mutation($eventId: String!){
  eventLikeUnLike(eventId: $eventId){
    title
  }
}
""";

