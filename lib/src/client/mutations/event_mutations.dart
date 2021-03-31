const CREATE_EVENT = r"""
mutation (
  $title: String, 
  $description: String, 
  $location: String, 
  $link: String,
  $videos: [String],
  $photos: [String],
){
  eventCreateOne(record: {
    title: $title,
    description:$description,
    location: $location,
    link: $link,
    videos: $videos,
    photos:$photos,
  }){
    record{
      _id
    }
  }
}
""";