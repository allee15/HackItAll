from gensim.models.doc2vec import Doc2Vec
from nltk.tokenize import word_tokenize
import numpy as np

def augment_prompt(prompt):
    model= Doc2Vec.load("d2v.model")
    data = word_tokenize(prompt.lower())
    vector = model.infer_vector(data)

    similar_docs = model.docvecs.most_similar([vector], topn=3)

    g_paragraphs = np.load("g_paragraphs.npy")

    result = prompt + " Keep in mind that:"

    for similar_doc in similar_docs:
        result = result + '\n' + g_paragraphs[int(similar_doc[0])]
    result += prompt

    return result