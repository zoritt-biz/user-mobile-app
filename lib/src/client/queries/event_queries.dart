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
    startDate
    endDate
    startTime
    endTime
    videos
    owner {
      _id
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
  $filterDate: Date,
  $now: Date
){
  eventMany(limit: $limit, sort: STARTDATE_DESC,
  filter: {
      _operators: {
        createdAt: { gte: $filterDate },
        endDate: { gte: $now }
      }
  },
  ){
    _id
    title
    description
    location
    link
    photos
    isInterested
    startDate
    endDate
    startTime
    endTime
    videos
    owner {
        _id
        businessName
        location
        logoPics
     }
  }
}
""";
