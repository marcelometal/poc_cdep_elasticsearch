# biggest suppliers for some legislator at 2011 year

curl -H "Content-Type: application/json" -XPOST 'http://localhost:9200/cdep/_search?pretty' -d '
{
    "size": 0,
    "query": {
        "match": {
            "nuLegislatura": 2011,
            "txNomeParlamentar": "MARCOS ROGÉRIO"
        }
    },
    "aggs": {
        "by_txtCNPJCPF": {
            "terms": {
                "field": "txtCNPJCPF",
                "size": 10,
                "order": {
                      "total": "desc"
                  }
            },
            "aggs": {
                "total":  {
                    "sum": {
                        "field": "vlrDocumento"
                    }
                }
            }
        }
    }
}
'

# biggest suppliers

curl -H "Content-Type: application/json" -XPOST 'http://localhost:9200/cdep/_search?pretty' -d '
{
    "size": 0,
    "aggs": {
        "by_txtCNPJCPF": {
            "terms": {
                "field": "txtCNPJCPF",
                "size": 10,
                "order": {
                      "total": "desc"
                  }
            },
            "aggs": {
                "total":  {
                    "sum": {
                        "field": "vlrDocumento"
                    }
                }
            }
        }
    }
}
'

# all parties

curl -H "Content-Type: application/json" -XPOST 'http://localhost:9200/cdep/_search?pretty' -d '
{
    "size": 0,
    "aggs": {
        "langs" : {
            "terms": { "field": "sgPartido.keyword", "size": 50 }
        }
    }
}'

# all legislatures

curl -H "Content-Type: application/json" -XPOST 'http://localhost:9200/cdep/_search?pretty' -d '
{
    "size": 0,
    "aggs": {
        "langs": {
            "terms": { "field": "nuLegislatura", "size": 50 }
        }
    }
}'

# For 2011 legislature, sum by legislator

curl -H "Content-Type: application/json" -XPOST 'http://localhost:9200/cdep/_search?pretty' -d '
{
    "size": 0,
    "query": {
        "match": {
            "nuLegislatura": 2011
        }
    },
    "aggs": {
        "by_txtCNPJCPF": {
            "terms": {
                "field": "txtCNPJCPF"
            },
            "aggs": {
                "total":  {
                    "sum": {
                        "field": "vlrDocumento"
                    }
                }
            }
        }
    }
}
'

# sum by legislator

curl -H "Content-Type: application/json" -XPOST 'http://localhost:9200/cdep/_search?pretty' -d '
{
    "aggs": {
        "by_txtCNPJCPF": {
            "terms": {
                "field": "txtCNPJCPF"
            },
            "aggs": {
                "total":  {
                    "sum": {
                        "field": "vlrDocumento"
                    }
                }
            }
        }
    }
}
'
# sum by party

curl -H "Content-Type: application/json" -XPOST 'http://localhost:9200/cdep/_search?pretty  ' -d '
{
    "aggs": {
        "by_sgPartido": {
            "terms": {
                "field": "sgPartido.keyword"
            },
            "aggs": {
                "total":  {
                    "sum": {
                        "field": "vlrDocumento"
                    }
                }
            }
        }
    }
}
'

# sum by legislator name

curl -H "Content-Type: application/json" -XPOST 'http://localhost:9200/cdep/_search?pretty' -d '
{
    "aggs": {
        "by_txNomeParlamentar": {
            "terms": {
                "field": "txNomeParlamentar.keyword"
            },
            "aggs": {
                "total":  {
                    "sum": {
                        "field": "vlrDocumento"
                    }
                }
            }
        }
    }
}
'

# sum by legislator and legislature

curl -H "Content-Type: application/json" -XPOST 'http://localhost:9200/cdep/_search?pretty' -d '
{
    "aggs": {
        "by_txNomeParlamentar": {
            "terms": {
                "field": "txNomeParlamentar.keyword"
            },
            "aggs": {
                "by_nuLegislatura": {
                    "terms": {
                        "field": "nuLegislatura"
                    },
                    "aggs": {
                        "total": {
                            "sum": {
                                "field": "vlrDocumento"
                            }
                        }
                    }
                }
            }
        }
    }
}'
