const GET_ALL_EVENTS_LOGGED_IN = r"""
query(
  $limit: Int, 
  $sort: String,
  $user_id: String,
  $fromDate: String,
){
  getEventsLoggedIn(
    limit: $limit, 
    sort: $sort, 
    user_id: $user_id,
    fromDate: $fromDate
  ){
    _id
    title
    description
    location
    link
    photos
    isInterested
    owner {
      businessName
      location
      logoPics
    }
  }
}
""";

const GET_ALL_EVENTS = r"""
query(
  $limit: Int, 
  $sort: SortFindManyEventInput
){
  eventMany(limit: $limit, sort: $sort){
    _id
    title
    description
    location
    link
    photos
    isInterested
    owner {
        businessName
        location
        logoPics
     }
  }
}
""";
