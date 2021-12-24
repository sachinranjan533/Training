class PathsController < ApplicationController
    def index
        @users=User.all
    end
end