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
mutation($businessId: String!){
  businessLikeUnLike(businessId: $businessId){
    businessName
  }
}
""";
