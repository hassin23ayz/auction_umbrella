defmodule Auction.Password do
  import Pbkdf2

  def hash(password), do:
    hash_pwd_salt(password)
end
