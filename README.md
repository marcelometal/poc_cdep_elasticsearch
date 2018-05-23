# POC CDEP

## Instalação

1. Clone o repositôrio:

    ```
    git clone https://github.com/marcelometal/poc_cdep_elasticsearch.git
    ```

2. Crie um [*virtualenv*](http://virtualenvwrapper.readthedocs.org/en/latest/install.html):

    ```
    cd poc_cdep_elasticsearch
    mkvirtualenv poc_cdep_elasticsearch
    ```

3. Instale as dependências:

    ```
    make setup
    ```

4. Faça download dos dados (XML):

    ```
    make get_xmls
    ```
5. Para indexar os dados:

    ```
    make run
    ```
