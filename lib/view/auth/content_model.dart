class UnboardingContent{
  String image;
  String title;
  String discription;
  UnboardingContent({required this.image,required this.title,required this.discription});
}
List<UnboardingContent>contents=[
  UnboardingContent(
    title: "High Preformance",
    image: "assets/images/2bDzvyw28.png",
    discription: "Detect skin cancer and Determine the type of the cancer",

  ),
  UnboardingContent(
    title: "Detection",
    image: "assets/images/vecteezy_build-robots-with-artificial-intelligence-chips_.jpg",
    discription: "Detect and Classification the types of skin cancer by image processing techniques"
  ),
  UnboardingContent(image: "assets/images/POMtYLHFY.png", title: "Security", discription:"Not anyone enter to App without enter email or password")
];