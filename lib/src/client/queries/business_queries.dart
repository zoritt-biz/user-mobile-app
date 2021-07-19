const GET_BUSINESS_DETAIL = r"""
query ($id: MongoID!){
  businessById(_id: $id){
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
    state
    description
    specialization
    history
    establishedIn
    subscription
    updatedAt
    createdAt
    isLiked
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
  }
}
""";

const GET_BUSINESS_DETAIL_LOGGED_IN = r"""
query ($user_id: String, $business_id: String){
  businessByIdLoggedIn(user_id: $user_id, business_id: $business_id){
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
    isLiked
    state
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
      isOpen
    }
    posts {
      _id
      description
      videos
      photos
      createdAt
      isLiked
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
      isInterested
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
      state: ACTIVE,
      _operators: {
        searchIndex: {in: $searchArray}
      }
        },
    limit: $limit,
    sort: SUBSCRIPTION_DESC
  ){
    _id
    businessName
    phoneNumber
    subscription
    location
    emails
    website
    logoPics
    isLiked
    state
    pictures
    locationDescription
    lat
    lng
  }
}
""";

const GET_BUSINESS_RELATED_MANY = r"""
query($searchArray: [String], $limit: Int, $id: MongoID){
  businessMany(
    filter: {
      state: ACTIVE,
      _operators: {
        searchIndex: {in: $searchArray}
        _id: {ne: $id}
      }
    }
    limit: $limit,
    sort: SUBSCRIPTION_DESC
  ){
    _id
    businessName
    phoneNumber
    location
    emails
    isLiked
    state
    website
    logoPics
    pictures
    locationDescription
    lat
    lng
  }
}
""";

const GET_BUSINESS_BY_FILTER = r"""
query($searchArray: [String], $limit: Int, $day: String){
  businessMany(
    filter: {
      state: ACTIVE,
      _operators: {
        searchIndex: {in: $searchArray},
      }
      openHours: {day: $day, isOpen: true}
    }
    limit: $limit,
    sort: SUBSCRIPTION_DESC
  ){
    _id
    businessName
    phoneNumber
    location
    emails
    website
    logoPics
    isLiked
    state
    pictures
    locationDescription
    lat
    lng
  }
}
""";

const GET_BUSINESS_LIST_MANY = r"""
query{
  businessListMany(limit: 2000, sort: AUTOCOMPLETETERM_ASC){
    _id,
    autocompleteTerm
  }
}
""";

const GET_FAVORITES_LIST_MANY = r"""
query($id: MongoID!){
  userOne(filter: {_id: $id}){
    favorites{
      _id
      businessName
      phoneNumber
      location
      isLiked
      state
      emails
      website
      logoPics
      pictures
      locationDescription
      lat
      lng
    }
  }
}
""";

const GET_SPONSORED_BUSINESSES = r"""
query ($subscriptions: EnumBusinessSubscription, $limit: Int){
  businessMany(filter: {
    subscription: $subscriptions,
    state: ACTIVE
  },
    limit: $limit
  ){
    _id
    businessName
    phoneNumber
    location
    emails
    isLiked
    state
    website
    logoPics
    pictures
    locationDescription
    lat
    lng
  }
}
""";

const GET_BUSINESSES_BY_FILTER_AND_LOCATION = r"""
query(
  $lat: Float,
  $lng: Float,
  $distance: Int,
  $query: [String]
){
   businessFilterByLocationAndFilter(
    lat: $lat, 
    lng: $lng, 
    distance: $distance,
    query: $query
  ){
    _id
    businessName
    phoneNumber
    location
    emails
    isLiked
    state
    website
    distance
    logoPics
    pictures
    locationDescription
    lat
    lng
  }
}
""";

const GET_BUSINESSES_BY_LOCATION = r"""
query(
  $lat: Float,
  $lng: Float,
  $distance: Int,
  $query: [String]
){
   businessFilterByLocation(
    lat: $lat, 
    lng: $lng, 
    distance: $distance,
    query: $query
  ){
    _id
    businessName
    phoneNumber
    location
    emails
    website
    isLiked
    state
    logoPics
    pictures
    locationDescription
    distance
    lat
    lng
  }
}
""";

const GET_BUSINESSES_BY_FILTER = r"""
query($query: [String]){
   businessFilterByFilter(query: $query){
    _id
    businessName
    phoneNumber
    location
    emails
    isLiked
    state
    website
    logoPics
    pictures
    locationDescription
    lat
    lng
  }
}
""";
