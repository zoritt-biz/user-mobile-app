const SIGN_IN = r"""
mutation($email: String!, $password: String!){
  signIn(email: $email, password: $password){
    accessToken
    roles
    user{
      _id
      firebaseId
      firstName
      middleName
      lastName
      email
      phoneNumber
      image
      status
      account{
        verification{
          verified
        }
      }
    }
  }
}
""";

const SIGN_UP = r"""
mutation(
  $email: String!
  $password: String!
  $firstName: String!
  $middleName: String!
  $lastName: String!
  $phoneNumber: String!
){
  userSignUp(
    email: $email
    password: $password
    firstName: $firstName
    middleName: $middleName
    lastName: $lastName
    phoneNumber: $phoneNumber
  ){
    accessToken
    roles
    user{
      _id
      firebaseId
      firstName
      middleName
      lastName
      email
      phoneNumber
      image
      status
      account{
        verification{
          verified
        }
      }
    }
  }
}
""";
