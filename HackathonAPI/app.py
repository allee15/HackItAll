from flask import Flask, request, jsonify
from doc2vec_model_test import augment_prompt

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/augment-prompt', methods=['POST'])
def handle_augment_prompt():

    prompt = request.json['prompt']
    result = augment_prompt(prompt)
    
    return jsonify({'response': result})

@app.route('/current-user')
def handle_current_user():
    return jsonify({'response': 'Gigel Aeroport'})