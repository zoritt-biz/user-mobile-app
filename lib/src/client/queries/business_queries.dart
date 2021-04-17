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

const GET_BUSINESS_MANY = r"""
query(
  $limit: Int,
  $filter: FilterFindManyBusinessInput,
  $skip:Int
){
  businessMany(limit: $limit, filter: $filter, skip: $skip){
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
    history
    establishedIn
    updatedAt
    createdAt
    pictures
    openHours {
      day
      opens
      closes
    }
  }
}
""";

const GET_BUSINESS_LIST_MANY = r"""
query{
  businessListMany{
    _id,
    autocompleteTerm
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
