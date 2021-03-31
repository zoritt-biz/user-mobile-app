const CREATE_POST = r"""
mutation ($description: String, $videos: [String], $photos: [String]){
  postCreateOne(record:{
    description: $description,
    videos: $videos,
    photos: $photos,
  }){
    record{
      _id
    }
  }
}
""";