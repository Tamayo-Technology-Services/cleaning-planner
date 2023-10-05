# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    #field :user, Types::UserType, null: false do
    #  argument :id, ID, required: true
    #end

    #def user(id: )
    #  User.find(id)
    #end



    # field :authors, [Types::AuthorType], null: false do
    #   description 'Find all authors'
    # end

    # field :author, Types::AuthorType, null: false do
    #   description 'Find a author by ID'
    #   argument :id, ID, required: true
    # end

    # field :books, [Types::BookType], null: false do
    #   description 'Find all authors'
    # end

    # field :book, Types::BookType, null: false do
    #   description 'Find a author by ID'
    #   argument :id, ID, required: true
    # end

    # def authors
    #   Author.all
    # end

    # def author(id:)
    #   Author.find(id)
    # end

    # def books
    #   Book.all
    # end

    # def book(id:)
    #   Book.find(id)
    # end
  end
end
