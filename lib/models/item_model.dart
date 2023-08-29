 class ItemModel{
  final String name;
  final String price;
  final String img;

  ItemModel( {
    required this.name, 
    required this.price,
    required this.img});
}

List<ItemModel> projects = [
  ItemModel(
    name: 'Royal Palm Sofa',
    price: '\$50',
    img: 'assets/images/sofa1.png',
    
  ),
  ItemModel(
    name: 'Leatherette Sofa',
    price: '\$30',
    img: 'assets/images/sofa2.png',
    
  ),
  ItemModel(
    name: 'Modern Sofa',
    price:'\$45',
    img: 'assets/images/sofa3.png',
    
  ),
  ItemModel(
     name: 'Leatherette Sofa',
    price: '\$20.99',
    img: 'assets/images/sofa4.png',
    
  )
];
