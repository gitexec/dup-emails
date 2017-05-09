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
    if emails.values.count == 1
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
    emails_sorted = emails.values
    while iterator < emails_sorted.size do
      unless noDupsEmails.has_value? emails_sorted[iterator]
        noDupsEmails[email_id.to_s] = emails_sorted[iterator]
        email_id += 1
      end
      #optimization
      if emails_sorted[iterator] == emails_sorted[iterator+1]
        iterator += 2
      else
        iterator += 1
      end
    end
    noDupsEmails
  end

end

#optimization
# def quick_sort emails
#     return emails.length 
# quick_sort array
#  rurn if emty
#  quick_sort array, 0, array.size
# end

# quick_sort array, lo, hi
#   if lo > hi
#     return
#   end

#   partition = partition array lo, hi
#   quick_sort array lo, partition - 1
#   quick_sort array partition + 1, hi
#   return
# end

# partition array, lo, hi
#   i = lo;
#   j = hi;
#   pivot = array[lo]

#   while true
#     while array[i] < pivot
#       i += 1
#       if i == hi 
#         break
#       end
#     end
#     while array[j] > pivot && j > lo
#       j += 1
#     end

#     swap array lo, hi
#     if lo >= hi 
#       break
# end


