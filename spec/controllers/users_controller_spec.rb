require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  emails1 = {}
  emails2 = {}
  timedEmails = {}
  CAPACITY = 5000;
  # Java
  #  int CAPACITY = 100;
  #   
  #       Random rnd = new Random();
        
  #       for(int i = 0; i < CAPACITY; i++){
  #           System.out.println(rnd.nextInt(CAPACITY)); 
  #       }
  #INITIALIZE test variables
  CAPACITY.times do |index|
    timedEmails[index.to_s] = "test#{index.to_s}@email.com" 
  end
  emails1 = {"0"=>{"alias"=>"test1@email.com"},
            "1"=>{"alias"=>"test2@email.com"},
           }
  emails2 = {"0"=>{"alias"=>"test1@email.com"},
          "1"=>{"alias"=>"test1@email.com"},
         }
  
  describe 'emails duplicates test' do
    it "it has not duplicates" do
      return_email = controller.remove_duplicated_email(emails1).count
      expect(return_email).to eq(2)
    end

    it "has duplicates and remove them" do
      return_email = controller.remove_duplicated_email(emails2).count
      expect(return_email).to eq(1)
    end

    # #100k inputs under 1 sec
    #Currently failing! Need to Optimization
    #Im working on email[i] ^ email[i+1] approach for the sorted portion
    it "should perform under 1 sec for 100k inputs" do
      start_time = Time.now
      return_email = controller.remove_duplicated_email(timedEmails).count
      end_time = Time.now
      duraction = (end_time - start_time) * 1000
      expect(duraction).to be <= 1
    end
  end
end
