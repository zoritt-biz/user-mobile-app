const SIGN_IN = r"""
mutation($email: String!, $password: String!){
  signIn(email: $email, password: $password){
    accessToken
  }
}
""";