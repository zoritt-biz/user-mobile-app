const CREATE_USER = r"""
mutation(
  $fullName: String, 
  $userType: EnumUserUserType, 
  $email: String,
  $phoneNumber: String,
  $firebaseId: String,
){
  userCreateOne(
    record: {
      fullName: $fullName, 
      userType: $userType,
      email: $email,
      phoneNumber: $phoneNumber,
      firebaseId: $firebaseId,
    }
  ){
    record {
      _id
    }
  }
}
""";

const UPDATE_USER_BUSINESSES = r"""
mutation(
  $firebaseId: String
  $businesses: [MongoID]
){
  userUpdateOne(
    filter: {
      firebaseId : $firebaseId
    }, 
    record: {
      businesses: $businesses
    }){
    record{
      _id
    }
  }
}
""";