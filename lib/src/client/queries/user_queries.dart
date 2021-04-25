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
    interestedInEvents{
      title
      description
      location
      link
      owner{
        businessName
      }
    }
    likedPosts{
      description
      photos
      owner{
        businessName
        logoPics
        location
      }
    }
  }
}
""";
