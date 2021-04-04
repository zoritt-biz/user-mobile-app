const GET_ALL_EVENTS = r"""
query($limit:Int,$sort:SortFindManyEventInput){
  eventMany(limit:$limit,sort:$sort){
    _id
    title
    description
    location
    link
    photos
    owner{
        businessName
        logoPics
     }
  }
}


""";
