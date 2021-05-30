class AvgEval < ApplicationRecord
    belongs_to :portfolio

    def self.search_columns(number, condition, column) 
        limit(number).order("#{condition} DESC").pluck(column)
    end

    #各カラムの平均値の計算
    def calcurate(portfolio_id, records, other)
        avg_eval = portfolio_id
        attributes = delete_attributes_from(convert_attributes_to_array)
        attributes.map { |attribute|
            calcurate_avg(attribute, records.pluck(attribute), avg_eval, other[attribute] )
        }
        return avg_eval
    end


    #以下のプライベートメソッドは、AvgEvalの責務ではないよね！今後、切り出していく候補にします。
    private 
    def convert_attributes_to_array
        avg_eval = AvgEval.new
        new_array = avg_eval.attributes.keys
    end
    
    def delete_attributes_from(array)  #このメソッドもリファクタリングできるっちゃできる。どの属性を排除するかの部分
        new_attributes = array.slice(1, 6)
        return new_attributes
    end

    def calcurate_avg(attribute, datas ,hash, new_arrival)     
        hash[attribute] = (datas.sum(0.0) + new_arrival) / (datas.length + 1 )
    end
        

end

#おそらくvalidationやコールバックはほとんど必要がない 
#理由：evalモデルに対して処理の後に呼び出しを想定しているため
#上記事情を考慮すると、別にevalモデルからの継承を行ってもいいが、継承を行うほど共通部分があるのかは微妙のためいったん継承は保留。
#平均を計算するロジックに関しては、5つの属性それぞれで使いまわせるようにしたい。

#単一テーブル継承のパターンなのか？？とも思い始めた。。。。。。いったんこれを考えるのはなし。
