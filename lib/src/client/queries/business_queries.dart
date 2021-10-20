const GET_BUSINESS_DETAIL = r"""
query ($id: MongoID!){
  businessById(_id: $id){
    _id
    businessName
    phoneNumbers
    location
    locationDescription
    branch
    lngLat{
      coordinates
    }
    emails
    website
    logoPics
    slogan
    description
    specialization
    history
    establishedIn
    subscription
    updatedAt
    createdAt
    isLiked
    favoriteList
    likeCount
    pictures
    openHours {
      day
      opens
      closes
      isOpen
    }
    posts {
      _id
      description
      descriptionList{
        field
        value
      }
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

const GET_BUSINESS_BY_FILTER = r"""
query(
  $distance: Int
  $category: [String]
  $query: [String]
  $openNow: Boolean
  $lat: Float
  $lng: Float
  $page: Int!
  $perPage: Int!
){
  getBusinessesByFilter(
    distance: $distance
    category: $category
    query: $query
    openNow: $openNow
    lat: $lat
    lng: $lng
    page: $page
    perPage: $perPage
  ){
    items{
      _id
      businessName
      distance
      branch
      phoneNumbers
      emails
      website
      logoPics
      location
      locationDescription
      lngLat{
        coordinates
      }
      description
      pictures
      isLiked
      favoriteList
      categories{
        name
        parent
        autocompleteTerm
      }
      createdAt
      updatedAt
    }
    total
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

const GET_SPONSORED_BUSINESSES = r"""
query($limit: Int){
  sponsoredMany(
    filter:{
    	state: ACTIVE
  	}
    limit: $limit
  ){
    _id
    businessName
    phoneNumbers
    emails
    website
    logoPics
    location
    locationDescription
    lat
    lng
    distance
    slogan
    description
    pictures
    categories{
      name
      parent
    }
  }
}
""";
