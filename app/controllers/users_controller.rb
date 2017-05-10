class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    #TODO
    # @emails = User.all(:select => :email)
  end

  def create
    emails = remove_duplicated_email params[:user][:email_collection_attributes]
    #TODO: Create signup process and write the rspecs
    user = User.new(user_params)
    if user.save
      flash.now[:notice] = "created successfully created"
      # redirect_to main_app.show_path
    else
      flash.now[:notice] = "No created"
    end
      redirect_to main_app.root_path
  end

  #TODO: Allow email generated automally to be whitelisted
  def user_params
    params.require(:user).permit(:name, email_collection_attributes: [:alias])
  end

  #TODO: make it private/protected.
  # protected
  
  def remove_duplicated_email emails
    if emails.blank?
      return
    end
    if emails.values.count <= 1
      return
    end
     # Java:
      # Set<String> removeDups(String[] emails){
      #   Set<String> noDupsEmails = new HashSet<>();
      #   for(String email : emails){
      #     noDupsEmails.add(email)
      #   }
      #   return noDupsEmails;
      # }
    #sacrify space for speed big O(n)
    # Leave the resulting list in the original order (same as the input).
    #The function should be able to handle 100,000 emails
    #addresses containing 
    #50% randomly placed duplicates 
    #in well under 1 second on a typical modern laptop.
    noDupsEmails = {}
    iterator = 0
    email_id = 0
    #working on the optimization solution
    emails_sorted = merge_sort emails.values
    while iterator < emails_sorted.size do
      noDupsEmails[email_id.to_s] = emails_sorted[iterator]
      email_id += 1
      #optimization
      if emails_sorted[iterator] == emails_sorted[iterator+1]
        iterator += 2
      else
        iterator += 1
      end
    end
    noDupsEmails
  end
  #TODO: improve memory uses
  def merge_sort emails
    if emails.size <= 1
      return emails
    end
    merging_sort(emails,0,emails.size-1)
  end

  def merging_sort emails, lo, hi
    if lo == hi
      return [emails[lo]]
    end
    #TODO: lo + (hi - lo)/2
    middle = (hi + lo)/2
    sort1 = merging_sort emails, lo, middle
    sort2 = merging_sort emails, middle + 1, hi
    merge sort1, sort2
  end

  def merge(sort1, sort2)
    index1 = 0
    index2 = 0
    result = []
    while index1 < sort1.size && index2 < sort2.length
      if sort1[index1] < sort2[index2]
        result[index1 + index2] = sort1[index1]
        index1 += 1
      else
        result[index1 + index2] = sort2[index2]
        index2 += 1
      end
    end
    while index1 < sort1.size
      result[index1 + index2] = sort1[index1]
      index1 += 1
    end
    while index2 < sort2.size
      result[index1 + index2] = sort2[index2]
      index2 += 1
    end
    result
  end
end
