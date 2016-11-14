class InvitationsController < ApplicationController
  before_action :authenticate_user!


  def new
    @party = Party.find(params[:party_id])
    @invitation = @party.invitations.build
  end

  def create
    @party = Party.find(params[:party_id]) #find the party
    email = user_params[:user_attributes][:email]
    @user = User.find_by(email: email) #check if there is already an user with that email address
    if @user.nil?  #if there is no user with that email address
      generated_password = Devise.friendly_token.first(8) #create a devise password
      @user = User.create!(:email => email, :password => generated_password) #create a new user witl that email
    end
    @invitation = @party.invitations.build(user_id: @user.id)
    if @invitation.save
      flash[:notice] = "Successfully created invitation."
      redirect_to party_url(@invitation.party_id)
    else
      render :action => 'new'
    end
  end
  private

  def invitation_params
    params.require(:invitation).permit(:party_id)
  end

  def user_params
    params.require(:invitation).permit(:user_attributes =>[:email])
  end
end
