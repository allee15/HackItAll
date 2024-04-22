import requests
from io import BytesIO
from pdfminer.high_level import extract_pages
from pdfminer.layout import LTTextContainer
from doc2vec_model_create import create_model
import numpy as np

def extract_paragraphs_from_pdf_url(pdf_url):
    # Fetch the PDF content from the URL
    response = requests.get(pdf_url)
    response.raise_for_status()  # Ensure the request was successful
    
    # Convert the PDF content to a BytesIO object
    pdf_file = BytesIO(response.content)
    
    # Extract paragraphs
    paragraphs = []
    for page_layout in extract_pages(pdf_file):
        for element in page_layout:
            if isinstance(element, LTTextContainer):
                paragraphs.append(element.get_text())
    
    return paragraphs

def filter_long_strings(strings):
    return [s for s in strings if len(s) > 256]

pdf_urls = [
    'https://www.nrbcommercialbank.com/downloads/Bank_Its%20Origin,%20Meaning,%20Objectives%20&%20Function.pdf',
    'https://stec.univ-ovidius.ro/html/anale/RO/wp-content/uploads/2019/02/28-2.pdf',
    'https://lib.ibs.ac.id/repository/banking-an-introduction.pdf',
    ] # Replace with your PDF URL

g_paragraphs = []

for pdf_url in pdf_urls:
    try:
        print("Starting...")
        l_paragraphs = extract_paragraphs_from_pdf_url(pdf_url)
        g_paragraphs += l_paragraphs
        print("Done")
    except:
        pass

if g_paragraphs:
    g_paragraphs = filter_long_strings(g_paragraphs)
    numpy_g_paragraphs = np.array(g_paragraphs)
    np.save('g_paragraphs', numpy_g_paragraphs)
    create_model(data=g_paragraphs)
else:
    print("No paragraphs found.")
