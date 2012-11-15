# encoding: UTF-8

class ProfilController < ApplicationController
  before_filter :get_user, :except => :show
  
  def show
    @user = User.find params[:id]
  end

  def edit
    if params[:user]
      @user.update_attributes(params[:user])
      redirect_to profil_path(@user.id, @user.slug), :notice => "Profil édité avec succès"
    end
  end

  def auth
    client = get_client
    
    request_token = client.request_token(:oauth_callback => import_profil_url)
    session[:rtoken]  = request_token.token
    session[:rsecret] = request_token.secret
    
    redirect_to client.request_token.authorize_url
  end
  
  def import
    client = get_client
    
    if session[:rtoken].nil?
      render :action => :auth
    else
      pin_code = params[:oauth_verifier]
      atoken, asecret = client.authorize_from_request(params[:oauth_token], session[:rsecret], pin_code)
      
      session[:rtoken]  = atoken
      session[:rsecret] = asecret
      
      @user.update_from_linkedin(client)
      
      redirect_to profil_path(@user.id, @user.slug), :notice => "Informations importées avec succès"
    end
  end
  
  private
    def get_user
      @user = User.find session[:user_id]
    end
    
    def get_client
      LinkedIn::Client.new(APP_CONFIG['api_key'], APP_CONFIG['api_secret'])
    end
end
