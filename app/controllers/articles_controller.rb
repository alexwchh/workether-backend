class ArticlesController < ApplicationController
    def index
        puts "getting all"
        @articles = Article.all 
        @articles.each do |article|
           puts article.title
        end
        render  json:@articles
    end
    def show
        @article = Article.find(params[:id])    
    end
    def new
        @article = Article.new
    end
    def create
     @article  = Article.new(articles_params)
     if @article.save
     redirect_to article_path(@article)#Article对象也可以redirectto showpage
     else
        render 'new'
     end
    end
    def edit 
        @article = Article.find(params[:id])    
    end
    def update
    @article = Article.find(params[:id])
    if @article.update_attributes(articles_params)
        redirect_to @article     #resource-oriented 意思是转向model record所代表show页面
        else       
        render 'edit'       
        end
    end
    def def destroy
        @article = Article.find(params[:id])
        if @article.destroy
            flash[:success] = 'Object was successfully deleted.'
            redirect_to articles_path
        else
            flash[:error] = 'Something went wrong'
            redirect_to articles_path
        end
    end
    
    private 
    def articles_params
        params.require(:article).permit(:title,:text)
    end
    
    
end
