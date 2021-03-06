setup:
	@pip install -U -r requirements.txt

delete-index:
	@curl -X DELETE "http://localhost:9200/cdep"

run:
	@python main.py

clean_pycs:
	@find . -name "*.pyc" -delete

get_xmls:
	@mkdir -p data
	@wget http://www.camara.gov.br/cotas/AnoAtual.zip -P data
	@wget http://www.camara.gov.br/cotas/AnoAnterior.zip -P data
	@wget http://www.camara.gov.br/cotas/AnosAnteriores.zip -P data
	@cd data && unzip "*.zip"


.PHONY:  setup delete-index run clean_pycs get_xmls
