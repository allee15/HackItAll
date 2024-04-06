from flask import Flask, request, jsonify
# from transformers import AutoTokenizer, AutoModelForCausalLM, BitsAndBytesConfig
# import torch

# tokenizer = AutoTokenizer.from_pretrained("distilgpt2")
# model = AutoModelForCausalLM.from_pretrained("distilgpt2")

# from transformers import LlamaTokenizer, LlamaForCausalLM, AutoTokenizer, AutoModelForCausalLM
# import torch

# 5TYOkSNKhKPMrAGZHaDW8Ga6Zlq6tRu33WcU5rif

# tokenizer = AutoTokenizer.from_pretrained("huggyllama/llama-7b")
# model = AutoModelForCausalLM.from_pretrained("huggyllama/llama-7b")

import cohere
co = cohere.Client('5TYOkSNKhKPMrAGZHaDW8Ga6Zlq6tRu33WcU5rif')



app = Flask(__name__)

@app.route('/generate', methods=['GET'])
def generate_text():

    prompt = request.args.get('prompt', '')
    max_len = int(request.args.get('max_len', 20))
    # inputs = tokenizer.encode(prompt, return_tensors='pt')
    # outputs = model.generate(inputs, max_length=max_len, num_return_sequences=1)
    # generated_text = tokenizer.decode(outputs[0], skip_special_tokens=True)

    response = co.generate(
        model='command-nightly',
        prompt = prompt,
        max_tokens = max_len
    )

    # Return the generated text as JSON
    return jsonify({'generated_text': response.generations[0].text})


if __name__ == '__main__':
    app.run(debug=True)
