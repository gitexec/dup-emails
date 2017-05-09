class EmailCollection < ActiveRecord::Base
  belongs_to :user
  validate :remove_duplicated_emails

  protected
  
  #TODO:
  def remove_duplicated_emails
    # Java:
      # Set<String> removeDups(String[] emails){
      #   Set<String> noDupsEmails = new HashSet<>();
      #   for(String email : emails){
      #     noDupsEmails.add(email)
      #   }
      #   return noDupsEmails;
      # }
  end

end
