class UsersController < ApplicationController

  #ユーザーの詳細情報へ遷移
  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes
  end
end
