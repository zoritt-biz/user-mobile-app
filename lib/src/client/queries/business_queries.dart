const GET_BUSINESS_DETAIL = r"""
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
    searchIndex
    history
    establishedIn
    subscription
    updatedAt
    createdAt
    pictures
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
      owner {
        businessName
        location
        logoPics
      }
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
      owner {
        businessName
        location
        logoPics
      }
    }
    categories {
      _id
      name
      parent
    }
  }
}
""";

const GET_BUSINESS_MANY = r"""
query($searchArray: [String], $limit: Int){
  businessMany(
    filter: {
      _operators: {
        searchIndex: {in: $searchArray}
      }
    }
    limit: $limit
  ){
    _id
    businessName
    phoneNumber
    location
    emails
    website
    logoPics
    pictures
  }
}
""";

const GET_BUSINESS_RELATED_MANY = r"""
query($searchArray: [String], $limit: Int, $id: MongoID){
  businessMany(
    filter: {
      _operators: {
        searchIndex: {in: $searchArray}
        _id: {ne: $id}
      }
    }
    limit: $limit
  ){
    _id
    businessName
    phoneNumber
    location
    emails
    website
    logoPics
    pictures
  }
}
""";

const GET_BUSINESS_BY_FILTER = r"""
query($searchArray: [String], $limit: Int, $day: String){
  businessMany(
    filter: {
      _operators: {
        searchIndex: {in: $searchArray},
      }
      openHours: {day: $day, isOpen: true}
    }
    limit: $limit
  ){
    _id
    businessName
    phoneNumber
    location
    emails
    website
    logoPics
    pictures
  }
}
""";

const GET_BUSINESS_LIST_MANY = r"""
query{
  businessListMany(limit: 2000){
    _id,
    autocompleteTerm
  }
}
""";

const GET_FAVORITES_LIST_MANY = r"""
query($id: MongoID!){
  userById(_id: $id){
    favorites{
      _id
      businessName
      phoneNumber
      location
      emails
      website
      logoPics
      pictures
    }
  }
}
""";

const GET_SPONSORED_BUSINESSES = r"""
query ($subscriptions: EnumBusinessSubscription, $limit: Int){
  businessMany(filter: {
    subscription: $subscriptions
  },
    limit: $limit
  ){
    _id
    businessName
    phoneNumber
    location
    emails
    website
    logoPics
    pictures
  }
}
""";
