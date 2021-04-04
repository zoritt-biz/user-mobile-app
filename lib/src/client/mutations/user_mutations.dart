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
