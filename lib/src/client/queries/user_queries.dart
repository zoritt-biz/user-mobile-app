const GET_USER = r"""
query($firebaseId: String){
  userOne(filter: {firebaseId: $firebaseId}){
    _id
    firstName
    middleName
    lastName
    email
    phoneNumber
    firebaseId
    password
    image
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
    firstName
    middleName
    lastName
    email
    image
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
      startDate
      endDate
      startTime
      endTime
      videos
      owner {
          _id
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
    videos
    isLiked
    createdAt
    owner {
        _id
        businessName
        location
        logoPics
      }
    }
  }
}
""";
