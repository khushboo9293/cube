class UsersController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:create]

  def index
    @users = User.all
  end


  def create
    @user = User.new(user_params)
    if @user.save
      render json: {:message => "User Created", :id => @user[:id]}, status: :ok
    else
      render json: {:message => "User Could not be Created"}, status: 422
    end


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name,:city)
    end

end
