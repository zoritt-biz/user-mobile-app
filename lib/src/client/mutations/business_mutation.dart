const record = """
    _id
    businessName
    phoneNumber
    location
    locationDescription
    lat
    lng
    emails
    website
    logoPics
    slogan
    description
    specialization
    history
    state
    establishedIn
    subscription
    isLiked
    updatedAt
    createdAt
    pictures
    branches{
      phoneNumber
      emails
      location
      lat
      lng
      distance
      locationDescription
      pictures
    }
    owner {
      fullName
      email
      phoneNumber
      firebaseId
      businesses {
        _id
        businessName
      }
    }
    openHours {
      day
      opens
      closes
      isOpen
    }
    posts {
      _id
      description
      videos
      photos
      createdAt
    }
    events {
      _id
      title
      description
      location
      link
      startDate
      endDate
      startTime
      endTime
      videos
      photos
      createdAt
    }
    categories {
      _id
      name
      parent
    }
""";

const LIKE_BUSINESS = r"""
mutation($user_id: String, $business_id: String){
  businessAddToFavorite(user_id: $user_id, business_id: $business_id){
    _id
  }
}
""";

const UNLIKE_BUSINESS = r"""
mutation($user_id: String, $business_id: String){
  businessRemoveFromFavorite(user_id: $user_id, business_id: $business_id ){
    _id
  }
}
""";
