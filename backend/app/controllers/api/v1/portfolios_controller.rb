class Api::V1::PortfoliosController < ApplicationController
    before_action :authenticate_user, except: [:index, :show, :create, :incremental_search, :search, :my_portfolios, :destroy, :user_portfolios]

    def index
        @new_arrival = merge_records_with_images(Portfolio.includes(user: :profile).limit(300).order("created_at DESC"))

        @high_creativity = merge_records_with_images(Portfolio.includes(user: :profile).where(id: AvgEval.search_columns(10, 
                                                            "creativity", 
                                                            "portfolio_id".intern)
                                                        ))
        @high_sociality = merge_records_with_images(Portfolio.includes(user: :profile).where(id: AvgEval.search_columns(10, 
                                                            "sociality", 
                                                            "portfolio_id".intern)
                                                        ))
        @high_skill = merge_records_with_images(Portfolio.includes(user: :profile).where(id: AvgEval.search_columns(10, 
                                                            "skill", 
                                                            "portfolio_id".intern)
                                                        ))
        @high_usability = merge_records_with_images((Portfolio.includes(user: :profile).where(id: AvgEval.search_columns(10, 
                                                            "usability", 
                                                            "portfolio_id".intern)
                                                        )))
        @high_business_oriented = merge_records_with_images(Portfolio.includes(user: :profile).where(id: AvgEval.search_columns(10, 
                                                            "business_oriented", 
                                                            "portfolio_id".intern)
                                                        ))
        @high_comprehensive = merge_records_with_images(Portfolio.includes(user: :profile).where(id: AvgEval.search_columns(10, 
                                                            "comprehensive_evaluation", 
                                                            "portfolio_id".intern)))
        render json: { 
                    newArrival: @new_arrival ,
                    highCreativity: @high_creativity ,
                    highSociality:  @high_sociality, 
                    highSkill: @high_skill ,
                    highUsability: @high_usability ,
                    highBusinessOriented: @high_business_oriented ,
                    highComprehensiveEvaluation: @high_comprehensive 
                }
    end
    
    #カテゴリは複数投稿できるので、配列で送られてくるはず。なので、PortfolioCategoryFormの処理で工夫が必要
    def create
            @portfolio_category_form = PortfolioCategoryForm.new(portfolios_params)
        if  @portfolio_category_form.invalid?
            render json: {status: 404, data:  @portfolio_category_form.errors.full_messages} 
        elsif  @portfolio_category_form.save
            render json: {status: 201}
        end
    end

    
    #updateアクションの実装並びに、PortfolioCategoryFormにupdateアクションの記述が必要
    def update 
        @portfolio_category_form = PortfolioCategoryForm.new(portfolios_params)
        if  @portfolio_category_form.invalid?
            render json: {status: 404, data:  @portfolio_category_form.errors.full_messages} 
        elsif  @portfolio_category_form.update
            render json: {status: 201}
        end
    end

    def incremental_search
        elements = {
            obj: Portfolio,
            keyword_column: 'title',
            keyword: params[:keyword],
        }
        @portfolios = SearchService.call(elements)
        render json: {data: @portfolios}
    end

    def my_portfolios
        current_user = User.find(params[:user_id])
        if current_user.portfolios.exists?
            @portfolios = merge_records_with_images(current_user.portfolios)
        else
            @portfolios = {data: ""}
        end         
        render json: {data: @portfolios ? @portfolios : {data: ""}}
    end

    def user_portfolios
        user = User.find(params[:id])
        if user.portfolios.exists?
            render json: {status: 200 , data: merge_records_with_images(user.portfolios)}
        elsif user.portfolios.invalid?
            render json: {status: 404 , data: user.portfolios.errors.full_messages}
        end
    end


    def destroy
        portfolio = Portfolio.find(params[:id])
        if portfolio.destroy
            render json: {satus: 200, data: portfolio.id}
        elsif portfolio.invalid?
            render json: {satus: portfolio.errors.full_messages}
        end
    end

    def search
        elements = {
            obj: Portfolio,
            keyword_column: 'title',
            keyword: params[:keyword],
        }
        @portfolios = SearchService.call(elements)

        if @portfolios.size > 0
            @with_images = @portfolios.map{|portfolio|
                merge_records_with_images(portfolio)
                }
            render json: {data: @with_images.flatten}
        else
            render json: {data: []}
        end
    end
    def show
        @portfolio = Portfolio.find(params[:id])
        @added_profile = @portfolio.user.profile ?  merge_records_with_profile(@portfolio) : @portfolio.attributes.merge({profile: {nickname: "", image: "", user_id: @portfolio.user.id}})
        @added_portfolio = @added_profile.merge({
            chats:  merge_records_with_profile(@portfolio.chats) ,
            avg_eval: @portfolio.avg_eval ? @portfolio.avg_eval : {sociality: 0, usability: 0,business_oriented: 0, creativity: 0,skill: 0,comprehensive_evaluation: 0},
            images:  @portfolio.images.attached? ? url_for(@portfolio.images.last) : "",
            categories: @portfolio.categories ? @portfolio.categories : ""
            })
        #のちに「良いね」も一緒にrenderする予定
        render json: {status: 200, data:  @added_portfolio}
    end


    private
    def portfolios_params
        # params.permit(:title, :description, :site_url, :github_url, :user_id, :images , :name)
        params.permit(:id ,:title, :description, :site_url, :github_url, :user_id, :images, :name, :user_id)
    end

end
