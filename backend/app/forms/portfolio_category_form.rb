class PortfolioCategoryForm
  include ActiveModel::Model
  attr_accessor :title, :description, :site_url, :github_url, :name, :images, :user_id, :id

  with_options presence: true do
    validates :title, length: { in: 1..30 }
    validates :description ,length: { in: 1..400 }
    validates :site_url
    validates :github_url
    validates :name,  length: { in: 1..50 }
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

  def update
    ActiveRecord::Base.transaction do
        portfolio = Portfolio.find(id)
        portfolio.update!(
          title: title, description: description, 
          site_url: site_url, github_url: github_url, 
          user_id: user_id, images: [images]
        )
        PortfolioCategory.where(portfolio_id: portfolio.id).destroy_all
        #中間テーブルの該当ポートフォリオのデータをいったん削除してから、createする
        #このやり方は正しいのか？？？

        names = name.split(',')
        names.map{|name|
          category = Category.where(name: name).first_or_initialize  #whereで検索した条件のレコードが存在すればそのレコードのインスタンスを返し、存在しなければ新しくインスタンスを作るメソッド
          category.save!
          PortfolioCategory.create!(portfolio_id: portfolio.id, category_id: category.id)
        }
    end
  end

end
