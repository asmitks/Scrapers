import csv
from bs4 import BeautifulSoup
from requests import get
from tqdm import tqdm
a = []
scrape = [["S.no","PMID","Title","Abstract"]]
url = "https://www.ncbi.nlm.nih.gov/pubmed/"
cnt = 1
for i in tqdm(range(21,31434166)):
	try:
		response = get(url+str(i))
		html_soup = BeautifulSoup(response.text,'html.parser')
		abstract = html_soup.find_all('div',class_="abstr")
		title = html_soup.find_all('div',class_="rprt abstract")
		if(len(abstract)!=0 and len(title)!=0):
			a = abstract[0].p
			b = title[0].h1
			scrape.append([cnt,i,b,a])
			cnt+=1
			result = open('result2.csv','w',newline="")
			wr = csv.writer(result)
			wr.writerows(scrape)
	except:
		continue