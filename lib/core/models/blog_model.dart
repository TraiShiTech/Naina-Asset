class BlogModel {
  BlogModel(this.id, this.imgPath, this.title, this.budget, this.timespan,
      this.status, this.size, this.location);

  final int id;
  final String imgPath;
  final String title;
  final String budget;
  final String timespan;
  final String status;
  final String size;
  final String location;
}

List<BlogModel> blogmodel = [
  for (int index = 0; index < 90; index++)
    BlogModel(
      index + 1,
      'https://images.unsplash.com/photo-1600121848594-d8644e57abab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
      'Harvard Square Residence',
      'Simple Juice Recipes to boost your immune system With over 10+ years of experience in real estate industry',
      '2022-2023',
      'Completed',
      '23000 m',
      'NY, USA',
    ),
];
