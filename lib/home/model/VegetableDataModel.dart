class VegetableDataResponse
{
	String statusCode;
	List<VegetableData> readVegetableDataList;
	
	VegetableDataResponse.fromJson(Map<String, dynamic> json)
	{
		statusCode = json['statusCode'];
		
		if (json['responseList'] != null)
		{
			readVegetableDataList = new List<VegetableData>();
			json['responseList'].forEach((v) {
				readVegetableDataList.add(new VegetableData.fromJson(v));
			});
		}
	}
}

class VegetableData
{
	int id, catId, subcatId;
	String title, actualPrice, imageUrl, tetraPrice, discount, quantity, alertQty, status, category, subcategory;
	
	VegetableData.fromJson(Map<String, dynamic> categoryListData)
	{
		id = categoryListData['pid'];
		catId = categoryListData['cat_id'];
		subcatId = categoryListData['subcat_id'];
		title = categoryListData['pname'];
		imageUrl = categoryListData['pimg'];
		actualPrice = categoryListData['actual_price'];
		tetraPrice = categoryListData['tetra_price'];
		discount = categoryListData['discount'];
		quantity = categoryListData['quantity'];
		alertQty = categoryListData['alert_qty'];
		status = categoryListData['status'];
		category = categoryListData['category'];
		subcategory = categoryListData['subcategory'];
	}
}