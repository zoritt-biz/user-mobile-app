const GET_BUSINESS_DETAIL = r"""
query ($id: MongoID!){
  businessById(_id: $id){
    _id
    businessName
    phoneNumbers
    location
    locationDescription
    branches{
      _id
    }
    lngLat{
      coordinates
    }
    menu{
      _id
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

const GET_BUSINESS_MENUS = r"""
query ($id: MongoID!){
  businessById(_id: $id){
    menu{
      _id
      category
      menuList{
        _id
        image
        name
        price
        discount
        description
      }
    }
  }
}
""";

const GET_BUSINESS_BRANCHES = r"""
query ($id: MongoID!){
  businessById(_id: $id){
    branches{
      _id
      businessName
      location
      locationDescription
      phoneNumbers
      lngLat{
        coordinates
      }
      categories{
        name
      }
    }
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
query{
  sponsoredMany(
    filter:{
    	state: ACTIVE
  	}
    limit: 5
  ){
    _id
    businessName
    phoneNumbers
    emails
    website
    logoPics
    location
    locationDescription
    lngLat{
      coordinates
    }
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
