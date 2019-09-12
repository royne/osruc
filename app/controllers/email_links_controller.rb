class EmailLinksController < ApplicationController
  def new
  end

  def create

    user = User.find_by(email: params[:email])
    if user
      @email_link = EmailLink.generate(user.email)
    else
      u = User.create(email: params[:email], password: Devise.friendly_token.first(6))
      @email_link = EmailLink.generate(u.email)
    end
    
    if @email_link
      redirect_to new_user_session_path, notice: "Email enviado a #{params[:email]}"
    else
      redirect_to new_user_session_path, notice: 'No existe el usuario'
    end
    
  end

  def validate
    email_link = EmailLink.where(token: params[:token]).where("expireted_at > ?", DateTime.now).first
    unless email_link
      return redirect_to new_user_session_path, notice: 'Link invalido o vencido'
    end

    sign_in(email_link.user, scope: :user)
    redirect_to root_path
  end
  
end
