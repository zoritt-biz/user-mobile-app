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
