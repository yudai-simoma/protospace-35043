class CommentsController < ApplicationController

  #コメント機能の実装、保存されたらコメントを表示し詳細ページへ、保存されなくても詳細ページへ
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype.id)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show"
    end
  end
  

  private  
  
  #commentの情報から所得する制限をかけた
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end