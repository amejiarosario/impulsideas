class ContactFormController < ApplicationController
  # POST /users
  # POST /users.json
  def create
    @user = ContactForm.new(params[:user])
 
    respond_to do |format|
      if @user.valid?
        # Tell the UserMailer to send a welcome email after save
        ContactFormMailer.notification_email(@user).deliver
 
        format.html { redirect_to(@user, notice: 'Email was successfully sent.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
