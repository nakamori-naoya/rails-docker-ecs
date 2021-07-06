class PortfolioCategoryForm
  include ActiveModel::Model
  attr_accessor :title, :description, :site_url, :github_url, :name, :images, :user_id, :name1

  with_options presence: true do
    validates :title, length: { in: 1..30 }
    validates :description ,length: { in: 1..400 }
    validates :site_url
    validates :github_url
    validates :name,  length: { in: 1..20 }
  end

  def save
    ActiveRecord::Base.transaction do
        portfolio = Portfolio.create!(
          title: title, description: description, 
          site_url: site_url, github_url: github_url, 
          user_id: user_id, images: [images]
        )
        
        #categoriesが複数送られてくるので、それを分割し、配列に格納
        names = name.split(',')
        names.map{|name|
          category = Category.where(name: name).first_or_initialize  
          category.save!
          PortfolioCategory.create!(portfolio_id: portfolio.id, category_id: category.id)
        }
    end
  end

end
