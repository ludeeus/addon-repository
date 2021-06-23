from flask import Flask, render_template, request
app = Flask(__name__,  template_folder='.')

app.config['MAX_CONTENT_PATH'] = 2397234073204
app.config['UPLOAD_FOLDER'] = "/data"

@app.route('/')
def upload():
   return render_template('upload.html')
	
@app.route('/uploader', methods = ['POST'])
def upload_file():
   if request.method == 'POST':
      f = request.files['file']
      f.save(f.filename)
      return 'File uploaded successfully'
		
if __name__ == '__main__':
   app.run(debug = True, host='0.0.0.0', port=8099)