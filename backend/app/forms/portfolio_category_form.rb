class PortfolioCategoryForm

  include ActiveModel::Model
  attr_accessor :title, :description, :site_url, :github_url, :name, :images, :user_id

  with_options presence: true do
    validates :title
    validates :description
    validates :site_url
    validates :github_url
    validates :name
    validates :user_id
  end

  def save
    portfolio = Portfolio.create(title: title, description: description, 
                                site_url: site_url, github_url: github_url, 
                                user_id: user_id, images: images)
    category = Category.where(name: name).first_or_initialize
    category.save
    PortfolioCategory.create(portfolio_id: portfolio.id, category_id: category.id)
  end

  private

  # def portfolios_params
  #   params.permit(:title, :description, :site_url, :github_url)
  # end

  # def category_params
  #   params.permit(:title, :description, :site_url, :github_url)
  # end

end
