const GET_USER = r"""
query($firebaseId: String){
  userOne(filter: {firebaseId: $firebaseId}){
    _id
    fullName
    email
    phoneNumber
    firebaseId
    password
    userType
    businesses {
      _id
    }
  }
}
""";

const GET_USER_PROFILE = r"""
query($firebaseId: String){
  userOne(filter: {firebaseId: $firebaseId}){
    _id
    fullName
    email
    phoneNumber
    firebaseId
    userType
  }
}
""";

const GET_USER_EVENTS = r"""
query($firebaseId: String){
  userOne(filter: {firebaseId: $firebaseId}){
    _id
    interestedInEvents{
      _id
      title
      description
      location
      link
      photos
      isInterested
      owner {
        businessName
        location
        logoPics
      }
    }
  }
}
""";

const GET_USER_POSTS = r"""
query($firebaseId: String){
  userOne(filter: {firebaseId: $firebaseId}){
    _id
    likedPosts{
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
}
""";
