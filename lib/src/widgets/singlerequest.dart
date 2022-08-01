import 'package:flutter/material.dart';
import 'package:buyer_app/src/screens/requestDescription.dart';

class SingleRequest extends StatelessWidget {
  var buyerName;
  var sellerName;
  var category;
  var deadline;
  var description;
  var price;
  var title;
  var requestID;
  var deleted;
  var buyerID;

  SingleRequest({
    this.buyerName,
    this.sellerName,
    this.category,
    this.deadline,
    this.description,
    this.price,
    this.title,
    this.requestID,
    this.deleted,
    this.buyerID,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price: \$' + price,
            ),
            Text(
              'Deadline: ' + deadline,
            ),
          ],
        ),
        trailing: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RequestDescriptionScreen(
                  buyerName: buyerName,
                  sellerName: sellerName,
                  category: category,
                  deadline: deadline,
                  description: description,
                  price: price,
                  title: title,
                  buyerID: buyerID,
                  requestID: requestID,
                  deleted: deleted,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Icon(
                Icons.info,
                size: 28.0,
                color: Colors.brown.shade500
              ),
              Text(
                'Find out more!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
