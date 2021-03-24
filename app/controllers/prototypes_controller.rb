class PrototypesController < ApplicationController
  #ログイン状態によって表示するページを切り替えるコードでログインしていなければ、ログイン画面に遷移さる。
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  #ログインしていて、投稿したユーザーとログインユーザーが違かったら編集ページに行けないように制限している
  before_action :move_to_index, except: [:index, :new, :create, :show]

  #トップページを表示させるコード
  def index
    @prototypes = Prototype.all
  end

  #新規投稿、Prototypeのインスタンスを生成
  def new
    @prototype = Prototype.new
  end
  
  #新規投稿の保存、成功すればトップページに失敗すれば投稿画面へ
  def create
    @prototype = Prototype.new(prototyoe_params)
    if @prototype.save
      redirect_to root_path
    else
      render new_prototype_path
    end
  end
  
  #詳細ページへ遷移する
  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  #編集ページへ遷移する
  def edit
    @prototype = Prototype.find(params[:id])
  end
  
  #投稿情報が更新されたら、保存される
  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototyoe_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  #投稿の削除機能
  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to root_path
    end
  end

  private

  #Prototypeの情報から所得する制限をかけた
  def prototyoe_params
    params.require(:prototype).permit(:title, :catch_copy, :concept,:image).merge(user_id: current_user.id)
  end

  #編集ページにアクセスする際、投稿したユーザー出ないとアクセスでいないように条件分岐している
  def move_to_index
    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end
end