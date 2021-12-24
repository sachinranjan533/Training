class CommentsController < ApplicationController

  def current_ability
    @current_ability ||= CommentAbility.new(current_user)
  end

  def index
    @post=Post.find_by(id: params[:post_id])
    @comments=@post.comments
  end

  def edit
    @comment=Comment.find(params[:id])
    authorize! :ud,@comment
    respond_to do |format|
      format.js
    end 
  end
  
  def update
    @comment=Comment.find(params[:id])
    respond_to do |format|
      if @comment.update(params.require(:comment).permit(:title,:body))
          format.js
      else
          format.js
      end
    end
  end

  def destroy
    @comment=Comment.with_deleted.find(params[:id])
    authorize! :ud, @comment
    if params[:value]=="temporary"
        @comment.destroy
    elsif params[:value]=="permanent"
        @comment.destroy_fully!
    end
    flash[:notice]="Comment Deleted Successfully"
    redirect_to posts_path
  end

  def new
    @comment=Comment.new
    # accesssing the post id.
    @post=Post.find(params[:post_id])
    respond_to do |format|
      format.js
    end 
  end

  def create
    @post=Post.find(params[:comment][:post_id])
    comment = Comment.new(params.require(:comment).permit(:title,:body,:post_id,:user_id))
    comment.user_id=current_user.id

    if comment.save
      @post.comments << comment
    end
    flash[:notice]="New comment is added successfully"
    redirect_to post_path(@post)
  end

end
