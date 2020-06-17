class FoodModel {
  String _provinceCode;
  String _provinceName;
  String _dateMenu;
  int _id;
  String _itemCode;
  String _itemName;
  String _unitOfMeasure;
  int _unitPrice;
  int _discountAmount;
  int _minimumOrderQty;
  int _maximumOrderQty;
  String _itemCategoryCode;
  String _thumbnail;
  String _imageUrl;
  String _description;

  FoodModel(
      this._provinceCode,
      this._provinceName,
      this._dateMenu,
      this._id,
      this._itemCode,
      this._itemName,
      this._unitOfMeasure,
      this._unitPrice,
      this._discountAmount,
      this._minimumOrderQty,
      this._maximumOrderQty,
      this._itemCategoryCode,
      this._thumbnail,
      this._imageUrl,
      this._description);

  FoodModel.map(dynamic obj) {
    this._provinceCode = obj["provinceCode"] as String;
    this._provinceName = obj["provinceName"] as String;
    this._dateMenu = obj["dateMenu"] as String;
    this._id = obj["id"] as int;
    this._itemCode = obj["itemCode"] as String;
    this._itemName = obj["itemName"] as String;
    this._unitOfMeasure = obj["unitOfMeasure"] as String;
    this._unitPrice = obj["unitPrice"] as int;
    this._discountAmount = obj["discountAmount"] as int;
    this._minimumOrderQty = obj["minimumOrderQty"] as int;
    this._maximumOrderQty = obj["maximumOrderQty"] as int;
    this._itemCategoryCode = obj["itemCategoryCode"] as String;
    this._thumbnail = obj["thumbnail"] as String;
    this._imageUrl = obj["_imageUrl"] as String;
    this._description = obj["description"] as String;
  }
}
