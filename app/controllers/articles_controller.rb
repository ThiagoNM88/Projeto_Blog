class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
def new
  @article = Article.new
end
def create
  @article = Article.new(article_params)
  if @article.save
   flash[:success] = "Article was successfully created"
   redirect_to article_path(@article)
  else
   render 'new'
  end
end
def show
end
  before_action :require_user, except: [:show, :index]

def require_user
  if !logged_in?
    flash[:danger] = "You must be logged in to perform that action"
    redirect_to login_path
  end
end
def update
  if @article.update(article_params)
   flash[:success] = "Article was updated"
   redirect_to article_path(@article)
  else
   flash[:success] = "Article was not updated"
   render 'edit'
  end
end
def edit
  @article = Article.find(params[:id])
  # Adicionar a linha abaixo para adicionar o link para a lista de artigos
  @articles_path = articles_path
end
def index
  @articles = Article.paginate(page: params[:page], per_page: 3)
end
def destroy
  @article = Article.find(params[:id])
  @article.destroy
  flash[:success] = "Article was deleted"
  redirect_to articles_path
end
private
  def article_params
   params.require(:article).permit(:title, :description)
  end
def set_article
   @article = Article.find(params[:id])
  end
end