class InvitationsController < ApplicationController
  before_action :authenticate_user!


  def new
    @party = Party.find(params[:party_id])
    @invitation = @party.invitations.build
  end

  def create
    @party = Party.find(params[:party_id]) #find the party
    email_list = user_params[:user_attributes][:email_list]
    emails = user_params[:user_attributes][:email]
      if !emails.nil?
      email_array = emails.split(/[\r\n ,]+/)
    else
      email_array = []
    end
    if !email_list.nil?
      email_array = email_array + email_list
    end
    email_array = email_array.uniq
    email_array.each do |email|
      if email != ""
        @user = User.find_by(email: email) #check if there is already an user with that email address
        if @user.nil?  #if there is no user with that email address
          generated_password = Devise.friendly_token.first(8) #create a devise password
          @user = User.create!(:email => email, :password => generated_password) #create a new user witl that email
        end
        @invitation = @party.invitations.build(user_id: @user.id)
        @invitation.save
      end
    end
    if @invitation.save
      flash[:notice] = "Successfully created invitation."
      redirect_to party_url(@invitation.party_id)
    else
      render :action => 'new'
    end
  end

  def callback
    @party = Party.find(1)
    @invitation = @party.invitations.build
    @contacts = request.env['omnicontacts.contacts']
    @emails = @contacts.map { |contact| [contact[:first_name], contact[:email]]  }
    @user = request.env['omnicontacts.user']

  end

  def failure
    @errors = request.env['errors']
  end
  private

  def invitation_params
    params.require(:invitation).permit(:party_id)
  end

  def user_params
    params.require(:invitation).permit(:user_attributes  => [:email,  :email_list =>[]])
  end
end
