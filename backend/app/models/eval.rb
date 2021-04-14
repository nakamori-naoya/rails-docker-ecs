class Eval < ApplicationRecord
    belongs_to :portfolio
    belongs_to :user
    #バリデーションの条件として0以上5以下になっているかを確認するのと presence true
    
    

    #ポートフォリオの評価項目の平均値を計算するのに使用
    def average(args)
        props = args[:props]
        array = args[:array]
        array.map { |column|
            datas = self.pluck(column)
           props[column] = datas.sum(0.0) / datas.length
        }
        return props
    end

end
