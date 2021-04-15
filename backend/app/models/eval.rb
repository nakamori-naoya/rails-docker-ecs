class Eval < ApplicationRecord
    belongs_to :portfolio
    belongs_to :user
    #バリデーションの条件として0以上5以下になっているかを確認するのと presence true
    
    

    #ポートフォリオの評価項目の平均値を計算するのに使用したかったけど、なぜかmySqlエラーが起きる・・・・
    #原因は04/14現在で不明
    # def average(args)
    #     props = args[:props]
    #     array = args[:array]
    #     instance = args[:eval]
    #     array.map { |column|
    #         datas = instance.pluck(column)
    #        props[column] = datas.sum(0.0) / datas.length
    #     }
    #     return props
    # end

end
