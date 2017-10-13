class Collaborator < ActiveRecord::Base
    belongs_to :wiki
    belongs_to :user

    has_many :users, through: :collaborators

    delegate :email, :to => :user, prefix: true
end