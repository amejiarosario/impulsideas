class ContactFormController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  # POST /users
  # POST /users.json
  def create
    @user = ContactForm.new(params[:contact_form])

    respond_to do |format|
      if @user.valid?
        # Tell the UserMailer to send a welcome email after save
        ContactFormMailer.notification_email(@user).deliver
        format.html { redirect_to(@user, notice: 'Email was successfully sent.') }
        format.json { render json: "Email enviado correctamente." }
        format.js { render :create }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
