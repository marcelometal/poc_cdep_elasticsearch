# -*- coding: utf-8 -*-
#
# Copyright (c) 2018, Marcelo Jorge Vieira <metal@alucinados.com>
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Affero General Public License as
#  published by the Free Software Foundation, either version 3 of the
#  License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Affero General Public License for more details.
#
#  You should have received a copy of the GNU Affero General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

import logging

from elasticsearch import Elasticsearch
from elasticsearch import helpers


es = Elasticsearch([{'host': 'localhost', 'port': 9200}])

INDEX_NAME = 'cdep'
DOC_TYPE = 'expenses'
OBJECT_LIST_MAXIMUM_COUNTER = 5000


def search(prop, value):
    result = es.search(
        index=INDEX_NAME,
        body={'query': {'match': {prop: value}}}
    )
    logging.info(result)


def delete():
    es.indices.delete(index=INDEX_NAME, ignore=[400, 404])


def create():
    es.indices.create(index=INDEX_NAME, ignore=400)
    es.indices.put_settings(
        index=INDEX_NAME,
        body={
            'index.blocks.write': False,
            'index.blocks.read_only_allow_delete': False
        }
    )


def insert_candidates(actions):
    try:
        print helpers.bulk(es, actions, index=INDEX_NAME, doc_type=DOC_TYPE)
    except:
        es.indices.put_settings(
            index=INDEX_NAME,
            body={
                'index.blocks.write': False,
                'index.blocks.read_only_allow_delete': False
            }
        )
        print helpers.bulk(es, actions, index=INDEX_NAME, doc_type=DOC_TYPE)


def es_add_rows(rows):
    actions = []
    for row in rows:
        actions.append({
            '_op_type': 'index',
            '_index': INDEX_NAME,
            '_type': DOC_TYPE,
            '_source': row,
        })
        if len(actions) == OBJECT_LIST_MAXIMUM_COUNTER:
            insert_candidates(actions)
            actions = []
    if actions:
        insert_candidates(actions)
        actions = []
