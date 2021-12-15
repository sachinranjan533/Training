class PostsController < ApplicationController
    #load_and_authorize_resource
    
    def current_ability
        @current_ability ||= PostAbility.new(current_user)
    end

    def show
        @post=Post.find(params[:id])
    end
    def index
        @posts=Post.all.paginate(page: params[:page],per_page: 2).order('created_at ASC')
        @posts_deleted=Post.only_deleted.paginate(page: params[:page],per_page: 2)
    end
    def new
        @post=Post.new
    end
    def create
        @post=Post.new(params.require(:post).permit(:title,:body,:avatar))
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
        authorize! :ud, @post 
        # ----------------------------
        # Post krna pr sbko edit kr skte h. #doubt
    end
    
    def update
        @post=Post.find(params[:id])
        @post.user_id=current_user[:id]
        if @post.update(params.require(:post).permit(:title,:body,:avatar))
            flash[:notice]="Post updated successfully"
            redirect_to post_path(@post)
        else
            render 'edit'   
        end
    end

    def destroy
        @post=Post.with_deleted.find(params[:id])
        authorize! :ud, @post
        if params[:value]=="temporary"
            @post.destroy
        elsif params[:value]=="permanent"
            @post.destroy_fully!
        end
        flash[:notice]="Post Delete successfully"
        redirect_to posts_path
    end

    def recovery
        Post.only_deleted.where(id: params[:post_id]).first.recover
        redirect_to posts_path
    end

end