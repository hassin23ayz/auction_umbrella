# AuctionUmbrella

# DataBase Modelling
It consists of the following steps 

1. Defining a Schema : the kind of information you need to store in the database table
2. Prepare Migration : using ecto command create migration , add table at migration 
3. Define Changeset  : changes should pass thrugh a changeset [validation purpose]
4. Intercation       : API endpoints -> Public func 

# User Data 
each user of your application carrries session data in their browser that let you know who they are 
- Storing User password in a string column unencrypted is wrong. 
  User password needs to be encrypted and stored in a hashed_password column 
  password is not field thats persisted in the database, it hashed_password 

