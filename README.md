Ruby on Rails assignment

You need to add few features to a simple inventory management application
attached here which helps a supplier to keep track of their past and current inventory.
The application currently has 2 pages:

● Item listing page with pagination
● Item upload / import page using CSV (currently it only supports CSV with
columns name, weight and price) - attached is the sample csv that it currently
supports.

See item.rb to know more about various attributes and their use case.

Features to be added:

1. Current CSV upload feature allows you to set price of an item using column
“price”. This is total price of the item. As a user, I should be able to set price of an
item by using either “Price per unit" i.e. (Price/ weight) OR "Price" OR both in a
CSV file.
2. As a user, I should be able to update an item's price or weight by reuploading
the CSV file post modification.
3. As a user, I should be able to
a. syncronize my inventory - i.e. the uploaded file is my complete current
inventory. Any item that's not present in the file must be moved to
"delisted" state.

AND

b. upload just the changes - the uploaded file contains just the rows with
changes to price AND/OR new addition. It’s not your complete inventory
but just the changes.

4. Bonus - As a user, I should be able to filter items by “State” (dropdown or toggle)

See comments in item.rb for more information. Also, let us know if there is something
that you would have done differently for this application.

Share the entire code with added features upon completion of assignment duration.