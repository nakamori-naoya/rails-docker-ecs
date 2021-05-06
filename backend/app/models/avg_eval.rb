class AvgEval < ApplicationRecord
    belongs_to :portfolio

    def self.search_columns(number, condition, column) 
        limit(number).order("#{condition} DESC").pluck(column)
    end

    #各カラムの平均値の計算
    def self.avg(props, record , other )
        colums = [:sociality, :creativity, :usability, :business_oriented, :skill, :comprehensive_evaluation]
        colums.map { |data|
            datas = record.pluck(data)
            arrival = other[data] 
            props[data] = (datas.sum(0.0) + arrival)/ (datas.length + 1 )
        }
        return props
    end

end

#おそらくvalidationやコールバックはほとんど必要がない 
#理由：evalモデルに対して処理の後に呼び出しを想定しているため
#上記事情を考慮すると、別にevalモデルからの継承を行ってもいいが、継承を行うほど共通部分があるのかは微妙のためいったん継承は保留。
#平均を計算するロジックに関しては、5つの属性それぞれで使いまわせるようにしたい。

#単一テーブル継承のパターンなのか？？とも思い始めた。。。。。。いったんこれを考えるのはなし。
#値オブジェクトの話とかに突入しかねない気が・・・・
