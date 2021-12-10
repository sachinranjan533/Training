class PostsController < ApplicationController
    #load_and_authorize_resource
    
    def current_ability
        @current_ability ||= PostAbility.new(current_user)
    end

    def show
        @post=Post.find(params[:id])
    end
    def index
        @posts=Post.all
    end
    def new
        @post=Post.new
    end
    def create
        @post=Post.new(params.require(:post).permit(:title,:body))
        @post.user_id=current_user[:id]
        if @post.save
            flash[:notice]="New post created successfully"
            redirect_to post_path(@post)
        else
            render 'new'   
        end         
    end
    
    def edit
        @post=Post.find(params[:id])
        #Post.accessible_by(current_ability, :ud)
        authorize! :ud, @post 
        # ----------------------------
        # Post krna pr sbko edit kr skte h. #doubt
    end
    
    def update
        @post=Post.find(params[:id])
        @post.user_id=current_user[:id]
        if @post.update(params.require(:post).permit(:title,:body))
            flash[:notice]="Post updated successfully"
            redirect_to post_path(@post)
        else
            render 'edit'   
        end
    end

    def destroy
        @post=Post.find(params[:id])
        authorize! :ud, @post
        @post.destroy
        flash[:notice]="Post Delete successfully"
        redirect_to posts_path
    end

end