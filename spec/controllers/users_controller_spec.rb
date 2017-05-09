require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  emails = {}
  emails1 = {"0"=>{"alias"=>"test1@email.com"},
            "1"=>{"alias"=>"test2@email.com"},
           }
  emails2 = {"0"=>{"alias"=>"test1@email.com"},
          "1"=>{"alias"=>"test1@email.com"},
         }

  describe 'emails duplicates test' do
    it "it has not duplicates" do
      return_email = controller.remove_duplicated_email(emails).count
        expect(return_email).not_to eq(2)
    end

    it "should pass it has duplicates and removed them" do
      return_email = controller.remove_duplicated_email(emails2).count
        expect(return_email).to eq(1)
    end

  end
end
