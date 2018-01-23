class ArticlesController < ApplicationController

  #by  using the before_action method , we can tell rails to call the set_article method before anything esle
  #for the action edit, update, show , destroy
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update]
  def index
     @articles = Article.paginate(page: params[:page], per_page: 5)
     # @articles = Article.all
  end
   def new
     @article = Article.new
   end

   def create
      # render plain: params[:article].inspect
      @article = Article.new(article_params)
      @article.user = current_user()
      if @article.save
        flash["success"] = "Article was succesfullly created"
      redirect_to article_path(@article)
      else
        render :new
      end
   end

   def update
    if @article.update(article_params)
    flash[:success] = "Article was successfully updated"
    redirect_to article_path(@article)
  else
    render :edit
   end
   end

   def show
     # render plain: params[:id]
   end

   def edit
   end

   def destroy
     @article.destroy
     flash[:danger] = "Article was successfully deleted"
     redirect_to articles_path
   end

   private
     def set_article
       @article = Article.find(params[:id])
     end
     def article_params
       params.require(:article).permit(:title, :description)
     end

     def require_same_user
       #this ensure that this user given by the session matches the one in the database
       # by running before_action : require_user first, current_user is automatically available to us
       if current_user() != @article.user and !current_user.admin?
         flash[:danger] = "You can only edit or delete your own articles"
         redirect_to root_path
       end
end
end
