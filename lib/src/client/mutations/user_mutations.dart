const CREATE_USER = r"""
mutation(
  $firstName: String,
  $lastName: String, 
  $userType: EnumUserUserType, 
  $email: String,
  $phoneNumber: String,
  $firebaseId: String,
){
  userCreateOne(
    record: {
      firstName: $firstName,
      lastName: $lastName, 
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
      userType
    }
  }
}
""";
