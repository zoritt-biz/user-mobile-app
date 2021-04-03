const GET_ALL_POSTS=r"""
query($limit:Int,$sort:SortFindManyPostInput,$filterDate:Date,$skip:Int){
  postMany(limit:$limit,skip:$skip,sort:$sort,filter:{_operators: {createdAt: {gt:$filterDate}}, 
   }){
    _id
    description
    photos
    owner{
        businessName
        logoPics
        }
  }
}


""";