const GET_EVENTS = r"""
query(
  $page: Int
  $perPage: Int
  $today: Date
){
  eventPagination(
    page: $page
    perPage: $perPage
    sort: STARTDATE_ASC
    filter: {
      _operators: {
        endDate: {gte: $today}
      }
    }
  ){
    count
    items{
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
      isInterested
      interestedUsers
      likeCount
      owner{
        _id
        businessName
        location
        logoPics
      }
    }
    pageInfo{
      currentPage
      perPage
      pageCount
      itemCount
      hasNextPage
      hasPreviousPage
    }
  }
}
""";
