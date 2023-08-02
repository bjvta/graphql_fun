module Mutations
  class CreateUser < Mutations::BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: true 
    
    def resolve(name: , email:)
      user = User.new(name: name, email: email)

      if User.where(email: email).any?
        { user: nil, errors: ['User already exists']}
      elsif user.save
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
