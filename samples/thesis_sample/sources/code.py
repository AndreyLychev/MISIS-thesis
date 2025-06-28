def get_mean_precision(boost_f: List[float]) -> Tuple[float]:
    search_data['bm25f'] = search_data.apply(
        lambda row: BM25F(row['search_phrase_tokens'],
                          row['product_id'], boost_f), axis=1)
    
    return (
            search_data
        .sort_values('bm25f', ascending=False)
        .groupby('search_phrase', as_index=False)
        .head(30)
        .groupby('search_phrase', as_index=False)
        .agg({'relevance': 'mean'})
        .relevance
        .mean(),
    )