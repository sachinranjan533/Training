class CommentsController < ApplicationController

  def current_ability
    @current_ability ||= CommentAbility.new(current_user)
  end

  def edit
    @comment=Comment.find(params[:id])
    authorize! :ud,@comment
  end
  
  def update
    @comment=Comment.find(params[:id])
    if @comment.update(params.require(:comment).permit(:title,:body))
      flash[:notice]="Comment Update Successfully"
      redirect_to posts_path
    else
      flash[:notice]="Comment not able to Update"
      redirect_to 'edit'
    end
  end

  def destroy
    @comment=Comment.find(params[:id])
    authorize! :ud,@comment
    @comment.destroy
    flash[:notice]="Comment Deleted Successfully"
    redirect_to posts_path
  end

  def new
    @comment=Comment.new
    # accesssing the post id.
    @post=Post.find(params[:post_id])
  end

  def create
    @post=Post.find(params[:comment][:post_id])
    comment = Comment.new(params.require(:comment).permit(:title,:body,:post_id,:user_id))
    comment.user_id=@post.user_id

    if comment.save
      @post.comments << comment
    end
    flash[:notice]="New comment is added successfully"
    redirect_to post_path(@post)
  end

end
