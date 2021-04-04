const GET_BUSINESS = r"""
query ($id: MongoID!){
  businessById(_id: $id){
    _id
    businessName
    phoneNumber
    location
    emails
    website
    logoPics
    slogan
    description
    specialization
    categoriesName
    history
    establishedIn
    subscription
    updatedAt
    createdAt
    pictures
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
      videos
      photos
      createdAt
    }
    categories {
      _id
      name
      parent
    }
  }
}
""";
