require 'flix/basic_user'
require 'flix/creatable'

module Flix
  class User < Flix::BasicUser
    include Flix::Creatable

  end
end