class SearchService
  class << self
    def call(ele)
      # ele = {
      #   obj: 検索対象のモデル,
      #   keyword: 検索ワード,
      #   keyword_column: ワード検索する対象のカラム,
      # }
      keyword_search(ele)
    end

    private

    def integration_search(ele)
      ele[:obj].where("#{ele[:keyword_column]} LIKE(?)", "%#{ele[:keyword]}%").where("#{ele[:id_column]} = ?", ele[:id])
    end

    def keyword_search(ele)
      ele[:obj].where("#{ele[:keyword_column]} LIKE(?)", "%#{ele[:keyword]}%")
    end

    def id_search(ele)
      ele[:obj].where("#{ele[:id_column]} = ?", ele[:id])
    end
  end
end