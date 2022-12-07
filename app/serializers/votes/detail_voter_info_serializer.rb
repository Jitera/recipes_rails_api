module Votes
  class DetailVoterInfoSerializer < BaseSerializer
    attribute :info

    def info
      {
        vote_id: object.id,
        voter_id: object.voter_id,
        voter_email: object.voter_email
      }
    end
  end
end
