const USER_ADD_LOGO = r"""
mutation(
  $id: MongoID!,
  $image: String
){
  userUpdateById(
    _id: $id,
    record: {
      image: $image
    }
  ){
    record {
      _id
      firstName
      middleName
      lastName
      email
      image
      phoneNumber
      firebaseId
    }
  }
}
""";

const LIKE_POST = r"""
mutation($postId: String!){
  postLikeUnLike(postId: $postId){
    description
  }
}
""";

const LIKE_EVENT = r"""
mutation($eventId: String!){
  eventLikeUnLike(eventId: $eventId){
    title
  }
}
""";

const LIKE_BUSINESS = r"""
mutation($businessId: String!){
  businessLikeUnLike(businessId: $businessId){
    businessName
  }
}
""";
