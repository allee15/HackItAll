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

app = Flask(_name_)


@app.route('/generate', methods=['GET'])
def generate_text():
    prompt = request.args.get('prompt', '')
    max_len = int(request.args.get('max_len', 20))
    # inputs = tokenizer.encode(prompt, return_tensors='pt')
    # outputs = model.generate(inputs, max_length=max_len, num_return_sequences=1)
    # generated_text = tokenizer.decode(outputs[0], skip_special_tokens=True)

    response = co.generate(
        model='command-nightly',
        prompt=prompt,
        max_tokens=max_len
    )

    # Return the generated text as JSON
    return jsonify({'generated_text': response.generations[0].text})


@app.route('/tap', methods=['POST'])
def tap():
    data = request.get_json()
    x_start = data.get('x_start')
    y_start = data.get('y_start')
    x_end = data.get('x_end')
    y_end = data.get('y_end')
    x = data.get('x')
    y = data.get('y')
    roll = data.get('roll')
    pitch = data.get('pitch')

    # todo process
    print(
        f"x_start: {x_start}, y_start: {y_start}, x_end: {x_end}, y_end: {y_end}, x: {x}, y: {y}, roll: {roll}, pitch: {pitch}")

    return jsonify({"tap": True})


@app.route('/tap_all', methods=['POST'])
def tap_all():
    data = request.get_json()
    all_coords = data.get('all_coords')

    # todo process
    print(f"all_coords: {all_coords}")

    return jsonify({"tap_all": True})


@app.route('/user_error', methods=['GET'])
def user_taps():
    # todo get from trained model
    return jsonify({
        'user_error': False
    })


if _name_ == '_main_':
    app.run(debug=True)