#!/usr/bin/python3

from sys import argv
if len(argv) > 1:
    None
else:
    print('pon palabra a buscar como primer parametro')
    exit()
from requests import get
from bs4 import BeautifulSoup as soup
from re import sub
#from time import sleep


headers = {
	'User-Agent': 'Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101 Firefox/68.0'
}

url = 'https://www.wordreference.com/sinonimos/'

termino = url + argv[1]
peticion = get(termino, headers=headers)
#print(peticion)

criba = soup(peticion.content, 'html.parser')

resultado = criba.find('div', {'class' : 'trans'})

a = resultado.text
b = sub(argv[1], '', a)
#c = sub(argv[1], 'Antonimos', b)
#print(b)

sust = sub('Antónimos:', '\nAntónimos:', b )
print(sust)
