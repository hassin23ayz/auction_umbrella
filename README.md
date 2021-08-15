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
  password is not a field thats persisted in the database, it hashed_password 

# Custom Plug Authenticator 
When the connection finally hits the plug AuctionWeb.Authenticator line, it knows
to call init/1 and then call/2 from that module. As long as you stick to the Plug contract,
your module can be plugged in to the application.
Now you can do things like check to see if the user is logged in before displaying a
login link. Or you could welcome them by name. Or you could limit their viewing of
user profiles.

# Layout Template 
The layout template wraps every page template of your site 





