class Article
   
    include Mongoid::Document
    field :title,type: String
    field :text,type: String
    has_many :comments, autosave: true, dependent: :delete_all
    # def self.all
    #     @articles = Array.new
        
    #         Article.all.each do |article|
    #             puts article
    #             @articles.push article
    #         end
        
    #     return @articles
    #     client = Article.mongo_client
    #     result = client[:articles].find()
    #     if result.nil?
    #         puts "no articles"
    #         return @articles
    #     else
    #     result.each do |article|
    #         @articles.push article
    #         puts article
    #     end

    # end
    #  end
end

